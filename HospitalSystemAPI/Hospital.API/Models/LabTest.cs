using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class LabTest
{
    public int LabTestId { get; set; }

    public string? TestName { get; set; }

    public string? Description { get; set; }

    public int? DepartmentId { get; set; }

    public virtual Department? Department { get; set; }

    public virtual ICollection<TestResultDetail> TestResultDetails { get; set; } = new List<TestResultDetail>();
}
