using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Specialization
{
    public int SpecializationId { get; set; }

    public string? Name { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Doctor> Doctors { get; set; } = new List<Doctor>();
}
