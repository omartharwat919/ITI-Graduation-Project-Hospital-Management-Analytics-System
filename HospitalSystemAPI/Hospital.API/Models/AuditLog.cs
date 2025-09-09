using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class AuditLog
{
    public int LogId { get; set; }

    public int? UserId { get; set; }

    public string? Action { get; set; }

    public string? EntityType { get; set; }

    public int? EntityId { get; set; }

    public DateTime? Timestamp { get; set; }

    public string? Details { get; set; }

    public virtual User? User { get; set; }
}
