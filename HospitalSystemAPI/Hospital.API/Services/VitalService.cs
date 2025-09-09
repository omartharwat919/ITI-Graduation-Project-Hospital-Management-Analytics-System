using AutoMapper;
using Hospital.API.Dtos;
using Hospital.API.Models;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Hospital.API.Services
{
    public class VitalService : IVitalService
    {
        private readonly VortContext _context;
        private readonly IMapper _mapper;
        private readonly IHttpContextAccessor _http;

        public VitalService(VortContext context, IMapper mapper, IHttpContextAccessor http)
        {
            _context = context;
            _mapper = mapper;
            _http = http;
        }

        public async Task<List<VitalDto>> GetAllVitalsAsync()
        {
            var user = _http.HttpContext!.User;
            var role = user.FindFirst(ClaimTypes.Role)?.Value;

            if (role == "Patient")
            {
                var patientId = int.Parse(user.FindFirst("PatientId")!.Value);
                var visitIds = await _context.Visits
                    .Where(v => v.PatientId == patientId)
                    .Select(v => v.VisitId)
                    .ToListAsync();

                var vitals = await _context.VisitVitals
                    .Where(v => visitIds.Contains(v.VisitId))
                    .ToListAsync();

                return _mapper.Map<List<VitalDto>>(vitals);
            }

            // لو دكتور أو أدمن
            var all = await _context.VisitVitals.ToListAsync();
            return _mapper.Map<List<VitalDto>>(all);
        }

        public async Task<VitalDto?> GetVitalByVisitIdAsync(int visitId)
        {
            var user = _http.HttpContext!.User;
            var role = user.FindFirst(ClaimTypes.Role)?.Value;

            if (role == "Patient")
            {
                var patientId = int.Parse(user.FindFirst("PatientId")!.Value);
                var visit = await _context.Visits.FirstOrDefaultAsync(v => v.VisitId == visitId && v.PatientId == patientId);
                if (visit == null) return null;
            }

            var vital = await _context.VisitVitals.FirstOrDefaultAsync(v => v.VisitId == visitId);
            return vital == null ? null : _mapper.Map<VitalDto>(vital);
        }

        public async Task<VitalDto> CreateVitalAsync(CreateVitalDto dto, int recordedBy)
        {
            var vital = _mapper.Map<VisitVital>(dto);
            vital.RecordedBy = recordedBy;
            vital.RecordedAt = DateTime.UtcNow;

            _context.VisitVitals.Add(vital);
            await _context.SaveChangesAsync();

            return _mapper.Map<VitalDto>(vital);
        }

        public async Task<VitalDto?> UpdateVitalAsync(int visitId, UpdateVitalDto dto)
        {
            var vital = await _context.VisitVitals.FirstOrDefaultAsync(v => v.VisitId == visitId);
            if (vital == null) return null;

            _mapper.Map(dto, vital);
            await _context.SaveChangesAsync();

            return _mapper.Map<VitalDto>(vital);
        }
    }
}
