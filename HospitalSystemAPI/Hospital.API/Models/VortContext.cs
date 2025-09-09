using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Hospital.API.Dtos;

namespace Hospital.API.Models;

public partial class VortContext : DbContext
{
    public VortContext()
    {
    }
    
    public VortContext(DbContextOptions<VortContext> options)
        : base(options)
    {
    }
    public virtual DbSet<LoginUserModel> LoginUserResult { get; set; }

    public virtual DbSet<LoginResultDto> LoginResults { get; set; }
    
    public virtual DbSet<UserPermissionDto> UserPermissions { get; set; }

    public virtual DbSet<Allergy> Allergies { get; set; }

    public virtual DbSet<Ambulance> Ambulances { get; set; }

    public virtual DbSet<AmbulanceRequest> AmbulanceRequests { get; set; }

    public virtual DbSet<Appointment> Appointments { get; set; }

    public virtual DbSet<AuditLog> AuditLogs { get; set; }

    public virtual DbSet<Bed> Beds { get; set; }

    public virtual DbSet<Bill> Bills { get; set; }

    public virtual DbSet<BillItem> BillItems { get; set; }

    public virtual DbSet<ChronicCondition> ChronicConditions { get; set; }

    public virtual DbSet<Department> Departments { get; set; }

    public virtual DbSet<Diagnosis> Diagnoses { get; set; }

    public virtual DbSet<Doctor> Doctors { get; set; }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<Expense> Expenses { get; set; }

    public virtual DbSet<ExpenseCategory> ExpenseCategories { get; set; }

    public virtual DbSet<Insurance> Insurances { get; set; }

    public virtual DbSet<LabTest> LabTests { get; set; }

    public virtual DbSet<LeaveRequest> LeaveRequests { get; set; }

    public virtual DbSet<MedicalRecord> MedicalRecords { get; set; }

    public virtual DbSet<Notification> Notifications { get; set; }

    public virtual DbSet<Nurse> Nurses { get; set; }

    public virtual DbSet<NurseRoomAssignment> NurseRoomAssignments { get; set; }

    public virtual DbSet<Patient> Patients { get; set; }

    public virtual DbSet<PatientInsurance> PatientInsurances { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

    public virtual DbSet<PaymentMethod> PaymentMethods { get; set; }

    public virtual DbSet<Permission> Permissions { get; set; }

    public virtual DbSet<Prescription> Prescriptions { get; set; }

    public virtual DbSet<PrescriptionItem> PrescriptionItems { get; set; }

    public virtual DbSet<RadiologyReport> RadiologyReports { get; set; }

    public virtual DbSet<RadiologyType> RadiologyTypes { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Room> Rooms { get; set; }

    public virtual DbSet<Service> Services { get; set; }

    public virtual DbSet<Shift> Shifts { get; set; }

    public virtual DbSet<Specialization> Specializations { get; set; }

    public virtual DbSet<TestResultDetail> TestResultDetails { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<Visit> Visits { get; set; }

    public virtual DbSet<VisitRoom> VisitRooms { get; set; }

    public virtual DbSet<VisitVital> VisitVitals { get; set; }
    public  virtual DbSet<RolePermission> RolePermissions { get; set; }
    public virtual DbSet<PatientVisitDiagnosisDto> PatientVisitDiagnosis { get; set; }
    public virtual DbSet<DoctorBySpecializationDto> DoctorBySpecialization { get; set; }
    public virtual DbSet<NurseRoomShiftAssignmentDto> NurseRoomShiftAssignments { get; set; }
public async Task<List<PatientVisitDiagnosisDto>> GetPatientVisitDiagnosesAsync()
{
    return await PatientVisitDiagnosis
        .FromSqlRaw("EXEC usp_GetPatientVisitDiagnoses")
        .ToListAsync();
}

public async Task<List<DoctorBySpecializationDto>> GetDoctorsBySpecializationAsync()
{
    return await DoctorBySpecialization
        .FromSqlRaw("EXEC Get_Doctors_By_Specialization")
        .ToListAsync();
}

public async Task<List<NurseRoomShiftAssignmentDto>> GetNurseRoomShiftAssignmentsAsync()
{
    return await NurseRoomShiftAssignments
        .FromSqlRaw("EXEC Get_Nurse_Room_Shift_Assignments")
        .ToListAsync();
}

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server='DESKTOP-FTRHG51\\SQLEXPRESS';Database=VORT;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {



        modelBuilder.Entity<RolePermission>()
            .HasKey(rp => new { rp.RoleId, rp.PermissionId });

        modelBuilder.Entity<RolePermission>()
            .HasOne(rp => rp.Role)
            .WithMany(r => r.RolePermissions)
            .HasForeignKey(rp => rp.RoleId);

        modelBuilder.Entity<RolePermission>()
            .HasOne(rp => rp.Permission)
            .WithMany(p => p.RolePermissions)
            .HasForeignKey(rp => rp.PermissionId);
        modelBuilder.Entity<DoctorBySpecializationDto>().HasNoKey();
        modelBuilder.Entity<PatientVisitDiagnosisDto>().HasNoKey();
        modelBuilder.Entity<NurseRoomShiftAssignmentDto>().HasNoKey();
        



        modelBuilder.Entity<LoginUserModel>().HasNoKey();

        modelBuilder.Entity<LoginResultDto>().HasNoKey();
        modelBuilder.Entity<UserPermissionDto>().HasNoKey();

        modelBuilder.Entity<Allergy>(entity =>
        {
            entity.HasKey(e => e.AllergyId).HasName("PK__Allergie__ACDD0692BFFA1A0A");

            entity.ToTable("Allergies", "Patient");

            entity.Property(e => e.AllergyId).HasColumnName("allergy_id");
            entity.Property(e => e.AllergyName)
                .HasMaxLength(100)
                .HasColumnName("allergy_name");
            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.Severity)
                .HasMaxLength(50)
                .HasColumnName("severity");

            entity.HasOne(d => d.Patient).WithMany(p => p.Allergies)
                .HasForeignKey(d => d.PatientId)
                .HasConstraintName("FK__Allergies__patie__5441852A");
        });

        modelBuilder.Entity<Ambulance>(entity =>
        {
            entity.HasKey(e => e.AmbulanceId).HasName("PK__Ambulanc__F6624EFC027DDF0A");

            entity.ToTable("Ambulances", "Logistics");

            entity.Property(e => e.AmbulanceId).HasColumnName("ambulance_id");
            entity.Property(e => e.DriverId).HasColumnName("driver_id");
            entity.Property(e => e.IsAvailable).HasColumnName("is_available");
            entity.Property(e => e.Model)
                .HasMaxLength(50)
                .HasColumnName("model");
            entity.Property(e => e.Notes)
                .HasMaxLength(255)
                .HasColumnName("notes");
            entity.Property(e => e.VehicleNumber)
                .HasMaxLength(50)
                .HasColumnName("vehicle_number");

            entity.HasOne(d => d.Driver).WithMany(p => p.Ambulances)
                .HasForeignKey(d => d.DriverId)
                .HasConstraintName("FK_Ambulances_DriverID");
        });

        modelBuilder.Entity<AmbulanceRequest>(entity =>
        {
            entity.HasKey(e => e.RequestId).HasName("PK__Ambulanc__18D3B90F53EB67B3");

            entity.ToTable("Ambulance_Requests", "Logistics");

            entity.Property(e => e.RequestId).HasColumnName("request_id");
            entity.Property(e => e.AmbulanceId).HasColumnName("ambulance_id");
            entity.Property(e => e.Destination)
                .HasMaxLength(255)
                .HasColumnName("destination");
            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.RequestTime)
                .HasColumnType("datetime")
                .HasColumnName("request_time");
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .HasColumnName("status");

            entity.HasOne(d => d.Ambulance).WithMany(p => p.AmbulanceRequests)
                .HasForeignKey(d => d.AmbulanceId)
                .HasConstraintName("FK__Ambulance__ambul__06CD04F7");

            entity.HasOne(d => d.Patient).WithMany(p => p.AmbulanceRequests)
                .HasForeignKey(d => d.PatientId)
                .HasConstraintName("FK__Ambulance__patie__05D8E0BE");
        });

        modelBuilder.Entity<Appointment>(entity =>
        {
            entity.HasKey(e => e.AppointmentId).HasName("PK__Appointm__A50828FCCE48BDC0");

            entity.ToTable("Appointments", "Scheduling");

            entity.Property(e => e.AppointmentId).HasColumnName("appointment_id");
            entity.Property(e => e.AppointmentTime)
                .HasColumnType("datetime")
                .HasColumnName("appointment_time");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DoctorId).HasColumnName("doctor_id");
            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");

            entity.HasOne(d => d.Doctor).WithMany(p => p.Appointments)
                .HasForeignKey(d => d.DoctorId)
                .HasConstraintName("FK__Appointme__docto__3A4CA8FD");

            entity.HasOne(d => d.Patient).WithMany(p => p.Appointments)
                .HasForeignKey(d => d.PatientId)
                .HasConstraintName("FK__Appointme__patie__395884C4");
        });

        modelBuilder.Entity<AuditLog>(entity =>
        {
            entity.HasKey(e => e.LogId).HasName("PK__AuditLog__9E2397E0395DFEF7");

            entity.ToTable("AuditLogs", "Admin");

            entity.Property(e => e.LogId).HasColumnName("log_id");
            entity.Property(e => e.Action)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("action");
            entity.Property(e => e.Details).HasColumnName("details");
            entity.Property(e => e.EntityId).HasColumnName("entity_id");
            entity.Property(e => e.EntityType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("entity_type");
            entity.Property(e => e.Timestamp)
                .HasColumnType("datetime")
                .HasColumnName("timestamp");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.AuditLogs)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__AuditLogs__user___693CA210");
        });

        modelBuilder.Entity<Bed>(entity =>
        {
            entity.HasKey(e => e.BedId).HasName("PK__Beds__CFFED75F9C4800E1");

            entity.ToTable("Beds", "Logistics");

            entity.Property(e => e.BedId).HasColumnName("bed_id");
            entity.Property(e => e.BedNumber)
                .HasMaxLength(10)
                .HasColumnName("bed_number");
            entity.Property(e => e.RoomId).HasColumnName("room_id");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");

            entity.HasOne(d => d.Room).WithMany(p => p.Beds)
                .HasForeignKey(d => d.RoomId)
                .HasConstraintName("FK__Beds__room_id__47A6A41B");
        });

        modelBuilder.Entity<Bill>(entity =>
        {
            entity.HasKey(e => e.BillId).HasName("PK__Bills__D706DDB3D2731FF1");

            entity.ToTable("Bills", "Billing");

            entity.Property(e => e.BillId)
                .ValueGeneratedNever()
                .HasColumnName("bill_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.CreatedBy).HasColumnName("created_by");
            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.PatientInsuranceId).HasColumnName("patient_insurance_id");
            entity.Property(e => e.TotalAmount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("total_amount");
            entity.Property(e => e.VisitId).HasColumnName("visit_id");

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.Bills)
                .HasForeignKey(d => d.CreatedBy)
                .HasConstraintName("FK_Bills_CreatedBy");

            entity.HasOne(d => d.Patient).WithMany(p => p.Bills)
                .HasForeignKey(d => d.PatientId)
                .HasConstraintName("FK__Bills__patient_i__1DB06A4F");

            entity.HasOne(d => d.PatientInsurance).WithMany(p => p.Bills)
                .HasForeignKey(d => d.PatientInsuranceId)
                .HasConstraintName("FK__Bills__patient_i__1EA48E88");

            entity.HasOne(d => d.Visit).WithMany(p => p.Bills)
                .HasForeignKey(d => d.VisitId)
                .HasConstraintName("FK_Bills_Visits");
        });

        modelBuilder.Entity<BillItem>(entity =>
        {
            entity.HasKey(e => e.BillItemId).HasName("PK__Bill_Ite__4253A8690EBB9AE1");

            entity.ToTable("Bill_Items", "Billing");

            entity.Property(e => e.BillItemId)
                .ValueGeneratedNever()
                .HasColumnName("bill_item_id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("amount");
            entity.Property(e => e.BillId).HasColumnName("bill_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.ServiceId).HasColumnName("service_id");

            entity.HasOne(d => d.Bill).WithMany(p => p.BillItems)
                .HasForeignKey(d => d.BillId)
                .HasConstraintName("FK__Bill_Item__bill___282DF8C2");

            entity.HasOne(d => d.Service).WithMany(p => p.BillItems)
                .HasForeignKey(d => d.ServiceId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Bill_Item__servi__29221CFB");
        });

        modelBuilder.Entity<ChronicCondition>(entity =>
        {
            entity.HasKey(e => e.ConditionId).HasName("PK__Chronic___8527AB15E34466B1");

            entity.ToTable("Chronic_Conditions", "Patient");

            entity.Property(e => e.ConditionId).HasColumnName("condition_id");
            entity.Property(e => e.ConditionName)
                .HasMaxLength(100)
                .HasColumnName("condition_name");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DiagnosisDate).HasColumnName("diagnosis_date");
            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Patient).WithMany(p => p.ChronicConditions)
                .HasForeignKey(d => d.PatientId)
                .HasConstraintName("FK__Chronic_C__patie__571DF1D5");
        });

        modelBuilder.Entity<Department>(entity =>
        {
            entity.HasKey(e => e.DepartmentId).HasName("PK__Departme__C2232422FF9E1AAE");

            entity.ToTable("Departments", "Admin");

            entity.HasIndex(e => e.DepartmentName, "UQ__Departme__226ED157CA2A8D2F").IsUnique();

            entity.Property(e => e.DepartmentId).HasColumnName("department_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DepartmentName)
                .HasMaxLength(100)
                .HasColumnName("department_name");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.Location)
                .HasMaxLength(100)
                .HasColumnName("location");
            entity.Property(e => e.ManagerId).HasColumnName("manager_id");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(20)
                .HasColumnName("phone_number");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Manager).WithMany(p => p.Departments)
                .HasForeignKey(d => d.ManagerId)
                .HasConstraintName("FK_Departments_Employees");
        });

        modelBuilder.Entity<Diagnosis>(entity =>
        {
            entity.HasKey(e => e.DiagnosisId).HasName("PK__Diagnose__D49E32B494173F3C");

            entity.ToTable("Diagnoses", "Visit");

            entity.Property(e => e.DiagnosisId).HasColumnName("diagnosis_id");
            entity.Property(e => e.DiagnosisDate)
                .HasColumnType("datetime")
                .HasColumnName("diagnosis_date");
            entity.Property(e => e.DiagnosisText).HasColumnName("diagnosis_text");
            entity.Property(e => e.DoctorId).HasColumnName("doctor_id");
            entity.Property(e => e.VisitId).HasColumnName("visit_id");

            entity.HasOne(d => d.Doctor).WithMany(p => p.Diagnoses)
                .HasForeignKey(d => d.DoctorId)
                .HasConstraintName("FK__Diagnoses__docto__3E1D39E1");

            entity.HasOne(d => d.Visit).WithMany(p => p.Diagnoses)
                .HasForeignKey(d => d.VisitId)
                .HasConstraintName("FK__Diagnoses__visit__3D2915A8");
        });

        modelBuilder.Entity<Doctor>(entity =>
        {
            entity.HasKey(e => e.DoctorId).HasName("PK__Doctors__F39935649D8244E6");

            entity.ToTable("Doctors", "Staff");

            entity.HasIndex(e => e.EmployeeId, "UQ__Doctors__C52E0BA9B9B06EB9").IsUnique();

            entity.Property(e => e.DoctorId)
                .ValueGeneratedNever()
                .HasColumnName("doctor_id");
            entity.Property(e => e.Education)
                .HasMaxLength(255)
                .HasColumnName("education");
            entity.Property(e => e.EmployeeId).HasColumnName("employee_id");
            entity.Property(e => e.LicenseNumber)
                .HasMaxLength(100)
                .HasColumnName("license_number");
            entity.Property(e => e.SpecializationId).HasColumnName("specialization_id");
            entity.Property(e => e.YearsOfExperience).HasColumnName("years_of_experience");

            entity.HasOne(d => d.Employee).WithOne(p => p.Doctor)
                .HasForeignKey<Doctor>(d => d.EmployeeId)
                .HasConstraintName("FK_Doctors_EmployeeID");

            entity.HasOne(d => d.Specialization).WithMany(p => p.Doctors)
                .HasForeignKey(d => d.SpecializationId)
                .HasConstraintName("FK__Doctors__special__7C4F7684");
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.HasKey(e => e.EmployeeId).HasName("PK__Employee__C52E0BA87FDB5A35");

            entity.ToTable("Employees", "Admin");

            entity.HasIndex(e => e.NationalId, "UQ__Employee__9560E95D767192B8").IsUnique();

            entity.Property(e => e.EmployeeId).HasColumnName("employee_id");
            entity.Property(e => e.BirthDate).HasColumnName("birth_date");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DepartmentId).HasColumnName("department_id");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("email");
            entity.Property(e => e.EmpAddress)
                .HasMaxLength(255)
                .HasColumnName("emp_address");
            entity.Property(e => e.EmpStatus)
                .HasMaxLength(20)
                .HasDefaultValue("Active")
                .HasColumnName("emp_status");
            entity.Property(e => e.EmployeeType)
                .HasMaxLength(50)
                .HasColumnName("employee_type");
            entity.Property(e => e.FullName)
                .HasMaxLength(100)
                .HasColumnName("full_name");
            entity.Property(e => e.Gender)
                .HasMaxLength(10)
                .HasColumnName("gender");
            entity.Property(e => e.HireDate).HasColumnName("hire_date");
            entity.Property(e => e.NationalId)
                .HasMaxLength(20)
                .HasColumnName("national_id");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(20)
                .HasColumnName("phone_number");
            entity.Property(e => e.SeniorityLevel)
                .HasMaxLength(50)
                .HasColumnName("seniority_level");
            entity.Property(e => e.UpdatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Department).WithMany(p => p.Employees)
                .HasForeignKey(d => d.DepartmentId)
                .HasConstraintName("FK_Employees_Departments");
        });

        modelBuilder.Entity<Expense>(entity =>
        {
            entity.HasKey(e => e.ExpenseId).HasName("PK__Expenses__404B6A6BA5D6F1F2");

            entity.ToTable("Expenses", "Billing");

            entity.Property(e => e.ExpenseId).HasColumnName("expense_id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("amount");
            entity.Property(e => e.CategoryId).HasColumnName("category_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.ExpenseDate).HasColumnName("expense_date");
            entity.Property(e => e.RecordedBy).HasColumnName("recorded_by");
            entity.Property(e => e.UpdatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Category).WithMany(p => p.Expenses)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Expenses__catego__30C33EC3");

            entity.HasOne(d => d.RecordedByNavigation).WithMany(p => p.Expenses)
                .HasForeignKey(d => d.RecordedBy)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Expenses_RecordedBy");
        });

        modelBuilder.Entity<ExpenseCategory>(entity =>
        {
            entity.HasKey(e => e.CategoryId).HasName("PK__Expense___D54EE9B4490145BF");

            entity.ToTable("Expense_Categories", "Billing");

            entity.HasIndex(e => e.CategoryName, "UQ__Expense___5189E255BD53D4DA").IsUnique();

            entity.Property(e => e.CategoryId).HasColumnName("category_id");
            entity.Property(e => e.CategoryName)
                .HasMaxLength(100)
                .HasColumnName("category_name");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
        });

        modelBuilder.Entity<Insurance>(entity =>
        {
            entity.HasKey(e => e.InsuranceId).HasName("PK__Insuranc__58B60F45D8435CDD");

            entity.ToTable("Insurance", "Billing");

            entity.Property(e => e.InsuranceId)
                .ValueGeneratedNever()
                .HasColumnName("insurance_id");
            entity.Property(e => e.CompanyName)
                .HasMaxLength(100)
                .HasColumnName("company_name");
            entity.Property(e => e.ContactInfo)
                .HasMaxLength(100)
                .HasColumnName("contact_info");
            entity.Property(e => e.CoverageType)
                .HasMaxLength(50)
                .HasColumnName("coverage_type");
            entity.Property(e => e.PolicyNumber)
                .HasMaxLength(50)
                .HasColumnName("policy_number");
        });

        modelBuilder.Entity<LabTest>(entity =>
        {
            entity.HasKey(e => e.LabTestId).HasName("PK__Lab_Test__C9C2A9494800CBD5");

            entity.ToTable("Lab_Tests", "Clinical");

            entity.Property(e => e.LabTestId)
                .ValueGeneratedNever()
                .HasColumnName("lab_test_id");
            entity.Property(e => e.DepartmentId).HasColumnName("department_id");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.TestName)
                .HasMaxLength(100)
                .HasColumnName("test_name");

            entity.HasOne(d => d.Department).WithMany(p => p.LabTests)
                .HasForeignKey(d => d.DepartmentId)
                .HasConstraintName("FK__Lab_Tests__depar__74AE54BC");
        });

        modelBuilder.Entity<LeaveRequest>(entity =>
        {
            entity.HasKey(e => e.LeaveId).HasName("PK__Leave_Re__743350BC6DB0EDD3");

            entity.ToTable("Leave_Requests", "Admin");

            entity.Property(e => e.LeaveId).HasColumnName("leave_id");
            entity.Property(e => e.EmployeeId).HasColumnName("employee_id");
            entity.Property(e => e.EndDate).HasColumnName("end_date");
            entity.Property(e => e.LeaveType)
                .HasMaxLength(50)
                .HasColumnName("leave_type");
            entity.Property(e => e.Reason)
                .HasMaxLength(255)
                .HasColumnName("reason");
            entity.Property(e => e.RequestedAt)
                .HasColumnType("datetime")
                .HasColumnName("requested_at");
            entity.Property(e => e.StartDate).HasColumnName("start_date");
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .HasColumnName("status");

            entity.HasOne(d => d.Employee).WithMany(p => p.LeaveRequests)
                .HasForeignKey(d => d.EmployeeId)
                .HasConstraintName("FK_LeaveRequests_EmployeeID");
        });

        modelBuilder.Entity<MedicalRecord>(entity =>
        {
            entity.HasKey(e => e.RecordId).HasName("PK__Medical___BFCFB4DD4773F4B2");

            entity.ToTable("Medical_Records", "Visit");

            entity.HasIndex(e => e.VisitId, "UQ__Medical___375A75E0804AC994").IsUnique();

            entity.Property(e => e.RecordId).HasColumnName("record_id");
            entity.Property(e => e.Allergies).HasColumnName("allergies");
            entity.Property(e => e.ChronicConditions).HasColumnName("chronic_conditions");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.CreatedBy).HasColumnName("created_by");
            entity.Property(e => e.DiagnosisSummary).HasColumnName("diagnosis_summary");
            entity.Property(e => e.DoctorNotes).HasColumnName("doctor_notes");
            entity.Property(e => e.FollowUpRequired)
                .HasDefaultValue(false)
                .HasColumnName("follow_up_required");
            entity.Property(e => e.GeneralHealthStatus)
                .HasMaxLength(50)
                .HasColumnName("general_health_status");
            entity.Property(e => e.LifestyleNotes).HasColumnName("lifestyle_notes");
            entity.Property(e => e.RadiologySummary).HasColumnName("radiology_summary");
            entity.Property(e => e.TestSummary).HasColumnName("test_summary");
            entity.Property(e => e.TreatmentPlan).HasColumnName("treatment_plan");
            entity.Property(e => e.UpdatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
            entity.Property(e => e.VisitId).HasColumnName("visit_id");

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.MedicalRecords)
                .HasForeignKey(d => d.CreatedBy)
                .HasConstraintName("FK_MedicalRecords_CreatedBy");

            entity.HasOne(d => d.Visit).WithOne(p => p.MedicalRecord)
                .HasForeignKey<MedicalRecord>(d => d.VisitId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Medical_R__visit__57DD0BE4");
        });

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.HasKey(e => e.NotificationId).HasName("PK__Notifica__E059842FD12A4EC3");

            entity.ToTable("Notifications", "Scheduling");

            entity.Property(e => e.NotificationId).HasColumnName("notification_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.IsRead).HasColumnName("is_read");
            entity.Property(e => e.Message).HasColumnName("message");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Notifications)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Notificat__user___66603565");
        });

        modelBuilder.Entity<Nurse>(entity =>
        {
            entity.HasKey(e => e.NurseId).HasName("PK__Nurses__9BADE499A08CEDD2");

            entity.ToTable("Nurses", "Staff");

            entity.HasIndex(e => e.EmployeeId, "UQ__Nurses__C52E0BA9C1FB12D1").IsUnique();

            entity.Property(e => e.NurseId)
                .ValueGeneratedNever()
                .HasColumnName("nurse_id");
            entity.Property(e => e.EmployeeId).HasColumnName("employee_id");
            entity.Property(e => e.ExperienceYears).HasColumnName("experience_years");
            entity.Property(e => e.LicenseNumber)
                .HasMaxLength(100)
                .HasColumnName("license_number");
            entity.Property(e => e.Specialization)
                .HasMaxLength(100)
                .HasColumnName("specialization");
        });

        modelBuilder.Entity<NurseRoomAssignment>(entity =>
        {
            entity.HasKey(e => e.AssignmentId).HasName("PK__Nurse_Ro__DA89181408955F6C");

            entity.ToTable("Nurse_Room_Assignments", "Logistics");

            entity.Property(e => e.AssignmentId).HasColumnName("assignment_id");
            entity.Property(e => e.AssignedAt)
                .HasColumnType("datetime")
                .HasColumnName("assigned_at");
            entity.Property(e => e.NurseId).HasColumnName("nurse_id");
            entity.Property(e => e.RoomId).HasColumnName("room_id");
            entity.Property(e => e.ShiftId).HasColumnName("shift_id");

            entity.HasOne(d => d.Nurse).WithMany(p => p.NurseRoomAssignments)
                .HasForeignKey(d => d.NurseId)
                .HasConstraintName("FK__Nurse_Roo__nurse__04AFB25B");

            entity.HasOne(d => d.Room).WithMany(p => p.NurseRoomAssignments)
                .HasForeignKey(d => d.RoomId)
                .HasConstraintName("FK__Nurse_Roo__room___05A3D694");

            entity.HasOne(d => d.Shift).WithMany(p => p.NurseRoomAssignments)
                .HasForeignKey(d => d.ShiftId)
                .HasConstraintName("FK__Nurse_Roo__shift__0697FACD");
        });

        modelBuilder.Entity<Patient>(entity =>
        {
            entity.HasKey(e => e.PatientId).HasName("PK__Patients__4D5CE476459CE98F");

            entity.ToTable("Patients", "Patient");

            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.Address)
                .HasMaxLength(255)
                .HasColumnName("address");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DateOfBirth).HasColumnName("date_of_birth");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("email");
            entity.Property(e => e.EmergencyContactName)
                .HasMaxLength(100)
                .HasColumnName("emergency_contact_name");
            entity.Property(e => e.EmergencyContactPhone)
                .HasMaxLength(20)
                .HasColumnName("emergency_contact_phone");
            entity.Property(e => e.FirstName)
                .HasMaxLength(100)
                .HasColumnName("first_name");
            entity.Property(e => e.Gender)
                .HasMaxLength(10)
                .HasColumnName("gender");
            entity.Property(e => e.LastName)
                .HasMaxLength(100)
                .HasColumnName("last_name");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(20)
                .HasColumnName("phone_number");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
        });

        modelBuilder.Entity<PatientInsurance>(entity =>
        {
            entity.HasKey(e => e.PatientInsuranceId).HasName("PK__Patient___58CB24CA521A5123");

            entity.ToTable("Patient_Insurance", "Patient");

            entity.Property(e => e.PatientInsuranceId).HasColumnName("patient_insurance_id");
            entity.Property(e => e.EndDate).HasColumnName("end_date");
            entity.Property(e => e.InsuranceId).HasColumnName("insurance_id");
            entity.Property(e => e.IsActive)
                .HasDefaultValue(true)
                .HasColumnName("is_active");
            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.StartDate).HasColumnName("start_date");

            entity.HasOne(d => d.Insurance).WithMany(p => p.PatientInsurances)
                .HasForeignKey(d => d.InsuranceId)
                .HasConstraintName("FK__Patient_I__insur__5165187F");

            entity.HasOne(d => d.Patient).WithMany(p => p.PatientInsurances)
                .HasForeignKey(d => d.PatientId)
                .HasConstraintName("FK__Patient_I__patie__5070F446");
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("PK__Payments__ED1FC9EA8516BE21");

            entity.ToTable("Payments", "Billing");

            entity.Property(e => e.PaymentId)
                .ValueGeneratedNever()
                .HasColumnName("payment_id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("amount");
            entity.Property(e => e.BillId).HasColumnName("bill_id");
            entity.Property(e => e.MethodId).HasColumnName("method_id");
            entity.Property(e => e.PaymentDate)
                .HasColumnType("datetime")
                .HasColumnName("payment_date");
            entity.Property(e => e.ReceivedBy).HasColumnName("received_by");

            entity.HasOne(d => d.Bill).WithMany(p => p.Payments)
                .HasForeignKey(d => d.BillId)
                .HasConstraintName("FK__Payments__bill_i__3493CFA7");

            entity.HasOne(d => d.Method).WithMany(p => p.Payments)
                .HasForeignKey(d => d.MethodId)
                .HasConstraintName("FK__Payments__method__3587F3E0");

            entity.HasOne(d => d.ReceivedByNavigation).WithMany(p => p.Payments)
                .HasForeignKey(d => d.ReceivedBy)
                .HasConstraintName("FK_Payments_ReceivedBy");
        });

        modelBuilder.Entity<PaymentMethod>(entity =>
        {
            entity.HasKey(e => e.MethodId).HasName("PK__Payment___747727B6EE121755");

            entity.ToTable("Payment_Methods", "Billing");

            entity.Property(e => e.MethodId)
                .ValueGeneratedNever()
                .HasColumnName("method_id");
            entity.Property(e => e.MethodName)
                .HasMaxLength(50)
                .HasColumnName("method_name");
        });

        modelBuilder.Entity<Permission>(entity =>
        {
            entity.HasKey(e => e.PermissionId).HasName("PK__Permissi__E5331AFAADD31E89");

            entity.ToTable("Permissions", "Admin");

            entity.Property(e => e.PermissionId)
                .ValueGeneratedNever()
                .HasColumnName("permission_id");
            entity.Property(e => e.PermissionCode)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("permission_code");
            entity.Property(e => e.PermissionDescription)
                .HasMaxLength(200)
                .HasColumnName("permission_description");
        });

        modelBuilder.Entity<Prescription>(entity =>
        {
            entity.HasKey(e => e.PrescriptionId).HasName("PK__Prescrip__3EE444F875A11B21");

            entity.ToTable("Prescriptions", "Visit");

            entity.Property(e => e.PrescriptionId).HasColumnName("prescription_id");
            entity.Property(e => e.DoctorId).HasColumnName("doctor_id");
            entity.Property(e => e.IssueDate)
                .HasColumnType("datetime")
                .HasColumnName("issue_date");
            entity.Property(e => e.Notes)
                .HasMaxLength(255)
                .HasColumnName("notes");
            entity.Property(e => e.VisitId).HasColumnName("visit_id");

            entity.HasOne(d => d.Doctor).WithMany(p => p.Prescriptions)
                .HasForeignKey(d => d.DoctorId)
                .HasConstraintName("FK__Prescript__docto__41EDCAC5");

            entity.HasOne(d => d.Visit).WithMany(p => p.Prescriptions)
                .HasForeignKey(d => d.VisitId)
                .HasConstraintName("FK__Prescript__visit__40F9A68C");
        });

        modelBuilder.Entity<PrescriptionItem>(entity =>
        {
            entity.HasKey(e => e.ItemId).HasName("PK__Prescrip__52020FDD7F0A2EFC");

            entity.ToTable("PrescriptionItems", "Visit");

            entity.Property(e => e.ItemId).HasColumnName("item_id");
            entity.Property(e => e.Dosage)
                .HasMaxLength(100)
                .HasColumnName("dosage");
            entity.Property(e => e.Duration)
                .HasMaxLength(100)
                .HasColumnName("duration");
            entity.Property(e => e.Instructions)
                .HasMaxLength(255)
                .HasColumnName("instructions");
            entity.Property(e => e.MedicineName)
                .HasMaxLength(100)
                .HasColumnName("medicine_name");
            entity.Property(e => e.PrescriptionId).HasColumnName("prescription_id");

            entity.HasOne(d => d.Prescription).WithMany(p => p.PrescriptionItems)
                .HasForeignKey(d => d.PrescriptionId)
                .HasConstraintName("FK__Prescript__presc__44CA3770");
        });

        modelBuilder.Entity<RadiologyReport>(entity =>
        {
            entity.HasKey(e => e.ReportId).HasName("PK__Radiolog__779B7C580C26BA4D");

            entity.ToTable("Radiology_Reports", "Clinical");

            entity.Property(e => e.ReportId).HasColumnName("report_id");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(255)
                .HasColumnName("image_url");
            entity.Property(e => e.RadiologyTypeId).HasColumnName("radiology_type_id");
            entity.Property(e => e.ReportDate)
                .HasColumnType("datetime")
                .HasColumnName("report_date");
            entity.Property(e => e.ReportText)
                .HasMaxLength(255)
                .HasColumnName("report_text");
            entity.Property(e => e.VisitId).HasColumnName("visit_id");

            entity.HasOne(d => d.RadiologyType).WithMany(p => p.RadiologyReports)
                .HasForeignKey(d => d.RadiologyTypeId)
                .HasConstraintName("FK__Radiology__radio__160F4887");

            entity.HasOne(d => d.Visit).WithMany(p => p.RadiologyReports)
                .HasForeignKey(d => d.VisitId)
                .HasConstraintName("FK__Radiology__visit__151B244E");
        });

        modelBuilder.Entity<RadiologyType>(entity =>
        {
            entity.HasKey(e => e.RadiologyTypeId).HasName("PK__Radiolog__080C1D81BF95DE6F");

            entity.ToTable("Radiology_Types", "Clinical");

            entity.Property(e => e.RadiologyTypeId)
                .ValueGeneratedNever()
                .HasColumnName("radiology_type_id");
            entity.Property(e => e.DepartmentId).HasColumnName("department_id");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.TypeName)
                .HasMaxLength(100)
                .HasColumnName("type_name");

            entity.HasOne(d => d.Department).WithMany(p => p.RadiologyTypes)
                .HasForeignKey(d => d.DepartmentId)
                .HasConstraintName("FK__Radiology__depar__71D1E811");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.RoleId).HasName("PK__Roles__760965CC46316FA5");

            entity.ToTable("Roles", "Admin");

            entity.Property(e => e.RoleId)
                .ValueGeneratedNever()
                .HasColumnName("role_id");
            entity.Property(e => e.RoleCode)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("role_code");
            entity.Property(e => e.RoleNameEn)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("role_name_en");

            entity.HasMany(d => d.Permissions).WithMany(p => p.Roles)
                .UsingEntity<Dictionary<string, object>>(
                    "RolePermission",
                    r => r.HasOne<Permission>().WithMany()
                        .HasForeignKey("PermissionId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK__RolePermi__permi__4CA06362"),
                    l => l.HasOne<Role>().WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK__RolePermi__role___4BAC3F29"),
                    j =>
                    {
                        j.HasKey("RoleId", "PermissionId").HasName("PK__RolePerm__C85A54637960B28C");
                        j.ToTable("RolePermissions", "Admin");
                        j.IndexerProperty<int>("RoleId").HasColumnName("role_id");
                        j.IndexerProperty<int>("PermissionId").HasColumnName("permission_id");
                    });
        });

        modelBuilder.Entity<Room>(entity =>
        {
            entity.HasKey(e => e.RoomId).HasName("PK__Rooms__19675A8A3FE873D1");

            entity.ToTable("Rooms", "Logistics");

            entity.Property(e => e.RoomId).HasColumnName("room_id");
            entity.Property(e => e.Capacity).HasColumnName("capacity");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DepartmentId).HasColumnName("department_id");
            entity.Property(e => e.Floor).HasColumnName("floor");
            entity.Property(e => e.RoomNumber)
                .HasMaxLength(20)
                .HasColumnName("room_number");
            entity.Property(e => e.RoomType)
                .HasMaxLength(50)
                .HasColumnName("room_type");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Department).WithMany(p => p.Rooms)
                .HasForeignKey(d => d.DepartmentId)
                .HasConstraintName("FK__Rooms__departmen__02FC7413");
        });

        modelBuilder.Entity<Service>(entity =>
        {
            entity.HasKey(e => e.ServiceId).HasName("PK__Services__3E0DB8AFCA5A028E");

            entity.ToTable("Services", "Billing");

            entity.Property(e => e.ServiceId).HasColumnName("service_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DepartmentId).HasColumnName("department_id");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.IsActive)
                .HasDefaultValue(true)
                .HasColumnName("is_active");
            entity.Property(e => e.ServiceCategory)
                .HasMaxLength(50)
                .HasColumnName("service_category");
            entity.Property(e => e.ServiceName)
                .HasMaxLength(100)
                .HasColumnName("service_name");
            entity.Property(e => e.StandardPrice)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("standard_price");

            entity.HasOne(d => d.Department).WithMany(p => p.Services)
                .HasForeignKey(d => d.DepartmentId)
                .HasConstraintName("FK__Services__depart__25518C17");
        });

        modelBuilder.Entity<Shift>(entity =>
        {
            entity.HasKey(e => e.ShiftId).HasName("PK__Shifts__7B267220899AC1BE");

            entity.ToTable("Shifts", "Admin");

            entity.Property(e => e.ShiftId).HasColumnName("shift_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.EmployeeId).HasColumnName("employee_id");
            entity.Property(e => e.EndTime).HasColumnName("end_time");
            entity.Property(e => e.Location)
                .HasMaxLength(100)
                .HasColumnName("location");
            entity.Property(e => e.ShiftDay)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("shift_day");
            entity.Property(e => e.StartTime).HasColumnName("start_time");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Employee).WithMany(p => p.Shifts)
                .HasForeignKey(d => d.EmployeeId)
                .HasConstraintName("FK_Shifts_EmployeeID");
        });

        modelBuilder.Entity<Specialization>(entity =>
        {
            entity.HasKey(e => e.SpecializationId).HasName("PK__Speciali__0E5BB650FD4919D7");

            entity.ToTable("Specializations", "Staff");

            entity.Property(e => e.SpecializationId).HasColumnName("specialization_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
        });

        modelBuilder.Entity<TestResultDetail>(entity =>
        {
            entity.HasKey(e => e.DetailId).HasName("PK__Test_Res__38E9A224951427F6");

            entity.ToTable("Test_Result_Details", "Clinical");

            entity.Property(e => e.DetailId).HasColumnName("detail_id");
            entity.Property(e => e.AttributeName)
                .HasMaxLength(100)
                .HasColumnName("attribute_name");
            entity.Property(e => e.AttributeValue)
                .HasMaxLength(100)
                .HasColumnName("attribute_value");
            entity.Property(e => e.LabTestId).HasColumnName("lab_test_id");
            entity.Property(e => e.NormalRange)
                .HasMaxLength(50)
                .HasColumnName("normal_range");
            entity.Property(e => e.ResultDate)
                .HasColumnType("datetime")
                .HasColumnName("result_date");
            entity.Property(e => e.VisitId).HasColumnName("visit_id");

            entity.HasOne(d => d.LabTest).WithMany(p => p.TestResultDetails)
                .HasForeignKey(d => d.LabTestId)
                .HasConstraintName("FK__Test_Resu__lab_t__19DFD96B");

            entity.HasOne(d => d.Visit).WithMany(p => p.TestResultDetails)
                .HasForeignKey(d => d.VisitId)
                .HasConstraintName("FK__Test_Resu__visit__18EBB532");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__B9BE370FE8CE879E");

            entity.ToTable("Users", "Admin");

            entity.HasIndex(e => e.Username, "UQ__Users__F3DBC5728ED90991").IsUnique();

            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.EmployeeId).HasColumnName("employee_id");
            entity.Property(e => e.LastLogin)
                .HasColumnType("datetime")
                .HasColumnName("last_login");
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("password_hash");
            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.RoleId).HasColumnName("role_id");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("username");

            entity.HasOne(d => d.Employee).WithMany(p => p.Users)
                .HasForeignKey(d => d.EmployeeId)
                .HasConstraintName("FK_Users_EmployeeID");

            entity.HasOne(d => d.Patient).WithMany(p => p.Users)
                .HasForeignKey(d => d.PatientId)
                .HasConstraintName("FK__Users__patient_i__6383C8BA");

            entity.HasOne(d => d.Role).WithMany(p => p.Users)
                .HasForeignKey(d => d.RoleId)
                .HasConstraintName("FK__Users__role_id__628FA481");
        });

        modelBuilder.Entity<Visit>(entity =>
        {
            entity.HasKey(e => e.VisitId).HasName("PK__Visits__375A75E16D8C7714");

            entity.ToTable("Visits", "Visit");

            entity.Property(e => e.VisitId).HasColumnName("visit_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DepartmentId).HasColumnName("department_id");
            entity.Property(e => e.DischargeDate)
                .HasColumnType("datetime")
                .HasColumnName("discharge_date");
            entity.Property(e => e.PatientId).HasColumnName("patient_id");
            entity.Property(e => e.Reason)
                .HasMaxLength(255)
                .HasColumnName("reason");
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .HasDefaultValue("Ongoing")
                .HasColumnName("status");
            entity.Property(e => e.UpdatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
            entity.Property(e => e.VisitDate)
                .HasColumnType("datetime")
                .HasColumnName("visit_date");
            entity.Property(e => e.VisitType)
                .HasMaxLength(50)
                .HasColumnName("visit_type");

            entity.HasOne(d => d.Department).WithMany(p => p.Visits)
                .HasForeignKey(d => d.DepartmentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Visits__departme__123EB7A3");

            entity.HasOne(d => d.Patient).WithMany(p => p.Visits)
                .HasForeignKey(d => d.PatientId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Visits__patient___114A936A");
        });

        modelBuilder.Entity<VisitRoom>(entity =>
        {
            entity.HasKey(e => e.VisitRoomId).HasName("PK__Visit_Ro__E9CEA4869F8BE1D2");

            entity.ToTable("Visit_Rooms", "Visit");

            entity.Property(e => e.VisitRoomId).HasColumnName("visit_room_id");
            entity.Property(e => e.EndTime)
                .HasColumnType("datetime")
                .HasColumnName("end_time");
            entity.Property(e => e.RoomId).HasColumnName("room_id");
            entity.Property(e => e.StartTime)
                .HasColumnType("datetime")
                .HasColumnName("start_time");
            entity.Property(e => e.VisitId).HasColumnName("visit_id");

            entity.HasOne(d => d.Room).WithMany(p => p.VisitRooms)
                .HasForeignKey(d => d.RoomId)
                .HasConstraintName("FK__Visit_Roo__room___4B7734FF");

            entity.HasOne(d => d.Visit).WithMany(p => p.VisitRooms)
                .HasForeignKey(d => d.VisitId)
                .HasConstraintName("FK__Visit_Roo__visit__4A8310C6");
        });

        modelBuilder.Entity<VisitVital>(entity =>
        {
            entity.HasKey(e => e.VitalId).HasName("PK__Visit_Vi__4DF3C47122732450");

            entity.ToTable("Visit_Vitals", "Visit");

            entity.HasIndex(e => e.VisitId, "UQ__Visit_Vi__375A75E091DD76AD").IsUnique();

            entity.Property(e => e.VitalId).HasColumnName("vital_id");
            entity.Property(e => e.BloodOxygenLevel).HasColumnName("blood_oxygen_level");
            entity.Property(e => e.BloodPressureDiastolic).HasColumnName("blood_pressure_diastolic");
            entity.Property(e => e.BloodPressureSystolic).HasColumnName("blood_pressure_systolic");
            entity.Property(e => e.BloodType)
                .HasMaxLength(3)
                .HasColumnName("blood_type");
            entity.Property(e => e.BodyTemperature)
                .HasColumnType("decimal(4, 1)")
                .HasColumnName("body_temperature");
            entity.Property(e => e.HeartRate).HasColumnName("heart_rate");
            entity.Property(e => e.RecordedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("recorded_at");
            entity.Property(e => e.RecordedBy).HasColumnName("recorded_by");
            entity.Property(e => e.RespiratoryRate).HasColumnName("respiratory_rate");
            entity.Property(e => e.VisitId).HasColumnName("visit_id");

            entity.HasOne(d => d.RecordedByNavigation).WithMany(p => p.VisitVitals)
                .HasForeignKey(d => d.RecordedBy)
                .HasConstraintName("FK_VisitVitals_RecordedBy");

            entity.HasOne(d => d.Visit).WithOne(p => p.VisitVital)
                .HasForeignKey<VisitVital>(d => d.VisitId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Visit_Vit__visit__5F7E2DAC");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
