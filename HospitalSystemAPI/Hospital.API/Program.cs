using Microsoft.EntityFrameworkCore;
using Hospital.API.Models;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Hospital.API.Services;
using Hospital.API.Authorization; // لإضافة PermissionHandler
using Microsoft.AspNetCore.Authorization;
using Hospital.API.Mapping;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "Hospital API",
        Version = "v1"
    });

    // ✅ إضافة تعريف الـ Bearer Auth
    c.AddSecurityDefinition("Bearer", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT",
        In = Microsoft.OpenApi.Models.ParameterLocation.Header,
        Description = "ادخل التوكن هنا بصيغة: Bearer {your token}"
    });

    // ✅ إضافة Requirement على كل الـ endpoints
    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
        {
            new Microsoft.OpenApi.Models.OpenApiSecurityScheme
            {
                Reference = new Microsoft.OpenApi.Models.OpenApiReference
                {
                    Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});
builder.Services.AddAutoMapper(typeof(Program));

builder.Services.AddDbContext<VortContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<IPatientService, PatientService>();
builder.Services.AddAutoMapper(typeof(AutoMapperProfile));
builder.Services.AddScoped<IMedicalRecordService, MedicalRecordService>();
builder.Services.AddScoped<IVitalService, VitalService>();
builder.Services.AddScoped<IBillingService, BillingService>();
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<ILabResultService, LabResultService>();
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



// ✅ Register JWT Token Service
builder.Services.AddScoped<IJwtTokenService, JwtTokenService>();

// ✅ Register Permission Handler
builder.Services.AddSingleton<IAuthorizationHandler, PermissionHandler>();

// ✅ Register Authentication
builder.Services.AddAuthentication("Bearer")
    .AddJwtBearer("Bearer", options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!)) // ! to suppress nullable warning
        };
    });

// ✅ Register Authorization & Policies (Permissions)
builder.Services.AddAuthorization(options =>
{
    // كل Permission نعمل له Policy بنفس الاسم
    string[] permissions = new[]
    {
        "VIEW_PATIENTS", "EDIT_PATIENTS", "DELETE_PATIENTS", "ADD_VISIT",
        "VIEW_VISITS", "EDIT_VISITS", "VIEW_BILLS", "MANAGE_BILLS",
        "VIEW_USERS", "MANAGE_USERS", "ASSIGN_ROLES", "VIEW_APPOINTMENTS",
        "MANAGE_APPOINTMENTS", "VIEW_MEDICAL_RECORDS", "EDIT_MEDICAL_RECORDS","CREATE_MEDICAL_RECORDS","DELETE_MEDICAL_RECORDS",
        "PRESCRIBE_MEDICATION", "REQUEST_LAB_TEST", "VIEW_LAB_RESULTS",
        "REQUEST_RADIOLOGY", "VIEW_RADIOLOGY_RESULTS", "VIEW_DASHBOARD",
        "ACCESS_WEB_PANEL", "VIEW_REPORTS", "EXPORT_DATA", "VIEW_LOGS",
        "MANAGE_NOTIFICATIONS", "VIEW_SCHEDULE", "MANAGE_SHIFTS", "MANAGE_LEAVES",
        "SYSTEM_SETTINGS", "VIEW_ROOM_STATUS","VIEW_ALL_BILLS"
    };

    foreach (var permission in permissions)
    {
        options.AddPolicy(permission, policy =>
            policy.Requirements.Add(new PermissionRequirement(permission)));
    }
});

// ✅ Build the app
var app = builder.Build();

// Configure HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    Console.WriteLine($"Environment: {app.Environment.EnvironmentName}");
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.Use(async (context, next) =>
{
    var authHeader = context.Request.Headers["Authorization"].FirstOrDefault();
    Console.WriteLine($"[DEBUG] Authorization Header: {authHeader}");
    await next();
});
app.UseCors("AllowFrontend");

app.UseRouting();

// ✅ Middleware pipeline
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();
app.MapGet("/", () => "Welcome to Hospital System API");

app.Run();
