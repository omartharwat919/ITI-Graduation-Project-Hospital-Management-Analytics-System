using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class RadiologyType
{
    public int RadiologyTypeId { get; set; }

    public string? TypeName { get; set; }

    public string? Description { get; set; }

    public int? DepartmentId { get; set; }

    public virtual Department? Department { get; set; }

    public virtual ICollection<RadiologyReport> RadiologyReports { get; set; } = new List<RadiologyReport>();
}
