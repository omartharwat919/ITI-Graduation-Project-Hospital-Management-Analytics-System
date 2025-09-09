using Hospital.API.Models;
using Microsoft.AspNetCore.Mvc;

[Route("api/reports")]
[ApiController]
public class ReportsController : ControllerBase
{
    private readonly VortContext _context;
public ReportsController(VortContext context) => _context = context;

    [HttpGet("patient-visits")]
    public async Task<IActionResult> GetPatientVisitDiagnoses()
        => Ok(await _context.GetPatientVisitDiagnosesAsync());

    [HttpGet("doctors-by-specialization")]
    public async Task<IActionResult> GetDoctorsBySpecialization()
        => Ok(await _context.GetDoctorsBySpecializationAsync());

    [HttpGet("nurse-shift-assignments")]
    public async Task<IActionResult> GetNurseRoomShiftAssignments()
        => Ok(await _context.GetNurseRoomShiftAssignmentsAsync());
}
