using Hospital.API.Dtos;

namespace Hospital.API.Services
{
    public interface IRadiologyReportService
    {
        Task<List<RadiologyReportDto>> GetRadiologyReportsAsync(int? patientId = null);
    }
}
