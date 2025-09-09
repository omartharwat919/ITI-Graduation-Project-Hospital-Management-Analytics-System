using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class NurseRoomAssignment
{
    public int AssignmentId { get; set; }

    public int? NurseId { get; set; }

    public int? RoomId { get; set; }

    public DateTime? AssignedAt { get; set; }

    public int? ShiftId { get; set; }

    public virtual Nurse? Nurse { get; set; }

    public virtual Room? Room { get; set; }

    public virtual Shift? Shift { get; set; }
}
