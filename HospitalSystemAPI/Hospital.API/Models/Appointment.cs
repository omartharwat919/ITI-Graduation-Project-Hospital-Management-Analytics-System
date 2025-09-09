using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Appointment
{
    public int AppointmentId { get; set; }

    public int? PatientId { get; set; }

    public int? DoctorId { get; set; }

    public DateTime? AppointmentTime { get; set; }

    public string? Status { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Doctor? Doctor { get; set; }

    public virtual Patient? Patient { get; set; }
}
