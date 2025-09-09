using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Insurance
{
    public int InsuranceId { get; set; }

    public string? CompanyName { get; set; }

    public string? PolicyNumber { get; set; }

    public string? CoverageType { get; set; }

    public string? ContactInfo { get; set; }

    public virtual ICollection<PatientInsurance> PatientInsurances { get; set; } = new List<PatientInsurance>();
}
