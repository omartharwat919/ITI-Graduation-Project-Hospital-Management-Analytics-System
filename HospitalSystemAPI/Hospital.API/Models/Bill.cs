using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Bill
{
    public int BillId { get; set; }

    public int? PatientId { get; set; }

    public int? VisitId { get; set; }

    public decimal? TotalAmount { get; set; }

    public int? PatientInsuranceId { get; set; }

    public int? CreatedBy { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<BillItem> BillItems { get; set; } = new List<BillItem>();

    public virtual Employee? CreatedByNavigation { get; set; }

    public virtual Patient? Patient { get; set; }

    public virtual PatientInsurance? PatientInsurance { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual Visit? Visit { get; set; }
}
