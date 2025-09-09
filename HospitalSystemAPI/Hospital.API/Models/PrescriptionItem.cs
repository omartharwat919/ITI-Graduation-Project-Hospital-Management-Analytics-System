using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class PrescriptionItem
{
    public int ItemId { get; set; }

    public int? PrescriptionId { get; set; }

    public string? MedicineName { get; set; }

    public string? Dosage { get; set; }

    public string? Duration { get; set; }

    public string? Instructions { get; set; }

    public virtual Prescription? Prescription { get; set; }
}
