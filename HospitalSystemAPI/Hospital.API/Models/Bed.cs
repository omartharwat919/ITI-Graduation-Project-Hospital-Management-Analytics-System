using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Bed
{
    public int BedId { get; set; }

    public int? RoomId { get; set; }

    public string? BedNumber { get; set; }

    public string? Status { get; set; }

    public virtual Room? Room { get; set; }
}
