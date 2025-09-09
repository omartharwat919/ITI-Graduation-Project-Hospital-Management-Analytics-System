using AutoMapper;
using Hospital.API.Dtos;
using Hospital.API.Models;
using Microsoft.EntityFrameworkCore;

namespace Hospital.API.Services
{
    public class MedicalRecordService : IMedicalRecordService
    {
        private readonly VortContext _context;
        private readonly IMapper _mapper;

        public MedicalRecordService(VortContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<MedicalRecordDto?> GetByVisitIdAsync(int visitId, int? currentPatientId = null)
        {
            var query = _context.MedicalRecords
                .Include(r => r.Visit)
                .AsQueryable();

            if (currentPatientId.HasValue)
            {
                query = query.Where(r => r.Visit.PatientId == currentPatientId.Value);
            }

            var entity = await query.FirstOrDefaultAsync(r => r.VisitId == visitId);
            return entity == null ? null : _mapper.Map<MedicalRecordDto>(entity);
        }

        public async Task<MedicalRecordDto> CreateAsync(CreateMedicalRecordDto dto)
        {
            var entity = _mapper.Map<MedicalRecord>(dto);
            entity.CreatedAt = DateTime.UtcNow;

            _context.MedicalRecords.Add(entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<MedicalRecordDto>(entity);
        }

        public async Task<MedicalRecordDto?> UpdateAsync(int visitId, UpdateMedicalRecordDto dto)
        {
            var entity = await _context.MedicalRecords.FirstOrDefaultAsync(m => m.VisitId == visitId);
            if (entity == null) return null;

            _mapper.Map(dto, entity);
            entity.UpdatedAt = DateTime.UtcNow;

            await _context.SaveChangesAsync();
            return _mapper.Map<MedicalRecordDto>(entity);
        }
    }
}
