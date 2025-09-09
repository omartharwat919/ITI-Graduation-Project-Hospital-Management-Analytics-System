using Hospital.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Hospital.API.Models;

namespace Hospital.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LabResultController : ControllerBase
    {
        private readonly ILabResultService _labResultService;

        public LabResultController(ILabResultService labResultService)
        {
            _labResultService = labResultService;
        }
[HttpGet("visit/{visitId}")]
[Authorize(Policy = "VIEW_LAB_RESULTS")]
public async Task<IActionResult> GetByVisitId(int visitId)
{
    var results = await _labResultService.GetLabResultsByVisitIdAsync(visitId);
    return Ok(results);
}



        [HttpGet]
        [Authorize(Policy = "VIEW_LAB_RESULTS")]
        public async Task<IActionResult> Get()
        {
            int? patientId = null;

            var role = User.FindFirst(ClaimTypes.Role)?.Value;
            if (role == "Patient")
            {
                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
                if (int.TryParse(userIdClaim, out var userId))
                {
                    // نجيب الـ patient_id من جدول Users
                    using (var context = new VortContext())
                    {
                        var user = context.Users.FirstOrDefault(u => u.UserId == userId);
                        if (user != null)
                            patientId = user.PatientId;
                    }
                }
            }

            var results = await _labResultService.GetLabResultsAsync(patientId);
            return Ok(results);
        }
    }
}
