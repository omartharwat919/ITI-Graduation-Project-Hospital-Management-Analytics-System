using AutoMapper;
using Hospital.API.Dtos;
using Hospital.API.Models;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Hospital.API.Services
{
    public class PatientService : IPatientService
    {
        private readonly VortContext _context;
        private readonly IMapper _mapper;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public PatientService(VortContext context, IMapper mapper, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _mapper = mapper;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<List<PatientDto>> GetAllPatientsAsync(int? currentUserPatientId)
        {
            var query = _context.Patients.AsQueryable();

            if (currentUserPatientId.HasValue)
            {
                query = query.Where(p => p.PatientId == currentUserPatientId.Value);
            }

            var patients = await query.ToListAsync();
            return _mapper.Map<List<PatientDto>>(patients);
        }

        public async Task<PatientDto?> GetPatientByIdAsync(int id, int? currentUserPatientId)
        {
            if (currentUserPatientId.HasValue && id != currentUserPatientId.Value)
                return null;

            var patient = await _context.Patients.FindAsync(id);
            return patient == null ? null : _mapper.Map<PatientDto>(patient);
        }

        public async Task<PatientDto> CreatePatientAsync(CreatePatientDto dto)
        {
            var patient = _mapper.Map<Patient>(dto);
            patient.CreatedAt = DateTime.UtcNow;

            _context.Patients.Add(patient);
            await _context.SaveChangesAsync();

            return _mapper.Map<PatientDto>(patient);
        }

        public async Task<PatientDto?> UpdatePatientAsync(int id, UpdatePatientDto dto)
        {
            var patient = await _context.Patients.FindAsync(id);
            if (patient == null) return null;

            _mapper.Map(dto, patient);
            patient.UpdatedAt = DateTime.UtcNow;

            await _context.SaveChangesAsync();
            return _mapper.Map<PatientDto>(patient);
        }

        public async Task<bool> DeletePatientAsync(int id)
        {
            var patient = await _context.Patients.FindAsync(id);
            if (patient == null) return false;

            _context.Patients.Remove(patient);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
