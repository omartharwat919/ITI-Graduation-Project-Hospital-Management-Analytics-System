// File: Services/BillingService.cs

using Hospital.API.Dtos;
using Hospital.API.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Hospital.API.Services
{
    public class BillingService : IBillingService
    {
        private readonly VortContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public BillingService(VortContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<List<BillingSummaryDto>> GetAllBillsAsync()
        {
            var bills = await _context.Bills
                .Include(b => b.Payments)
                .ThenInclude(p => p.Method)
                .Include(b => b.BillItems)
                .ThenInclude(i => i.Service)
                .ToListAsync();

            return bills.Select(b => new BillingSummaryDto
            {
                BillId = b.BillId,
                TotalAmount = b.TotalAmount ?? 0,
                TotalPaid = b.Payments.Sum(p => p.Amount ?? 0),
                Services = b.BillItems.Select(i => new BillingServiceItemDto
                {
                    ServiceName = i.Service?.ServiceName ?? "Unknown",
                    Amount = i.Amount ?? 0
                }).ToList(),
                Payments = b.Payments.Select(p => new BillingPaymentDto
                {
                    MethodName = p.Method?.MethodName ?? "Unknown",
                    Amount = p.Amount ?? 0,
                    PaymentDate = p.PaymentDate ?? DateTime.MinValue
                }).ToList()
            }).ToList();
        }

        public async Task<List<BillingSummaryDto>> GetMyBillsAsync()
        {
            var patientIdClaim = _httpContextAccessor.HttpContext?.User?
                .FindFirst("patient_id");

            if (patientIdClaim == null)
                throw new UnauthorizedAccessException("Access denied. Patient only endpoint.");

            int patientId = int.Parse(patientIdClaim.Value);

            var bills = await _context.Bills
                .Where(b => b.PatientId == patientId)
                .Include(b => b.Payments)
                .ThenInclude(p => p.Method)
                .Include(b => b.BillItems)
                .ThenInclude(i => i.Service)
                .ToListAsync();

            return bills.Select(b => new BillingSummaryDto
            {
                BillId = b.BillId,
                TotalAmount = b.TotalAmount ?? 0,
                TotalPaid = b.Payments.Sum(p => p.Amount ?? 0),
                Services = b.BillItems.Select(i => new BillingServiceItemDto
                {
                    ServiceName = i.Service?.ServiceName ?? "Unknown",
                    Amount = i.Amount ?? 0
                }).ToList(),
                Payments = b.Payments.Select(p => new BillingPaymentDto
                {
                    MethodName = p.Method?.MethodName ?? "Unknown",
                    Amount = p.Amount ?? 0,
                    PaymentDate = p.PaymentDate ?? DateTime.MinValue
                }).ToList()
            }).ToList();
        }
    }
}
