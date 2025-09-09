using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Patient
{
    public int PatientId { get; set; }

    public string? FirstName { get; set; }

    public string? LastName { get; set; }

    public DateOnly? DateOfBirth { get; set; }

    public string? Gender { get; set; }

    public string? PhoneNumber { get; set; }

    public string? Email { get; set; }

    public string? Address { get; set; }

    public string? EmergencyContactName { get; set; }

    public string? EmergencyContactPhone { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Allergy> Allergies { get; set; } = new List<Allergy>();

    public virtual ICollection<AmbulanceRequest> AmbulanceRequests { get; set; } = new List<AmbulanceRequest>();

    public virtual ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual ICollection<ChronicCondition> ChronicConditions { get; set; } = new List<ChronicCondition>();

    public virtual ICollection<PatientInsurance> PatientInsurances { get; set; } = new List<PatientInsurance>();

    public virtual ICollection<User> Users { get; set; } = new List<User>();

    public virtual ICollection<Visit> Visits { get; set; } = new List<Visit>();
}
