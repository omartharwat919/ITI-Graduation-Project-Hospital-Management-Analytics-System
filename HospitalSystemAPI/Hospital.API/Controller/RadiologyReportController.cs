using Hospital.API.Models;
using Hospital.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Hospital.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RadiologyReportController : ControllerBase
    {
        private readonly IRadiologyReportService _radiologyService;
        private readonly VortContext _context;

        public RadiologyReportController(IRadiologyReportService radiologyService, VortContext context)
        {
            _radiologyService = radiologyService;
            _context = context;
        }

        [HttpGet]
        [Authorize(Policy = "VIEW_RADIOLOGY")]
        public async Task<IActionResult> Get()
        {
            int? patientId = null;
            var role = User.FindFirst(ClaimTypes.Role)?.Value;

            if (role == "Patient")
            {
                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
                if (int.TryParse(userIdClaim, out var userId))
                {
                    var user = await _context.Users.FirstOrDefaultAsync(u => u.UserId == userId);
                    if (user != null)
                        patientId = user.PatientId;
                }
            }

            var results = await _radiologyService.GetRadiologyReportsAsync(patientId);
            return Ok(results);
        }
    }
}
