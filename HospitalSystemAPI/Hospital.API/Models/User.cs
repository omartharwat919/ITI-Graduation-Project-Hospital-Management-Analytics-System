using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class User
{
    public int UserId { get; set; }

    public string Username { get; set; } = null!;

    public string PasswordHash { get; set; } = null!;

    public DateTime? CreatedAt { get; set; }

    public DateTime? LastLogin { get; set; }

    public int? EmployeeId { get; set; }

    public int? RoleId { get; set; }

    public int? PatientId { get; set; }

    public virtual ICollection<AuditLog> AuditLogs { get; set; } = new List<AuditLog>();

    public virtual Employee? Employee { get; set; }

    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();

    public virtual Patient? Patient { get; set; }

    public virtual Role? Role { get; set; }
}
