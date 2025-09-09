using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace Hospital.API.Models
{
    [Table("Permissions", Schema = "admin")] // ← غيّر الاسم إذا كان مختلف في قاعدة البيانات
    public class Permission
    {
        [Column("permission_id")]
        public int PermissionId { get; set; }

        [Column("permission_code")]
        public string? PermissionCode { get; set; }

        [Column("permission_description")]
        public string? PermissionDescription { get; set; }

        // علاقة many-to-many عبر جدول RolePermissions
        public virtual ICollection<RolePermission> RolePermissions { get; set; } = new List<RolePermission>();

        // علاقة مساعدة اختيارية إذا كنت بتربط مباشرة مع Roles
        public virtual ICollection<Role> Roles { get; set; } = new List<Role>();
    }
}
