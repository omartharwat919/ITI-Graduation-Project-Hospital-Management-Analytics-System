namespace Hospital.API.Dtos
{
    public class BillingSummaryDto
    {
        public int BillId { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal TotalPaid { get; set; }
        public decimal OutstandingAmount => TotalAmount - TotalPaid;

        public List<BillingServiceItemDto> Services { get; set; }
        public List<BillingPaymentDto> Payments { get; set; }
    }

    public class BillingServiceItemDto
    {
        public string ServiceName { get; set; }
        public decimal Amount { get; set; }
    }

    public class BillingPaymentDto
    {
        public string MethodName { get; set; }
        public decimal Amount { get; set; }
        public DateTime PaymentDate { get; set; }
    }
}
