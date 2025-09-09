using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class MedicalRecord
{
    public int RecordId { get; set; }

    public int VisitId { get; set; }

    public string? DiagnosisSummary { get; set; }

    public string? TestSummary { get; set; }

    public string? RadiologySummary { get; set; }

    public string? ChronicConditions { get; set; }

    public string? Allergies { get; set; }

    public string? GeneralHealthStatus { get; set; }

    public string? TreatmentPlan { get; set; }

    public string? DoctorNotes { get; set; }

    public bool? FollowUpRequired { get; set; }

    public string? LifestyleNotes { get; set; }

    public int? CreatedBy { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual Employee? CreatedByNavigation { get; set; }

    public virtual Visit Visit { get; set; } = null!;
}
