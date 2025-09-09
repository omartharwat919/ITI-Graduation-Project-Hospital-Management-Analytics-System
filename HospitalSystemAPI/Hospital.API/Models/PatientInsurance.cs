using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class PatientInsurance
{
    public int PatientInsuranceId { get; set; }

    public int? PatientId { get; set; }

    public int? InsuranceId { get; set; }

    public bool? IsActive { get; set; }

    public DateOnly? StartDate { get; set; }

    public DateOnly? EndDate { get; set; }

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual Insurance? Insurance { get; set; }

    public virtual Patient? Patient { get; set; }
}
