--Lab_Tests Procedures
-- 1. Add New Lab Test
Create PROCEDURE Add_Lab_Test
  @test_name NVARCHAR(100),
  @description NVARCHAR(255),
  @department_id INT
AS
BEGIN
  INSERT INTO Lab_Tests (test_name, description, department_id)
  VALUES (@test_name, @description, @department_id)
END
GO

-- 2. Update Lab Test
CREATE PROCEDURE Update_Lab_Test
  @lab_test_id INT,
  @test_name NVARCHAR(100),
  @description NVARCHAR(255),
  @department_id INT
AS
BEGIN
  UPDATE Lab_Tests
  SET test_name = @test_name,
      description = @description,
      department_id = @department_id
  WHERE lab_test_id = @lab_test_id
END
GO

-- 3. Delete Lab Test
CREATE PROCEDURE Delete_Lab_Test
  @lab_test_id INT
AS
BEGIN
  IF EXISTS (
    SELECT 1 FROM Test_Result_Details WHERE lab_test_id = @lab_test_id
  )
  BEGIN
    RAISERROR('Cannot delete the lab test because it is associated with test results.', 16, 1)
    RETURN
  END

  DELETE FROM Lab_Tests
  WHERE lab_test_id = @lab_test_id
END
GO

-- 4. View All Lab Tests
CREATE PROCEDURE Get_All_Lab_Tests
AS
BEGIN
  SELECT * FROM Lab_Tests
END
GO

--Test_Result_Details Procedures
-- 5. Add Test Result
CREATE PROCEDURE Add_Test_Result
  @visit_id INT,
  @lab_test_id INT,
  @attribute_name NVARCHAR(100),
  @attribute_value NVARCHAR(100),
  @normal_range NVARCHAR(50)
AS
BEGIN
  INSERT INTO Test_Result_Details
  (visit_id, lab_test_id, attribute_name, attribute_value, normal_range, result_date)
  VALUES
  (@visit_id, @lab_test_id, @attribute_name, @attribute_value, @normal_range, GETDATE())
END
GO

--  6. Update Test Result
CREATE PROCEDURE Update_Test_Result
  @detail_id INT,
  @attribute_name NVARCHAR(100),
  @attribute_value NVARCHAR(100),
  @normal_range NVARCHAR(50),
  @result_date DATETIME
AS
BEGIN
  UPDATE Test_Result_Details
  SET attribute_name = @attribute_name,
      attribute_value = @attribute_value,
      normal_range = @normal_range,
      result_date = @result_date
  WHERE detail_id = @detail_id
END
GO

-- 7. Delete Test Result
CREATE PROCEDURE Delete_Test_Result
  @detail_id INT
AS
BEGIN
  DELETE FROM Test_Result_Details
  WHERE detail_id = @detail_id
END
GO

--  8. View Test Results by Visit
CREATE PROCEDURE Get_Test_Results_By_Visit
  @visit_id INT
AS
BEGIN
  SELECT * FROM Test_Result_Details
  WHERE visit_id = @visit_id
END
GO

--  9. View Lab Tests for a Specific Patient
CREATE VIEW vw_Patient_Lab_Tests AS
SELECT 
    p.patient_id,
    p.first_name + ' ' + p.last_name AS patient_name,
    v.visit_id,
    lt.test_name,
    trd.attribute_name,
    trd.attribute_value,
    trd.normal_range,
    trd.result_date
FROM Patient.Patients p
JOIN Visit.Visits v ON p.patient_id = v.patient_id
JOIN Test_Result_Details trd ON v.visit_id = trd.visit_id
JOIN Lab_Tests lt ON trd.lab_test_id = lt.lab_test_id;

Go

CREATE PROCEDURE GetLabTestsForPatient
  @patient_id INT
AS
BEGIN
  SELECT *
  FROM vw_Patient_Lab_Tests
  WHERE patient_id = @patient_id
END
GO

--Radiology_Types Procedures

-- 10. Add Radiology Type
CREATE PROCEDURE Add_Radiology_Type
  @type_name NVARCHAR(100),
  @description NVARCHAR(255),
  @department_id INT
AS
BEGIN
  INSERT INTO Radiology_Types (type_name, description, department_id)
  VALUES (@type_name, @description, @department_id)
END
GO

-- 11. Update Radiology Type
CREATE PROCEDURE Update_Radiology_Type
  @radiology_type_id INT,
  @type_name NVARCHAR(100),
  @description NVARCHAR(255),
  @department_id INT
AS
BEGIN
  UPDATE Radiology_Types
  SET type_name = @type_name,
      description = @description,
      department_id = @department_id
  WHERE radiology_type_id = @radiology_type_id
END
GO

--  12. Delete Radiology Type
CREATE PROCEDURE Delete_Radiology_Type
  @radiology_type_id INT
AS
BEGIN

  IF EXISTS (
    SELECT 1 FROM Radiology_Reports WHERE radiology_type_id = @radiology_type_id
  )
  BEGIN
    RAISERROR('Cannot delete the radiology type because it is associated with reports.', 16, 1)
    RETURN
  END

  DELETE FROM Radiology_Types
  WHERE radiology_type_id = @radiology_type_id
END
GO

-- 13. Get All Radiology Types
CREATE PROCEDURE Get_All_Radiology_Types
AS
BEGIN
 SELECT * FROM  Radiology_Types
END
GO

--Radiology_Reports Procedures

-- 14. Add Radiology Report
CREATE PROCEDURE Add_Radiology_Report
  @visit_id INT,
  @radiology_type_id INT,
  @image_url NVARCHAR(255),
  @report_text NVARCHAR(255)
AS
BEGIN
  INSERT INTO Radiology_Reports
  (visit_id, radiology_type_id, image_url, report_text, report_date)
  VALUES
  (@visit_id, @radiology_type_id, @image_url, @report_text, GETDATE())
END
GO

-- 15. Update Radiology Report
CREATE PROCEDURE Update_Radiology_Report
  @report_id INT,
  @radiology_type_id INT,
  @image_url NVARCHAR(255),
  @report_text NVARCHAR(255),
  @report_date DATETIME
AS
BEGIN
  UPDATE Radiology_Reports
  SET 
    radiology_type_id = @radiology_type_id,
    image_url = @image_url,
    report_text = @report_text,
    report_date = @report_date
  WHERE report_id = @report_id
END
GO

--  16. Delete Radiology Report
CREATE PROCEDURE Delete_Radiology_Report
  @report_id INT
AS
BEGIN
  DELETE FROM Radiology_Reports
  WHERE report_id = @report_id
END
GO

--17. Retrieve Radiology Reports for a Visit
CREATE PROCEDURE Get_Radiology_Reports_By_Visit
  @visit_id INT
AS
BEGIN
  SELECT * FROM Radiology_Reports
  WHERE visit_id = @visit_id
END
GO

-- 18. Display Radiology Reports for a Specific Patient
CREATE VIEW vw_Patient_Radiology_Reports AS
SELECT 
    p.patient_id,
    p.first_name + ' ' + p.last_name AS patient_name,
    v.visit_id,
    rr.report_id,
    rt.type_name AS radiology_type,
    rr.image_url,
    rr.report_text,
    rr.report_date
FROM Patient.Patients p
JOIN Visit.Visits v ON p.patient_id = v.patient_id
JOIN Radiology_Reports rr ON v.visit_id = rr.visit_id
JOIN Radiology_Types rt ON rr.radiology_type_id = rt.radiology_type_id;
GO

--Report
CREATE PROCEDURE GetRadiologyReportsForPatient
  @patient_id INT
AS
BEGIN
  SELECT *
  FROM vw_Patient_Radiology_Reports
  WHERE patient_id = @patient_id
END
GO

-- Procedures for Payment_Methods
-- 19. Add Payment Method
Create PROCEDURE Add_Payment_Method
  @method_name NVARCHAR(50)
AS
BEGIN
  INSERT INTO Billing.Payment_Methods (method_name)
  VALUES (@method_name)
END
GO

-- 20. Update Payment Method
Create PROCEDURE Update_Payment_Method
  @method_id INT,
  @method_name NVARCHAR(50)
AS
BEGIN
  UPDATE Billing.Payment_Methods
  SET method_name = @method_name
  WHERE method_id = @method_id
END
GO

-- 21. Delete Payment Method
Create PROCEDURE Delete_Payment_Method
  @method_id INT
AS
BEGIN
  IF EXISTS (SELECT 1 FROM Payments WHERE method_id = @method_id)
  BEGIN
    RAISERROR('Cannot delete the payment method because it is associated with existing payments.', 16, 1)
    RETURN
  END
  DELETE FROM Billing.Payment_Methods WHERE method_id = @method_id
END
GO

-- 22. Get All Payment Methods
Create PROCEDURE Get_All_Payment_Methods
AS
BEGIN
  SELECT * FROM Billing.Payment_Methods
END
GO

-- Procedures for Insurance
-- 23. Add Insurance
Create PROCEDURE Add_Insurance
  @company_name NVARCHAR(100),
  @policy_number NVARCHAR(50),
  @coverage_type NVARCHAR(50),
  @contact_info NVARCHAR(100)
AS
BEGIN
  INSERT INTO Billing.Insurance (company_name, policy_number, coverage_type, contact_info)
  VALUES (@company_name, @policy_number, @coverage_type, @contact_info)
END
GO

-- 24. Update Insurance
Create PROCEDURE Update_Insurance
  @insurance_id INT,
  @company_name NVARCHAR(100),
  @policy_number NVARCHAR(50),
  @coverage_type NVARCHAR(50),
  @contact_info NVARCHAR(100)
AS
BEGIN
  UPDATE Billing.Insurance
  SET company_name = @company_name,
      policy_number = @policy_number,
      coverage_type = @coverage_type,
      contact_info = @contact_info
  WHERE insurance_id = @insurance_id
END
GO

-- 25. Delete Insurance
Create PROCEDURE Delete_Insurance
  @insurance_id INT
AS
BEGIN
  IF EXISTS (SELECT 1 FROM Bills WHERE insurance_id = @insurance_id)
  BEGIN
    RAISERROR('Cannot delete the insurance company because it is used in bills.', 16, 1)
    RETURN
  END
  DELETE FROM Billing.Insurance WHERE insurance_id = @insurance_id
END
GO
-- 26. Get All Insurance
Create PROCEDURE Get_All_Insurance
AS
BEGIN
  SELECT * FROM Billing.Insurance
END
GO

-- Procedures for Bills
-- 27. Add Bill
Create PROCEDURE Add_Bill
  @patient_id INT,
  @visit_id INT,
  @total_amount DECIMAL(10,2),
  @insurance_id INT,
  @created_by INT
AS
BEGIN
  INSERT INTO Billing.Bills (patient_id, visit_id, total_amount, created_by, created_at)
  VALUES (@patient_id, @visit_id, @total_amount, @created_by, GETDATE())
END
GO

-- 28. Update Bill
Create PROCEDURE Update_Bill
  @bill_id INT,
  @total_amount DECIMAL(10,2)
AS
BEGIN
  UPDATE Billing.Bills
  SET total_amount = @total_amount
  WHERE bill_id = @bill_id
END
GO

-- 29. Delete Bill
Create PROCEDURE Delete_Bill
  @bill_id INT
AS
BEGIN
  IF EXISTS (SELECT 1 FROM Bill_Items WHERE bill_id = @bill_id) OR
     EXISTS (SELECT 1 FROM Payments WHERE bill_id = @bill_id)
  BEGIN
    RAISERROR('Cannot delete the bill because it contains items or payments.', 16, 1)
    RETURN
  END
  DELETE FROM Billing.Bills WHERE bill_id = @bill_id
END
GO

-- 30. Get All Bills
Create PROCEDURE Get_All_Bills
AS
BEGIN
  SELECT * FROM Billing.Bills
END
GO

-- Procedures for Bill_Items
-- 31. Add Bill Item
Create PROCEDURE Add_Bill_Item
  @bill_id INT,
  @service_id INT,
  @amount DECIMAL(10,2)
AS
BEGIN
  INSERT INTO Billing.Bill_Items (bill_id, service_id, amount, created_at)
  VALUES (@bill_id, @service_id, @amount, GETDATE())
END
GO

-- 32. Update Bill Item
Create PROCEDURE Update_Bill_Item
  @bill_item_id INT,
  @service_id INT,
  @amount DECIMAL(10,2)
AS
BEGIN
  UPDATE Billing.Bill_Items
  SET service_id = @service_id,
      amount = @amount
  WHERE bill_item_id = @bill_item_id
END
GO

-- 33. Delete Bill Item
Create PROCEDURE Delete_Bill_Item
  @bill_item_id INT
AS
BEGIN
  DELETE FROM Billing.Bill_Items WHERE bill_item_id = @bill_item_id
END
GO

-- 34. Get Bill Items by Bill
Create PROCEDURE Get_Bill_Items_By_Bill
  @bill_id INT
AS
BEGIN
  SELECT * FROM Billing.Bill_Items WHERE bill_id = @bill_id
END
GO

-- Procedures for Payments
-- 35. Add Payment
Create PROCEDURE Add_Payment
  @bill_id INT,
  @method_id INT,
  @amount DECIMAL(10,2),
  @payment_date DATETIME,
  @received_by INT
AS
BEGIN
  INSERT INTO Payments (bill_id, method_id, amount, payment_date, received_by)
  VALUES (@bill_id, @method_id, @amount, @payment_date, @received_by)
END
GO

-- 36. Update Payment
Create PROCEDURE Update_Payment
  @payment_id INT,
  @amount DECIMAL(10,2),
  @payment_date DATETIME
AS
BEGIN
  UPDATE Billing.Payments
  SET amount = @amount,
      payment_date = @payment_date
  WHERE payment_id = @payment_id
END
GO

-- 37. Delete Payment
Create PROCEDURE Delete_Payment
  @payment_id INT
AS
BEGIN
  DELETE FROM Billing.Payments WHERE payment_id = @payment_id
END
GO

-- 38. Get Payments by Bill
Create PROCEDURE Get_Payments_By_Bill
  @bill_id INT
AS
BEGIN
  SELECT * FROM Billing.Payments WHERE bill_id = @bill_id
END
GO

-- Procedures for Service
-- 39. Add a New Service
Create PROCEDURE Add_Service
  @service_name NVARCHAR(100),
  @description NVARCHAR(255),
  @standard_price DECIMAL(10,2),
  @service_category NVARCHAR(50),
  @department_id INT,
  @is_active BIT
AS
BEGIN
  INSERT INTO Billing.Services (
    service_name, 
    description, 
    standard_price, 
    service_category, 
    department_id, 
    is_active, 
    created_at
  )
  VALUES (
    @service_name, 
    @description, 
    @standard_price, 
    @service_category, 
    @department_id, 
    @is_active, 
    GETDATE()  
  )
END
GO

--40. Update Service
Create PROCEDURE Update_Service
  @service_id INT,
  @service_name NVARCHAR(100),
  @description NVARCHAR(255),
  @standard_price DECIMAL(10,2),
  @service_category NVARCHAR(50),
  @department_id INT,
  @is_active BIT
AS
BEGIN
  UPDATE Billing.Services
  SET 
    service_name = @service_name,
    description = @description,
    standard_price = @standard_price,
    service_category = @service_category,
    department_id = @department_id,
    is_active = @is_active
  WHERE service_id = @service_id
END
GO

--41. Delete Service
Create PROCEDURE Delete_Service
  @service_id INT
AS
BEGIN
  IF EXISTS (SELECT 1 FROM Bill_Items WHERE service_id = @service_id)
  BEGIN
    RAISERROR('Cannot delete the service because it is used in bills.', 16, 1)
    RETURN
  END

  DELETE FROM Billing.Services WHERE service_id = @service_id
END
GO

--  42. View All Services
Create PROCEDURE Get_All_Services
AS
BEGIN
  SELECT * FROM Billing.Services
END
GO

-- Procedures for patient Insurance
--43. Add Patient Insurance
Create PROCEDURE Add_Patient_Insurance
  @patient_id INT,
  @insurance_id INT,
  @start_date DATE,
  @end_date DATE,
  @is_active BIT
AS
BEGIN
  INSERT INTO patient.Patient_Insurance (
    patient_id,
    insurance_id,
    start_date,
    end_date,
    is_active
  )
  VALUES (
    @patient_id,
    @insurance_id,
    @start_date,
    @end_date,
    @is_active
  )
END
GO

--44. update Patient Insurance
Create PROCEDURE Update_Patient_Insurance
  @patient_insurance_id INT,
  @start_date DATE,
  @end_date DATE,
  @is_active BIT
AS
BEGIN
  UPDATE patient.Patient_Insurance
  SET 
    start_date = @start_date,
    end_date = @end_date,
    is_active = @is_active
  WHERE patient_insurance_id = @patient_insurance_id
END
GO

--45. Delete Patient Insurance
Create PROCEDURE Delete_Patient_Insurance
  @patient_insurance_id INT
AS
BEGIN
  DELETE FROM patient.Patient_Insurance
  WHERE patient_insurance_id = @patient_insurance_id
END
GO

--View to Link Patient Data with Insurance Information
Create VIEW vw_Patient_Insurance AS
SELECT 
    pi.patient_insurance_id,
    pi.patient_id,
    p.first_name + ' ' + p.last_name AS patient_name,
    pi.insurance_id,
    i.company_name,
    pi.start_date,
    pi.end_date,
    pi.is_active
FROM Patient.Patient_Insurance pi
JOIN Billing.Insurance i ON pi.insurance_id = i.insurance_id
JOIN Patient.Patients p ON pi.patient_id = p.patient_id
GO
--46. Procedure to Retrieve Insurance Data for a Specific Patient
Create PROCEDURE Get_Insurance_By_Patient
  @patient_id INT
AS
BEGIN
  SELECT *
  FROM vw_Patient_Insurance
  WHERE patient_id = @patient_id
END
GO

--Report 47. Get Full Bill Details by Bill ID
Create PROCEDURE Get_Full_Bill_Summary
  @bill_id INT
AS
BEGIN
  DECLARE @total_billed DECIMAL(10,2)
  DECLARE @total_paid DECIMAL(10,2)
  DECLARE @patient_name NVARCHAR(200)
  DECLARE @insurance_company NVARCHAR(100)
  DECLARE @payment_method NVARCHAR(50)
  DECLARE @payment_status NVARCHAR(50)
  DECLARE @created_at DATETIME
  DECLARE @patient_id INT
  DECLARE @insurance_id INT
  DECLARE @visit_id INT
  DECLARE @created_by NVARCHAR(100)

  SELECT 
    @total_billed = ISNULL(SUM(amount), 0)
  FROM Billing.Bill_Items
  WHERE bill_id = @bill_id

  SELECT 
    @total_paid = ISNULL(SUM(amount), 0)
  FROM Payments
  WHERE bill_id = @bill_id

  SELECT 
    @created_at = b.created_at,
    @patient_id = b.patient_id,
    @insurance_id = pi.insurance_id,
    @visit_id = b.visit_id,
    @patient_name = p.first_name + ' ' + p.last_name,
    @insurance_company = ISNULL(i.company_name, ''),
    @payment_method = ISNULL(pm.method_name, ''),
    @created_by = ISNULL(e.full_name, '')
  FROM Billing.Bills b
  JOIN Patient.Patients p ON b.patient_id = p.patient_id
  LEFT JOIN Patient.Patient_Insurance pi ON b.patient_insurance_id = pi.patient_insurance_id
  LEFT JOIN Billing.Insurance i ON pi.insurance_id = i.insurance_id
  LEFT JOIN Payments pay ON b.bill_id = pay.bill_id
  LEFT JOIN Billing.Payment_Methods pm ON pay.method_id = pm.method_id
  LEFT JOIN Admin.Employees e ON b.created_by = e.employee_id
  WHERE b.bill_id = @bill_id

  SET @payment_status = 
    CASE 
      WHEN @total_paid = 0 THEN 'Unpaid'
      WHEN @total_paid < @total_billed THEN 'Partially Paid'
      ELSE 'Fully Paid'
    END

  SELECT 
    b.bill_id,
    @created_at AS created_at,
    @patient_id AS patient_id,
    @patient_name AS patient_name,
    @insurance_id AS insurance_id,
    @insurance_company AS insurance_company,
    @visit_id AS visit_id,
    @created_by AS created_by,
    @payment_method AS payment_method,
    s.service_name,
    FORMAT(s.standard_price, 'N2') AS service_price,
    FORMAT(bi.amount, 'N2') AS billed_amount,
    FORMAT(ROUND((bi.amount / NULLIF(@total_billed, 0)) * @total_paid, 2), 'N2') AS paid_amount,
    FORMAT(ROUND(bi.amount - ((bi.amount / NULLIF(@total_billed, 0)) * @total_paid), 2), 'N2') AS remaining_amount,
    CASE 
      WHEN ((bi.amount / NULLIF(@total_billed, 0)) * @total_paid) = 0 THEN 'Unpaid'
      WHEN ((bi.amount / NULLIF(@total_billed, 0)) * @total_paid) < bi.amount THEN 'Partially Paid'
      ELSE 'Fully Paid'
    END AS payment_status,
    ISNULL(CAST(pi.is_active AS NVARCHAR(10)), '') AS is_active
  FROM Billing.Bill_Items bi
  JOIN Billing.Services s ON bi.service_id = s.service_id
  JOIN Billing.Bills b ON bi.bill_id = b.bill_id
  LEFT JOIN Patient.Patient_Insurance pi 
    ON pi.patient_id = b.patient_id AND pi.patient_insurance_id = b.patient_insurance_id
  WHERE bi.bill_id = @bill_id

  UNION ALL

  SELECT 
    @bill_id,
    @created_at,
    @patient_id,
    @patient_name,
    @insurance_id,
    @insurance_company,
    @visit_id,
    @created_by,
    @payment_method,
    'TOTAL',
    '' AS service_price,
    FORMAT(@total_billed, 'N2') AS billed_amount,
    FORMAT(@total_paid, 'N2') AS paid_amount,
    FORMAT(@total_billed - @total_paid, 'N2') AS remaining_amount,
    @payment_status,
    ''
END
GO

-- Display all bills with payments and insurance company if available
-- Create a view named vw_All_Bills
Create VIEW vw_All_Bill_Summary AS
SELECT 
    b.bill_id,
    b.created_at,
    b.patient_id,
    p.first_name + ' ' + p.last_name AS patient_name,
    b.visit_id,
    b.total_amount AS total_billed,
    ISNULL(i.insurance_id, 0) AS insurance_id,
    ISNULL(i.company_name, 'N/A') AS insurance_company,
    CASE 
        WHEN pi.is_active = 1 THEN 'Active'
        WHEN pi.is_active = 0 THEN 'Inactive'
        ELSE 'N/A'
    END AS insurance_status,
    ISNULL(creator.full_name, 'N/A') AS created_by,

    -- Accounting
    ISNULL(pay_summary.total_paid, 0) AS total_paid,
    b.total_amount - ISNULL(pay_summary.total_paid, 0) AS remaining_amount,

    CASE 
        WHEN ISNULL(pay_summary.total_paid, 0) = 0 THEN 'Unpaid'
        WHEN ISNULL(pay_summary.total_paid, 0) < b.total_amount THEN 'Partially Paid'
        ELSE 'Fully Paid'
    END AS payment_status,

    -- Type of the latest payment made (if any)
    ISNULL(last_payment.method_name, 'N/A') AS payment_method,
    ISNULL(last_payment.received_by, 'N/A') AS received_by

FROM Billing.Bills b
JOIN Patient.Patients p ON b.patient_id = p.patient_id
LEFT JOIN Patient.Patient_Insurance pi ON pi.patient_id = p.patient_id AND pi.is_active = 1 AND b.created_at BETWEEN pi.start_date AND pi.end_date
LEFT JOIN Billing.Insurance i ON pi.insurance_id = i.insurance_id
LEFT JOIN Admin.Employees creator ON b.created_by = creator.employee_id

-- Latest payment (example of using OUTER APPLY to retrieve the latest payment)
OUTER APPLY (
    SELECT TOP 1 
        pm.method_name,
        e.full_name AS received_by
    FROM Payments pay
    LEFT JOIN Billing.Payment_Methods pm ON pay.method_id = pm.method_id
    LEFT JOIN Admin.Employees e ON pay.received_by = e.employee_id
    WHERE pay.bill_id = b.bill_id
    ORDER BY pay.payment_date DESC
) AS last_payment

-- Payment Summary
OUTER APPLY (
    SELECT SUM(amount) AS total_paid
    FROM Payments
    WHERE bill_id = b.bill_id
) AS pay_summary

Go

--Report 48.Create a Stored Procedure that uses the View
Create PROCEDURE Get_All_Bill_Summary
  @PaymentStatus VARCHAR(50) = 'All'  
AS
BEGIN
  SELECT * 
  FROM vw_All_Bill_Summary
  WHERE
    @PaymentStatus = 'All' OR
    payment_status = @PaymentStatus
  ORDER BY created_at DESC
END

--Report 49.Bill summary for a specific patient with payment details
CREATE PROCEDURE Get_Bills_By_Patient
  @patient_id INT
AS
BEGIN
  SELECT *
  FROM vw_All_Bill_Summary
  WHERE patient_id = @patient_id
  ORDER BY created_at DESC
END
GO

-- Procedures for Expense_Categories
--50. Add Category
Create PROCEDURE Add_Expense_Category
  @category_name NVARCHAR(100)
AS
BEGIN
  INSERT INTO Billing.Expense_Categories (category_name)
  VALUES (@category_name)
END
GO

-- 51. Update Category
Create PROCEDURE Update_Expense_Category
  @category_id INT,
  @category_name NVARCHAR(100)
AS
BEGIN
  UPDATE Billing.Expense_Categories
  SET category_name = @category_name
  WHERE category_id = @category_id
END
GO

-- 52. Delete Category
Create PROCEDURE Delete_Expense_Category
  @category_id INT
AS
BEGIN
  IF EXISTS (SELECT 1 FROM Billing.Expenses WHERE category_id = @category_id)
  BEGIN
    RAISERROR('Cannot delete category: It is used in Expenses.', 16, 1)
    RETURN
  END
  DELETE FROM Billing.Expense_Categories WHERE category_id = @category_id
END
GO

-- Procedures for Expenses
--53.Add Expense
Create PROCEDURE Add_Expense
  @category_id INT,
  @amount DECIMAL(10,2),
  @expense_date DATE,
  @description NVARCHAR(255),
  @recorded_by INT 
AS
BEGIN
  INSERT INTO Billing.Expenses (category_id, amount, expense_date, description, recorded_by, created_at, updated_at)
  VALUES (@category_id, @amount, @expense_date, @description, @recorded_by, GETDATE(), GETDATE())
END
GO

--54. Update Expense
Create PROCEDURE Update_Expense
  @expense_id INT,
  @category_id INT,
  @amount DECIMAL(10,2),
  @expense_date DATE,
  @description NVARCHAR(255)
AS
BEGIN
  UPDATE Billing.Expenses
  SET category_id = @category_id,
      amount = @amount,
      expense_date = @expense_date,
      description = @description ,
	  updated_at = GETDATE()
  WHERE expense_id = @expense_id
END
GO

--55. Delete Expense
Create PROCEDURE Delete_Expense
  @expense_id INT
AS
BEGIN
  DELETE FROM Billing.Expenses WHERE expense_id = @expense_id
END
GO

--56. Get All Expenses
Create VIEW vw_All_Expenses AS
SELECT 
  e.expense_id,
  e.amount,
  e.expense_date,
  e.description,
  c.category_name,
  emp.full_name AS created_by
FROM Billing.Expenses e
LEFT JOIN Billing.Expense_Categories c ON e.category_id = c.category_id
LEFT JOIN Admin.Employees emp ON e.recorded_by = emp.employee_id

Go

Create PROCEDURE Get_All_Expenses
AS
BEGIN
  SELECT * FROM vw_All_Expenses
  ORDER BY expense_date DESC
END
GO

-- addtional SP
--Report 57. Get all Patient with Visit and Diagnoses
CREATE PROCEDURE usp_GetPatientVisitDiagnoses
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.patient_id,
        p.first_name + ' ' + p.last_name AS full_name,
        v.visit_date,
        
        v.visit_id,
        v.visit_type,
        v.reason,
        v.status,
        v.discharge_date AS discharge_date,
        
        d.diagnosis_id,
        d.diagnosis_text,
        d.diagnosis_date
    FROM 
        Patient.Patients p
    JOIN 
        Visit.Visits v ON p.patient_id = v.patient_id
    LEFT JOIN 
        Visit.Diagnoses d ON v.visit_id = d.visit_id
    ORDER BY 
        p.patient_id, v.visit_date;
END;
GO

--Report 58.get all Doctors By Specialization
alter PROCEDURE Get_Doctors_By_Specialization
AS
BEGIN
  SELECT
    s.specialization_id,
    s.name AS specialization_name,
    ISNULL(e.full_name, 'No doctors added yet') AS doctor_name,
    CASE 
      WHEN d.doctor_id IS NULL THEN 'Not available'
      ELSE CAST(d.doctor_id AS NVARCHAR)
    END AS doctor_id,
    CASE 
      WHEN d.years_of_experience IS NULL THEN 'Not available'
      ELSE CAST(d.years_of_experience AS NVARCHAR)
    END AS years_of_experience
  FROM Specializations s
  LEFT JOIN Doctors d ON s.specialization_id = d.specialization_id
  LEFT JOIN Admin.Employees e ON d.employee_id = e.employee_id
  ORDER BY s.specialization_id , e.full_name ;
END
GO

--59. Geat all Nurses with Shifts
Create PROCEDURE Get_Nurse_Room_Shift_Assignments
AS
BEGIN
    SELECT 
        n.nurse_id,
        e.full_name AS nurse_name,
        n.specialization,
        ISNULL(r.room_number, 'Unassigned') AS room_number,
        ISNULL(CAST(r.floor AS NVARCHAR), 'Unassigned') AS floor,
        ISNULL(r.room_type, 'Unassigned') AS room_type,
        ISNULL(s.shift_day, 'Unassigned') AS shift_day,
        CASE 
            WHEN s.start_time IS NULL THEN 'Unassigned'
            ELSE LEFT(CONVERT(VARCHAR(5), s.start_time, 108), 5)
        END AS start_time,
        CASE 
            WHEN s.end_time IS NULL THEN 'Unassigned'
            ELSE LEFT(CONVERT(VARCHAR(5), s.end_time, 108), 5)
        END AS end_time
    FROM Nurses n
    JOIN Admin.Employees e ON n.employee_id = e.employee_id
    LEFT JOIN Logistics.Nurse_Room_Assignments a ON n.nurse_id = a.nurse_id
    LEFT JOIN Logistics.Rooms r ON a.room_id = r.room_id
    LEFT JOIN Admin.Shifts s ON a.shift_id = s.shift_id
    ORDER BY n.nurse_id;
END;
















