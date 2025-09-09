using System.Security.Claims;
using Hospital.API.Dtos;
using Hospital.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hospital.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VitalController : ControllerBase
    {
        private readonly IVitalService _vitalService;
        private readonly IHttpContextAccessor _http;

        public VitalController(IVitalService vitalService, IHttpContextAccessor http)
        {
            _vitalService = vitalService;
            _http = http;
        }

        [HttpGet]
        [Authorize(Policy = "VIEW_MEDICAL_RECORDS")]
        public async Task<IActionResult> GetAll()
        {
            var result = await _vitalService.GetAllVitalsAsync();
            return Ok(result);
        }

        [HttpGet("{visitId}")]
        [Authorize(Policy = "VIEW_MEDICAL_RECORDS")]
        public async Task<IActionResult> GetByVisitId(int visitId)
        {
            var result = await _vitalService.GetVitalByVisitIdAsync(visitId);
            if (result == null) return NotFound();
            return Ok(result);
        }

        [HttpPost]
        [Authorize(Policy = "EDIT_MEDICAL_RECORDS")]
        public async Task<IActionResult> Create(CreateVitalDto dto)
        {
            var userId = int.Parse(_http.HttpContext!.User.FindFirst(ClaimTypes.NameIdentifier)!.Value);
            var created = await _vitalService.CreateVitalAsync(dto, userId);
            return Ok(created);
        }

        [HttpPut("{visitId}")]
        [Authorize(Policy = "EDIT_MEDICAL_RECORDS")]
        public async Task<IActionResult> Update(int visitId, UpdateVitalDto dto)
        {
            var updated = await _vitalService.UpdateVitalAsync(visitId, dto);
            if (updated == null) return NotFound();
            return Ok(updated);
        }
    }
}
