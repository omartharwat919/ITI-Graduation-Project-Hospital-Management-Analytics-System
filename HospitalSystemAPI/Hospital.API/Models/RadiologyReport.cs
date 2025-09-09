using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class RadiologyReport
{
    public int ReportId { get; set; }

    public int? VisitId { get; set; }

    public int? RadiologyTypeId { get; set; }

    public string? ImageUrl { get; set; }

    public string? ReportText { get; set; }

    public DateTime? ReportDate { get; set; }

    public virtual RadiologyType? RadiologyType { get; set; }

    public virtual Visit? Visit { get; set; }
}
