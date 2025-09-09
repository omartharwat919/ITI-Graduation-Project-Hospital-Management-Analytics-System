using Hospital.API.Dtos;

namespace Hospital.API.Services
{
    public interface ILabResultService
    {
        Task<IEnumerable<LabResultDto>> GetLabResultsByVisitIdAsync(int visitId);

        Task<List<LabResultDto>> GetLabResultsAsync(int? patientId = null);
    }
}
