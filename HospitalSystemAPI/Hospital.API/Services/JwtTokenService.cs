using Hospital.API.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.EntityFrameworkCore;

namespace Hospital.API.Services
{
    public class JwtTokenService : IJwtTokenService
    {
        private readonly IConfiguration _configuration;
        private readonly VortContext _context;

        public JwtTokenService(IConfiguration configuration, VortContext context)
        {
            _configuration = configuration;
            _context = context;
        }

        public string GenerateToken(LoginUserModel user)
{
    // 1. نجيب صلاحيات الـ Role من جدول RolePermissions
            var permissions = _context.RolePermissions
                .Where(rp => rp.RoleId == user.RoleId)
                .Include(rp => rp.Permission)
                .Select(rp => rp.Permission.PermissionCode)
                .ToList();

            // 2. نجهّز الـ claims العادية
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, user.UserId.ToString()),
                new Claim(ClaimTypes.Name, user.Username),
                new Claim(ClaimTypes.Role, user.RoleName)
            };

            // ✅ نضيف patient_id لو موجود
            if (user.PatientId.HasValue)
            {
                claims.Add(new Claim("patient_id", user.PatientId.Value.ToString()));
            }

            // ✅ ممكن تضيف employee_id لو حبيت لاحقًا
            

            // 3. نضيف الصلاحيات كـ claims
            foreach (var permission in permissions)
            {
                claims.Add(new Claim("permission", permission));
            }

            // 4. نكمل التوكن
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddHours(2),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

    }
}
