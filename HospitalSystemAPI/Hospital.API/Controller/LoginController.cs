using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Hospital.API.Dtos;
using Hospital.API.Models;
using Hospital.API.Services;
using System.Threading.Tasks;

namespace Hospital.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LoginController : ControllerBase
    {
        private readonly VortContext _context;
        private readonly IJwtTokenService _jwtService;

        public LoginController(VortContext context, IJwtTokenService jwtService)
        {
            _context = context;
            _jwtService = jwtService;
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginRequestDto request)
        {
            var user = _context.LoginUserResult
                .FromSqlInterpolated($"EXEC admin.LoginUser @Username={request.Username}, @Password={request.Password}")
                .AsEnumerable()
                .FirstOrDefault();

            if (user == null)
            {
                return Unauthorized("Invalid username or password.");
            }

            var loginUserModel = new LoginUserModel
            {
                UserId = user.UserId,
                Username = user.Username,
                RoleId = user.RoleId,
                RoleName = user.RoleName,
                Permissions = user.Permissions // CSV string e.g. "VIEW_USERS,MANAGE_USERS"
            };

            var token = _jwtService.GenerateToken(loginUserModel);

            return Ok(new
            {
                Token = token,
                User = new
                {
                    loginUserModel.UserId,
                    loginUserModel.Username,
                    loginUserModel.RoleName
                }
            });
        }
    }
}
