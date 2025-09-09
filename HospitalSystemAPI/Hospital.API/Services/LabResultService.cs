using Hospital.API.Models;
using Hospital.API.Dtos;
using Microsoft.EntityFrameworkCore;

namespace Hospital.API.Services
{
    public class LabResultService : ILabResultService
    {
        private readonly VortContext _context;

        public LabResultService(VortContext context)
        {
            _context = context;
        }

        public async Task<List<LabResultDto>> GetLabResultsAsync(int? patientId = null)
        {
            var query = from result in _context.TestResultDetails
                        join test in _context.LabTests on result.LabTestId equals test.LabTestId
                        join visit in _context.Visits on result.VisitId equals visit.VisitId
                        where !patientId.HasValue || visit.PatientId == patientId
                        select new LabResultDto
                        {
                            TestName = test.TestName,
                            AttributeName = result.AttributeName,
                            AttributeValue = result.AttributeValue,
                            NormalRange = result.NormalRange,
                            ResultDate = result.ResultDate ?? DateTime.MinValue
                        };

            return await query.ToListAsync();
        }

        public async Task<IEnumerable<LabResultDto>> GetLabResultsByVisitIdAsync(int visitId)
{
    var query = from result in _context.TestResultDetails
                join test in _context.LabTests on result.LabTestId equals test.LabTestId
                join visit in _context.Visits on result.VisitId equals visit.VisitId
                where result.VisitId == visitId
                select new LabResultDto
                {
                    TestName = test.TestName,
                    AttributeName = result.AttributeName,
                    AttributeValue = result.AttributeValue,
                    NormalRange = result.NormalRange,
                    ResultDate = result.ResultDate ?? DateTime.MinValue
                };

    return await query.ToListAsync();
}

    }
}
