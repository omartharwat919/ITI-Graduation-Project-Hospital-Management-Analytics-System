using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Room
{
    public int RoomId { get; set; }

    public string? RoomNumber { get; set; }

    public int? Floor { get; set; }

    public int? Capacity { get; set; }

    public string? RoomType { get; set; }

    public int? DepartmentId { get; set; }

    public string? Status { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Bed> Beds { get; set; } = new List<Bed>();

    public virtual Department? Department { get; set; }

    public virtual ICollection<NurseRoomAssignment> NurseRoomAssignments { get; set; } = new List<NurseRoomAssignment>();

    public virtual ICollection<VisitRoom> VisitRooms { get; set; } = new List<VisitRoom>();
}
