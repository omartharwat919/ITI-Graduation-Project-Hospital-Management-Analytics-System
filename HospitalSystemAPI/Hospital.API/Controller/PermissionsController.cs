using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Hospital.API.Models;
using Hospital.API.Dtos;

namespace Hospital.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PermissionsController : ControllerBase
    {
        private readonly VortContext _context;

        public PermissionsController(VortContext context)
        {
            _context = context;
        }

        [HttpGet("{username}")]
        public async Task<ActionResult<IEnumerable<UserPermissionDto>>> GetUserPermissions(string username)
        {
            var permissions = await _context.UserPermissions
                .FromSqlInterpolated($"EXEC admin.GetUserPermissionsByUsername @Username={username}")
                .ToListAsync();

            if (permissions == null || permissions.Count == 0)
            {
                return NotFound("No permissions found for this user.");
            }

            return Ok(permissions);
        }
    }
}
