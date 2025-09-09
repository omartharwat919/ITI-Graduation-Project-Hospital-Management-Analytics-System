using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class BillItem
{
    public int BillItemId { get; set; }

    public int? BillId { get; set; }

    public int ServiceId { get; set; }

    public decimal? Amount { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Bill? Bill { get; set; }

    public virtual Service Service { get; set; } = null!;
}
