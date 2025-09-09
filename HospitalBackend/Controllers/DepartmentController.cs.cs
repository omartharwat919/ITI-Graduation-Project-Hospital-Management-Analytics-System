using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace HospitalBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DepartmentController : ControllerBase
    {
        private readonly string _connectionString;

        public DepartmentController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpGet("status")]
        public IActionResult GetDepartmentStatus()
        {
            var results = new List<object>();

            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                var sql = @"
                    SELECT 
                        d.department_name,
                        COUNT(v.visit_id) AS active_patients,
                        CASE 
                            WHEN COUNT(v.visit_id) >= 15 THEN 'High'
                            WHEN COUNT(v.visit_id) >= 8 THEN 'Normal'
                            ELSE 'Low'
                        END AS pressure_level
                    FROM Visit.Visits v
                    JOIN Admin.Departments d ON v.department_id = d.department_id
                    WHERE v.status = 'Active'
                    GROUP BY d.department_name
                    ORDER BY active_patients DESC";

                using (var command = new SqlCommand(sql, connection))
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        results.Add(new
                        {
                            Department = reader["department_name"].ToString(),
                            ActivePatients = Convert.ToInt32(reader["active_patients"]),
                            Pressure = reader["pressure_level"].ToString()
                        });
                    }
                }
            }

            return Ok(results);
        }
    }
}
