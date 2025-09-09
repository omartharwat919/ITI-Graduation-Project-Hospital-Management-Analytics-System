namespace Hospital.API.Dtos
{
    public class MedicalRecordDto
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
    }

    public class CreateMedicalRecordDto
    {
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
    }

    public class UpdateMedicalRecordDto : CreateMedicalRecordDto {}
}
