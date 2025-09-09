using Hospital.API.Dtos;

namespace Hospital.API.Services
{
    public interface IBillingService
{
    Task<List<BillingSummaryDto>> GetAllBillsAsync();               // لكل المستخدمين غير المرضى
    Task<List<BillingSummaryDto>> GetMyBillsAsync();                // للمريض فقط
}

}
