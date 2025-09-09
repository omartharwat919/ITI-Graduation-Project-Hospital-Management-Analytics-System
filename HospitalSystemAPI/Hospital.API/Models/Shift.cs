using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Shift
{
    public int ShiftId { get; set; }

    public int? EmployeeId { get; set; }

    public string? ShiftDay { get; set; }

    public TimeOnly? StartTime { get; set; }

    public TimeOnly? EndTime { get; set; }

    public string? Location { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual Employee? Employee { get; set; }

    public virtual ICollection<NurseRoomAssignment> NurseRoomAssignments { get; set; } = new List<NurseRoomAssignment>();
}
