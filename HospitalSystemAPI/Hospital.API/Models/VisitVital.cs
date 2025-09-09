using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class VisitVital
{
    public int VitalId { get; set; }

    public int VisitId { get; set; }

    public string? BloodType { get; set; }

    public decimal? BodyTemperature { get; set; }

    public int? BloodPressureSystolic { get; set; }

    public int? BloodPressureDiastolic { get; set; }

    public int? HeartRate { get; set; }

    public int? RespiratoryRate { get; set; }

    public int? BloodOxygenLevel { get; set; }

    public int? RecordedBy { get; set; }

    public DateTime? RecordedAt { get; set; }

    public virtual Employee? RecordedByNavigation { get; set; }

    public virtual Visit Visit { get; set; } = null!;
}
