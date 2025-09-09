using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Department
{
    public int DepartmentId { get; set; }

    public string? DepartmentName { get; set; }

    public string? Description { get; set; }

    public int? ManagerId { get; set; }

    public string? PhoneNumber { get; set; }

    public string? Location { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    public virtual ICollection<LabTest> LabTests { get; set; } = new List<LabTest>();

    public virtual Employee? Manager { get; set; }

    public virtual ICollection<RadiologyType> RadiologyTypes { get; set; } = new List<RadiologyType>();

    public virtual ICollection<Room> Rooms { get; set; } = new List<Room>();

    public virtual ICollection<Service> Services { get; set; } = new List<Service>();

    public virtual ICollection<Visit> Visits { get; set; } = new List<Visit>();
}
