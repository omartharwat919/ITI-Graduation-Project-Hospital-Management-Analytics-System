using Hospital.API.Dtos;
using Hospital.API.Models;
using Microsoft.EntityFrameworkCore;

namespace Hospital.API.Services
{
    public class RadiologyReportService : IRadiologyReportService
    {
        private readonly VortContext _context;

        public RadiologyReportService(VortContext context)
        {
            _context = context;
        }

        public async Task<List<RadiologyReportDto>> GetRadiologyReportsAsync(int? patientId = null)
        {
            var query = from report in _context.RadiologyReports
                        join type in _context.RadiologyTypes
                            on report.RadiologyTypeId equals type.RadiologyTypeId
                        join visit in _context.Visits
                            on report.VisitId equals visit.VisitId
                        where patientId == null || visit.PatientId == patientId
                        select new RadiologyReportDto
                        {
                            RadiologyTypeName = type.TypeName,
                            ImageUrl = report.ImageUrl,
                            ReportText = report.ReportText
                        };

            return await query.ToListAsync();
        }
    }
}
