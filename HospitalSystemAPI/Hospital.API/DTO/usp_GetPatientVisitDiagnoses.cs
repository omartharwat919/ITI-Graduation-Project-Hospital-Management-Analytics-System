public class PatientVisitDiagnosisDto
{
    public int PatientId { get; set; }
    public string FullName { get; set; }
    public DateTime VisitDate { get; set; }
    public int VisitId { get; set; }
    public string VisitType { get; set; }
    public string Reason { get; set; }
    public DateTime? DischargeDate { get; set; }
    public string DiagnosisText { get; set; }
    public DateTime? DiagnosisDate { get; set; }
}
