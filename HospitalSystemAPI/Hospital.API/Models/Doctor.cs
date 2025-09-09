using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Doctor
{
    public int DoctorId { get; set; }

    public int? EmployeeId { get; set; }

    public string? LicenseNumber { get; set; }

    public int? YearsOfExperience { get; set; }

    public string? Education { get; set; }

    public int? SpecializationId { get; set; }

    public virtual ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    public virtual ICollection<Diagnosis> Diagnoses { get; set; } = new List<Diagnosis>();

    public virtual Employee? Employee { get; set; }

    public virtual ICollection<Prescription> Prescriptions { get; set; } = new List<Prescription>();

    public virtual Specialization? Specialization { get; set; }
}
