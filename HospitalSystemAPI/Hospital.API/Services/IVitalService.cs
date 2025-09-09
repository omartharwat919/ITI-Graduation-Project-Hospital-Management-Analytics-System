using Hospital.API.Dtos;

namespace Hospital.API.Services
{
    public interface IVitalService
    {
        Task<List<VitalDto>> GetAllVitalsAsync();
        Task<VitalDto?> GetVitalByVisitIdAsync(int visitId);
        Task<VitalDto> CreateVitalAsync(CreateVitalDto dto, int recordedBy);
        Task<VitalDto?> UpdateVitalAsync(int visitId, UpdateVitalDto dto);
    }
}
