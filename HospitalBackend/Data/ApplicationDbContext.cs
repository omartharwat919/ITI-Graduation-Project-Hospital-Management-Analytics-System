using Microsoft.EntityFrameworkCore;

namespace HospitalBackend.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        // لا يوجد DbSet حاليًا لأنك مش عايزة جداول EF
    }
}
