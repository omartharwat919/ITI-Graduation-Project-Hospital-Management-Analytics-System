using Hospital.API.Dtos;
using Hospital.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace Hospital.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MedicalRecordController : ControllerBase
    {
        private readonly IMedicalRecordService _service;

        public MedicalRecordController(IMedicalRecordService service)
        {
            _service = service;
        }

        [HttpGet("{visitId}")]
        [Authorize(Policy = "VIEW_MEDICAL_RECORDS")]
        public async Task<IActionResult> GetByVisit(int visitId)
        {
            int? patientId = null;

            var role = User.FindFirst(ClaimTypes.Role)?.Value;
            if (role == "Patient")
            {
                patientId = int.Parse(User.FindFirst("patient_id")?.Value ?? "0");
            }

            var record = await _service.GetByVisitIdAsync(visitId, patientId);
            if (record == null) return NotFound();
            return Ok(record);
        }

        [HttpPost]
        [Authorize(Policy = "EDIT_MEDICAL_RECORDS")]
        public async Task<IActionResult> Create([FromBody] CreateMedicalRecordDto dto)
        {
            var created = await _service.CreateAsync(dto);
            return CreatedAtAction(nameof(GetByVisit), new { visitId = created.VisitId }, created);
        }

        [HttpPut("{visitId}")]
        [Authorize(Policy = "EDIT_MEDICAL_RECORDS")]
        public async Task<IActionResult> Update(int visitId, [FromBody] UpdateMedicalRecordDto dto)
        {
            var updated = await _service.UpdateAsync(visitId, dto);
            if (updated == null) return NotFound();
            return Ok(updated);
        }
    }
}
