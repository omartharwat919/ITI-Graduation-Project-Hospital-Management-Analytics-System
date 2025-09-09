using Hospital.API.Dtos;

namespace Hospital.API.Services
{
    public interface IPatientService
    {
        Task<List<PatientDto>> GetAllPatientsAsync(int? currentUserPatientId);
        Task<PatientDto?> GetPatientByIdAsync(int id, int? currentUserPatientId);
        Task<PatientDto> CreatePatientAsync(CreatePatientDto dto);
        Task<PatientDto?> UpdatePatientAsync(int id, UpdatePatientDto dto);
        Task<bool> DeletePatientAsync(int id);
    }
}
