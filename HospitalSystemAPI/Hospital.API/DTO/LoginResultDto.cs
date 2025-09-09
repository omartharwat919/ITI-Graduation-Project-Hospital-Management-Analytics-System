namespace Hospital.API.Dtos
{
    public class LoginResultDto
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public string Token { get; set; } // ← ضيف دي لو مش موجودة
        public string Permissions { get; set; } // ← هنا أيضًا

}

}
