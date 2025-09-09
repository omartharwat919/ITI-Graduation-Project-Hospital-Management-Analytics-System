using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Role
{
    public int RoleId { get; set; }

    public string? RoleCode { get; set; }

    public string? RoleNameEn { get; set; }
    public ICollection<RolePermission> RolePermissions { get; set; }  // دي اللي كانت ناقصة

    public virtual ICollection<User> Users { get; set; } = new List<User>();

    public virtual ICollection<Permission> Permissions { get; set; } = new List<Permission>();
}
