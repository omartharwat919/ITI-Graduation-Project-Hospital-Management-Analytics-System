using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Service
{
    public int ServiceId { get; set; }

    public string ServiceName { get; set; } = null!;

    public string? Description { get; set; }

    public decimal StandardPrice { get; set; }

    public string? ServiceCategory { get; set; }

    public int? DepartmentId { get; set; }

    public bool? IsActive { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<BillItem> BillItems { get; set; } = new List<BillItem>();

    public virtual Department? Department { get; set; }
}
