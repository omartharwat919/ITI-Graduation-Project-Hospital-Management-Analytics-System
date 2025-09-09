// File: Services/IJwtTokenService.cs
using Hospital.API.Models;

namespace Hospital.API.Services
{
    public interface IJwtTokenService
    {
        string GenerateToken(LoginUserModel user);
    }
}
