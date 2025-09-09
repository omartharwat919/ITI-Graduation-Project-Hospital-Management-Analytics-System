using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Diagnosis
{
    public int DiagnosisId { get; set; }

    public int? VisitId { get; set; }

    public int? DoctorId { get; set; }

    public string? DiagnosisText { get; set; }

    public DateTime? DiagnosisDate { get; set; }

    public virtual Doctor? Doctor { get; set; }

    public virtual Visit? Visit { get; set; }
}
