using Hospital.API.Dtos;
using Hospital.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace Hospital.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatientController : ControllerBase
    {
        private readonly IPatientService _patientService;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public PatientController(IPatientService patientService, IHttpContextAccessor httpContextAccessor)
        {
            _patientService = patientService;
            _httpContextAccessor = httpContextAccessor;
        }

        private int? GetCurrentUserPatientId()
        {
            var claim = _httpContextAccessor.HttpContext?.User?.FindFirst("PatientId");
            return claim != null ? int.Parse(claim.Value) : (int?)null;
        }

        [HttpGet]
        [Authorize(Policy = "VIEW_PATIENTS")]
        public async Task<IActionResult> GetAll()
        {
            var patientId = GetCurrentUserPatientId();
            var patients = await _patientService.GetAllPatientsAsync(patientId);
            return Ok(patients);
        }

        [HttpGet("{id}")]
        [Authorize(Policy = "VIEW_PATIENTS")]
        public async Task<IActionResult> GetById(int id)
        {
            var patientId = GetCurrentUserPatientId();
            var patient = await _patientService.GetPatientByIdAsync(id, patientId);
            if (patient == null) return Forbid();
            return Ok(patient);
        }

        [HttpPost]
        [Authorize(Policy = "MANAGE_USERS")]
        public async Task<IActionResult> Create(CreatePatientDto dto)
        {
            var created = await _patientService.CreatePatientAsync(dto);
            return CreatedAtAction(nameof(GetById), new { id = created.PatientId }, created);
        }

        [HttpPut("{id}")]
        [Authorize(Policy = "EDIT_PATIENTS")]
        public async Task<IActionResult> Update(int id, UpdatePatientDto dto)
        {
            var updated = await _patientService.UpdatePatientAsync(id, dto);
            if (updated == null) return NotFound();
            return Ok(updated);
        }

        [HttpDelete("{id}")]
        [Authorize(Policy = "DELETE_PATIENTS")]
        public async Task<IActionResult> Delete(int id)
        {
            var deleted = await _patientService.DeletePatientAsync(id);
            if (!deleted) return NotFound();
            return NoContent();
        }
    }
}
