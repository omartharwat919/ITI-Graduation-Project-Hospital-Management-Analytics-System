using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hospital.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SecureController : ControllerBase
    {
        [HttpGet]
        [Authorize] // 👈 هنا الحماية
        public IActionResult GetSecureData()
        {
            var username = User.Identity?.Name;

            return Ok(new
            {
                Message = "🎉 تم الوصول إلى API محمية",
                Username = username
            });
        }
    }
}
