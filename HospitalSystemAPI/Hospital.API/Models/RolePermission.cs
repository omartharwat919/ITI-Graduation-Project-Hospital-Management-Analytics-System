using System.ComponentModel.DataAnnotations.Schema;

namespace Hospital.API.Models
{
    [Table("RolePermissions", Schema = "admin")]
    public class RolePermission
    {
        [Column("role_id")]  // ← يطابق اسم العمود الحقيقي
        public int RoleId { get; set; }

       [Column("permission_id")]  // ← يطابق اسم العمود الحقيقي
        public int PermissionId {  get; set; }

        public Role Role { get; set; }
        public Permission Permission { get; set; }
    }
}
