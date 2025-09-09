using Microsoft.EntityFrameworkCore;
using HospitalBackend.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend", policy =>
    {
        policy.WithOrigins("http://localhost:3000") // React app بيشتغل على 3000
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials(); // ضروري لو بتستخدم Authorization
    });
});
var app = builder.Build();
app.UseCors("AllowFrontend");

// ✅ مهم جدًا ترتيب الخطوات:
app.UseRouting();          // 👈 ضروري جدًا
app.UseAuthorization();

app.MapControllers();      // 👈 لتفعيل الـ API endpoints

app.Run();



