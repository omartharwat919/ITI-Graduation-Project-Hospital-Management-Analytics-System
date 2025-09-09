using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Allergy
{
    public int AllergyId { get; set; }

    public int? PatientId { get; set; }

    public string? AllergyName { get; set; }

    public string? Severity { get; set; }

    public virtual Patient? Patient { get; set; }
}
