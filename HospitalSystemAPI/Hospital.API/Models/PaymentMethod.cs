using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class PaymentMethod
{
    public int MethodId { get; set; }

    public string? MethodName { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();
}
