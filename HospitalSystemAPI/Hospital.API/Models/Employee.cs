using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Employee
{
    public int EmployeeId { get; set; }

    public string FullName { get; set; } = null!;

    public string NationalId { get; set; } = null!;

    public string? Gender { get; set; }

    public DateOnly? BirthDate { get; set; }

    public string? PhoneNumber { get; set; }

    public string? Email { get; set; }

    public string? EmpAddress { get; set; }

    public DateOnly HireDate { get; set; }

    public int? DepartmentId { get; set; }

    public string? EmpStatus { get; set; }

    public string? EmployeeType { get; set; }

    public string? SeniorityLevel { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Ambulance> Ambulances { get; set; } = new List<Ambulance>();

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual Department? Department { get; set; }

    public virtual ICollection<Department> Departments { get; set; } = new List<Department>();

    public virtual Doctor? Doctor { get; set; }

    public virtual ICollection<Expense> Expenses { get; set; } = new List<Expense>();

    public virtual ICollection<LeaveRequest> LeaveRequests { get; set; } = new List<LeaveRequest>();

    public virtual ICollection<MedicalRecord> MedicalRecords { get; set; } = new List<MedicalRecord>();

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<Shift> Shifts { get; set; } = new List<Shift>();

    public virtual ICollection<User> Users { get; set; } = new List<User>();

    public virtual ICollection<VisitVital> VisitVitals { get; set; } = new List<VisitVital>();
}
