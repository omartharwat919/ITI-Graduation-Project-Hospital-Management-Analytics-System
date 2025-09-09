using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Visit
{
    public int VisitId { get; set; }

    public int PatientId { get; set; }

    public int DepartmentId { get; set; }

    public DateTime? VisitDate { get; set; }

    public string? VisitType { get; set; }

    public string? Reason { get; set; }

    public string? Status { get; set; }

    public DateTime? DischargeDate { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual Department Department { get; set; } = null!;

    public virtual ICollection<Diagnosis> Diagnoses { get; set; } = new List<Diagnosis>();

    public virtual MedicalRecord? MedicalRecord { get; set; }

    public virtual Patient Patient { get; set; } = null!;

    public virtual ICollection<Prescription> Prescriptions { get; set; } = new List<Prescription>();

    public virtual ICollection<RadiologyReport> RadiologyReports { get; set; } = new List<RadiologyReport>();

    public virtual ICollection<TestResultDetail> TestResultDetails { get; set; } = new List<TestResultDetail>();

    public virtual ICollection<VisitRoom> VisitRooms { get; set; } = new List<VisitRoom>();

    public virtual VisitVital? VisitVital { get; set; }
}
