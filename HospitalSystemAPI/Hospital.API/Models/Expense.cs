using System;
using System.Collections.Generic;

namespace Hospital.API.Models;

public partial class Expense
{
    public int ExpenseId { get; set; }

    public int CategoryId { get; set; }

    public decimal Amount { get; set; }

    public string? Description { get; set; }

    public DateOnly ExpenseDate { get; set; }

    public int RecordedBy { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ExpenseCategory Category { get; set; } = null!;

    public virtual Employee RecordedByNavigation { get; set; } = null!;
}
