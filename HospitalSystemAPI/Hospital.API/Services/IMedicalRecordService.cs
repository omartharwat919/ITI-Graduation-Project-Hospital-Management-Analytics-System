using Hospital.API.Dtos;

namespace Hospital.API.Services
{
    public interface IMedicalRecordService
    {
        Task<MedicalRecordDto?> GetByVisitIdAsync(int visitId, int? currentPatientId = null);
        Task<MedicalRecordDto> CreateAsync(CreateMedicalRecordDto dto);
        Task<MedicalRecordDto?> UpdateAsync(int visitId, UpdateMedicalRecordDto dto);
    }
}
