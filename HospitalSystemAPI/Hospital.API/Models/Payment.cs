using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Payment
{
    public int PaymentId { get; set; }

    public int? BillId { get; set; }

    public int? MethodId { get; set; }

    public decimal? Amount { get; set; }

    public DateTime? PaymentDate { get; set; }

    public int? ReceivedBy { get; set; }

    public virtual Bill? Bill { get; set; }

    public virtual PaymentMethod? Method { get; set; }

    public virtual Employee? ReceivedByNavigation { get; set; }
}
