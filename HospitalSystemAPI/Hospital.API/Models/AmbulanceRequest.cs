using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class AmbulanceRequest
{
    public int RequestId { get; set; }

    public int? PatientId { get; set; }

    public int? AmbulanceId { get; set; }

    public DateTime? RequestTime { get; set; }

    public string? Status { get; set; }

    public string? Destination { get; set; }

    public virtual Ambulance? Ambulance { get; set; }

    public virtual Patient? Patient { get; set; }
}
