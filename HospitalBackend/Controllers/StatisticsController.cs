using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace HospitalBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class StatisticsController : ControllerBase
    {
        private readonly string _connectionString;

        public StatisticsController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpGet("dashboard-metrics")]
        public IActionResult GetDashboardMetrics()
        {
            var result = new Dictionary<string, object>();

            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                var command = new SqlCommand(@"
                    SELECT 
                        (SELECT COUNT(*) FROM Patient.Patients) AS total_patients,
                        (SELECT COUNT(*) FROM Scheduling.Appointments WHERE CAST(appointment_time AS DATE) = CAST(GETDATE() AS DATE)) AS todays_appointments,
                        (SELECT COUNT(*) FROM Visit.Visits WHERE status = 'Active') AS active_visits,
                        (SELECT COUNT(*) FROM Logistics.Rooms WHERE status = 'Available') AS available_rooms,
                        (SELECT COUNT(*) FROM Admin.Employees) AS staff_members,
                        (SELECT ISNULL(SUM(p.amount), 0) FROM Billing.Payments p WHERE CAST(p.payment_date AS DATE) = CAST(GETDATE() AS DATE)) AS todays_revenue
                ", connection);

                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        result["total_patients"] = reader["total_patients"];
                        result["todays_appointments"] = reader["todays_appointments"];
                        result["active_visits"] = reader["active_visits"];
                        result["available_rooms"] = reader["available_rooms"];
                        result["staff_members"] = reader["staff_members"];
                        result["todays_revenue"] = reader["todays_revenue"];
                    }
                }
            }

            return Ok(result);
        }
    }
}





