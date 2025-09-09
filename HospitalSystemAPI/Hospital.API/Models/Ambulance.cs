using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Ambulance
{
    public int AmbulanceId { get; set; }

    public string? VehicleNumber { get; set; }

    public string? Model { get; set; }

    public int? DriverId { get; set; }

    public bool? IsAvailable { get; set; }

    public string? Notes { get; set; }

    public virtual ICollection<AmbulanceRequest> AmbulanceRequests { get; set; } = new List<AmbulanceRequest>();

    public virtual Employee? Driver { get; set; }
}
