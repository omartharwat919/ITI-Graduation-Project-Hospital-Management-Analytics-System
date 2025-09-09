using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class TestResultDetail
{
    public int DetailId { get; set; }

    public int? VisitId { get; set; }

    public int? LabTestId { get; set; }

    public string? AttributeName { get; set; }

    public string? AttributeValue { get; set; }

    public string? NormalRange { get; set; }

    public DateTime? ResultDate { get; set; }

    public virtual LabTest? LabTest { get; set; }

    public virtual Visit? Visit { get; set; }
}
