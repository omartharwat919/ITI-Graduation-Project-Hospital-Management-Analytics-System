public class CreateVitalDto
{
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
}