namespace Hospital.API.Dtos
{
    public class LoginResponseDto
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }

        public List<UserPermissionDto> Permissions { get; set; }
    }
}
