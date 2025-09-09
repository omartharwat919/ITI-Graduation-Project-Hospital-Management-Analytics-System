using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Nurse
{
    public int NurseId { get; set; }

    public int? EmployeeId { get; set; }

    public string? LicenseNumber { get; set; }

    public int? ExperienceYears { get; set; }

    public string? Specialization { get; set; }

    public virtual ICollection<NurseRoomAssignment> NurseRoomAssignments { get; set; } = new List<NurseRoomAssignment>();
}
