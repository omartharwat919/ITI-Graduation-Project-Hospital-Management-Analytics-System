using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class ChronicCondition
{
    public int ConditionId { get; set; }

    public int? PatientId { get; set; }

    public string? ConditionName { get; set; }

    public DateOnly? DiagnosisDate { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual Patient? Patient { get; set; }
}
