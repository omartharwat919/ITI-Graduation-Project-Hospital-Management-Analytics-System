namespace Hospital.API.Models
{
    public class LoginUserModel
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
    public int? PatientId { get; set; }  // ✅ جديد

        public string Permissions { get; set; } // ✅ كده هيشتغل

    }
}
