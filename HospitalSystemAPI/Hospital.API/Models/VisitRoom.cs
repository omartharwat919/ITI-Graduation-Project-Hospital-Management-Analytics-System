using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class VisitRoom
{
    public int VisitRoomId { get; set; }

    public int? VisitId { get; set; }

    public int? RoomId { get; set; }

    public DateTime? StartTime { get; set; }

    public DateTime? EndTime { get; set; }

    public virtual Room? Room { get; set; }

    public virtual Visit? Visit { get; set; }
}
