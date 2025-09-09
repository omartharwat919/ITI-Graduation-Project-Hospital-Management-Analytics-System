// File: Controllers/BillingController.cs

using Hospital.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hospital.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BillingController : ControllerBase
    {
        private readonly IBillingService _billingService;

        public BillingController(IBillingService billingService)
        {
            _billingService = billingService;
        }

        // ✅ للمريض فقط
        [HttpGet("my")]
        [Authorize(Policy = "VIEW_BILLS")]
        public async Task<IActionResult> GetMyBills()
        {
            var result = await _billingService.GetMyBillsAsync();
            return Ok(result);
        }

        // ✅ لأي مستخدم عنده صلاحية يشوف كل الفواتير
        [HttpGet("all")]
        [Authorize(Policy = "VIEW_BILLS")]
        public async Task<IActionResult> GetAllBills()
        {
            var result = await _billingService.GetAllBillsAsync();
            return Ok(result);
        }
    }
}
