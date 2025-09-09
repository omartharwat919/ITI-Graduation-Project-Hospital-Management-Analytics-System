using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Prescription
{
    public int PrescriptionId { get; set; }

    public int? VisitId { get; set; }

    public int? DoctorId { get; set; }

    public DateTime? IssueDate { get; set; }

    public string? Notes { get; set; }

    public virtual Doctor? Doctor { get; set; }

    public virtual ICollection<PrescriptionItem> PrescriptionItems { get; set; } = new List<PrescriptionItem>();

    public virtual Visit? Visit { get; set; }
}
