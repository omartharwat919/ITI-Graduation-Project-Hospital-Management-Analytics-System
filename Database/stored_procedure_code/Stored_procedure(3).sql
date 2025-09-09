
-- =============================================
-- Procedures for dbo.Nurses
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Nurses
AS
BEGIN
    SELECT * FROM dbo.Nurses;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Nurses
    @employee_id INT,
    @license_number NVARCHAR(100),
    @experience_years INT,
    @specialization NVARCHAR(100)
AS
BEGIN
    INSERT INTO .Nurses (employee_id, license_number, experience_years, specialization)
    VALUES (@employee_id, @license_number, @experience_years, @specialization);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Nurses
    @nurse_id INT,
    @employee_id INT,
    @license_number NVARCHAR(100),
    @experience_years INT,
    @specialization NVARCHAR(100)
AS
BEGIN
    UPDATE dbo.Nurses
    SET
        employee_id = @employee_id,
        license_number = @license_number,
        experience_years = @experience_years,
        specialization = @specialization
    WHERE nurse_id = @nurse_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Nurses
    @nurse_id INT
AS
BEGIN
    DELETE FROM dbo.Nurses
    WHERE nurse_id = @nurse_id;
END;
GO


-- =============================================
-- Procedures for Logistics.Nurse_Room_Assignments
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Nurse_Room_Assignments
AS
BEGIN
    SELECT * FROM Logistics.Nurse_Room_Assignments;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Nurse_Room_Assignments
    @nurse_id INT,
    @room_id INT,
    @assigned_at DATETIME,
    @shift_id INT,
    @notes NVARCHAR(255)
AS
BEGIN
    INSERT INTO Logistics.Nurse_Room_Assignments (nurse_id, room_id, assigned_at, shift_id)
    VALUES (@nurse_id, @room_id, @assigned_at, @shift_id, @notes);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Nurse_Room_Assignments
    @assignment_id INT,
    @nurse_id INT,
    @room_id INT,
    @assigned_at DATETIME,
    @shift_id INT,
    @notes NVARCHAR(255)
AS
BEGIN
    UPDATE Logistics.Nurse_Room_Assignments
    SET
        nurse_id = @nurse_id,
        room_id = @room_id,
        assigned_at = @assigned_at,
        shift_id = @shift_id
     
    WHERE assignment_id = @assignment_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Nurse_Room_Assignments
    @assignment_id INT
AS
BEGIN
    DELETE FROM Logistics.Nurse_Room_Assignments
    WHERE assignment_id = @assignment_id;
END;
GO


-- =============================================
-- Procedures for Visit.Visit_Rooms
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Visit_Rooms
AS
BEGIN
    SELECT * FROM Visit.Visit_Rooms;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Visit_Rooms
    @visit_id INT,
    @room_id INT,
    @start_time DATETIME,
    @end_time DATETIME
AS
BEGIN
    INSERT INTO Visit.Visit_Rooms (visit_id, room_id, start_time, end_time)
    VALUES (@visit_id, @room_id, @start_time, @end_time);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Visit_Rooms
    @visit_room_id INT,
    @visit_id INT,
    @room_id INT,
    @start_time DATETIME,
    @end_time DATETIME
AS
BEGIN
    UPDATE Visit.Visit_Rooms
    SET
        visit_id = @visit_id,
        room_id = @room_id,
        start_time = @start_time,
        end_time = @end_time
    WHERE visit_room_id = @visit_room_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Visit_Rooms
    @visit_room_id INT
AS
BEGIN
    DELETE FROM Visit.Visit_Rooms
    WHERE visit_room_id = @visit_room_id;
END;
GO


-- =============================================
-- Procedures for Logistics.Rooms
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Rooms
AS
BEGIN
    SELECT * FROM Logistics.Rooms;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Rooms
    @room_number NVARCHAR(20),
    @floor INT,
    @capacity INT,
    @room_type NVARCHAR(50),
    @department_id INT,
    @status NVARCHAR(50),
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    INSERT INTO Logistics.Rooms (room_number, floor, capacity, room_type, department_id, status, created_at, updated_at)
    VALUES (@room_number, @floor, @capacity, @room_type, @department_id, @status, @created_at, @updated_at);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Rooms
    @room_id INT,
    @room_number NVARCHAR(20),
    @floor INT,
    @capacity INT,
    @room_type NVARCHAR(50),
    @department_id INT,
    @status NVARCHAR(50),
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    UPDATE Logistics.Rooms
    SET
        room_number = @room_number,
        floor = @floor,
        capacity = @capacity,
        room_type = @room_type,
        department_id = @department_id,
        status = @status,
        created_at = @created_at,
        updated_at = @updated_at
    WHERE room_id = @room_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Rooms
    @room_id INT
AS
BEGIN
    DELETE FROM Logistics.Rooms
    WHERE room_id = @room_id;
END;
GO


-- =============================================
-- Procedures for Logistics.Beds
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Beds
AS
BEGIN
    SELECT * FROM Logistics.Beds;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Beds
    @room_id INT,
    @bed_number NVARCHAR(10),
    @status NVARCHAR(50)
AS
BEGIN
    INSERT INTO Logistics.Beds (room_id, bed_number, status)
    VALUES (@room_id, @bed_number, @status);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Beds
    @bed_id INT,
    @room_id INT,
    @bed_number NVARCHAR(10),
    @status NVARCHAR(50)
AS
BEGIN
    UPDATE Logistics.Beds
    SET
        room_id = @room_id,
        bed_number = @bed_number,
        status = @status
    WHERE bed_id = @bed_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Beds
    @bed_id INT
AS
BEGIN
    DELETE FROM Logistics.Beds
    WHERE bed_id = @bed_id;
END;
GO


-- =============================================
-- Procedures for Visits.Visits
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Visits
AS
BEGIN
    SELECT * FROM Visit.Visits;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Visits
    @patient_id INT,
    @department_id INT,
    @visit_date DATETIME,
    @visit_type NVARCHAR(50),
    @reason NVARCHAR(255),
    @status NVARCHAR(20),
    @Leaving_date DATETIME,
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    INSERT INTO Visit.Visits (patient_id, department_id, visit_date, visit_type, reason, status, discharge_date, created_at, updated_at)
    VALUES (@patient_id, @department_id, @visit_date, @visit_type, @reason, @status, @Leaving_date, @created_at, @updated_at);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Visits
    @visit_id INT,
    @patient_id INT,
    @department_id INT,
    @visit_date DATETIME,
    @visit_type NVARCHAR(50),
    @reason NVARCHAR(255),
    @status NVARCHAR(20),
    @Leaving_date DATETIME,
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    UPDATE Visit.Visits
    SET
        patient_id = @patient_id,
        department_id = @department_id,
        visit_date = @visit_date,
        visit_type = @visit_type,
        reason = @reason,
        status = @status,
        discharge_date = @Leaving_date,
        created_at = @created_at,
        updated_at = @updated_at
    WHERE visit_id = @visit_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Visits
    @visit_id INT
AS
BEGIN
    DELETE FROM Visit.Visits
    WHERE visit_id = @visit_id;
END;
GO


-- =============================================
-- Procedures for Patients.Patients
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Patients
AS
BEGIN
    SELECT * FROM Patient.Patients;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Patients
    @first_name NVARCHAR(100),
    @last_name NVARCHAR(100),
    @date_of_birth DATE,
    @gender NVARCHAR(10),
    @phone_number NVARCHAR(20),
    @email NVARCHAR(100),
    @address NVARCHAR(255),
    @emergency_contact_name NVARCHAR(100),
    @emergency_contact_phone NVARCHAR(20),
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    INSERT INTO Patient.Patients (first_name, last_name, date_of_birth, gender, phone_number, email, address, emergency_contact_name, emergency_contact_phone, created_at, updated_at)
    VALUES (@first_name, @last_name, @date_of_birth, @gender, @phone_number, @email, @address, @emergency_contact_name, @emergency_contact_phone, @created_at, @updated_at);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Patients
    @patient_id INT,
    @first_name NVARCHAR(100),
    @last_name NVARCHAR(100),
    @date_of_birth DATE,
    @gender NVARCHAR(10),
    @phone_number NVARCHAR(20),
    @email NVARCHAR(100),
    @address NVARCHAR(255),
    @emergency_contact_name NVARCHAR(100),
    @emergency_contact_phone NVARCHAR(20),
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    UPDATE Patient.Patients
    SET
        first_name = @first_name,
        last_name = @last_name,
        date_of_birth = @date_of_birth,
        gender = @gender,
        phone_number = @phone_number,
        email = @email,
        address = @address,
        emergency_contact_name = @emergency_contact_name,
        emergency_contact_phone = @emergency_contact_phone,
        created_at = @created_at,
        updated_at = @updated_at
    WHERE patient_id = @patient_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Patients
    @patient_id INT
AS
BEGIN
    DELETE FROM Patient.Patients
    WHERE patient_id = @patient_id;
END;
GO


-- =============================================
-- Procedures for Patients.Allergies
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Allergies
AS
BEGIN
    SELECT * FROM Patient.Allergies;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Allergies
    @patient_id INT,
    @allergy_name NVARCHAR(100),
    @severity NVARCHAR(50)
AS
BEGIN
    INSERT INTO Patient.Allergies (patient_id, allergy_name, severity)
    VALUES (@patient_id, @allergy_name, @severity);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Allergies
    @allergy_id INT,
    @patient_id INT,
    @allergy_name NVARCHAR(100),
    @severity NVARCHAR(50)
AS
BEGIN
    UPDATE Patient.Allergies
    SET
        patient_id = @patient_id,
        allergy_name = @allergy_name,
        severity = @severity
    WHERE allergy_id = @allergy_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Allergies
    @allergy_id INT
AS
BEGIN
    DELETE FROM Patient.Allergies
    WHERE allergy_id = @allergy_id;
END;
GO


-- =============================================
-- Procedures for Patients.Chronic_Conditions
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Chronic_Conditions
AS
BEGIN
    SELECT * FROM Patient.Chronic_Conditions;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Chronic_Conditions
    @patient_id INT,
    @condition_name NVARCHAR(100),
    @diagnosis_date DATE,
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    INSERT INTO Patient.Chronic_Conditions (patient_id, condition_name, diagnosis_date, created_at, updated_at)
    VALUES (@patient_id, @condition_name, @diagnosis_date, @created_at, @updated_at);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Chronic_Conditions
    @condition_id INT,
    @patient_id INT,
    @condition_name NVARCHAR(100),
    @diagnosis_date DATE,
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    UPDATE Patient.Chronic_Conditions
    SET
        patient_id = @patient_id,
        condition_name = @condition_name,
        diagnosis_date = @diagnosis_date,
        created_at = @created_at,
        updated_at = @updated_at
    WHERE condition_id = @condition_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Chronic_Conditions
    @condition_id INT
AS
BEGIN
    DELETE FROM Patient.Chronic_Conditions
    WHERE condition_id = @condition_id;
END;
GO


-- =============================================
-- Procedures for Visits.Medical_Records
-- =============================================

-- SELECT
CREATE OR ALTER PROCEDURE GetAll_Medical_Records
AS
BEGIN
    SELECT * FROM Visit.Medical_Records;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Insert_Medical_Records
    @visit_id INT,
    @diagnosis_summary NVARCHAR(MAX),
    @test_summary NVARCHAR(MAX),
    @radiology_summary NVARCHAR(MAX),
    @chronic_conditions NVARCHAR(MAX),
    @allergies NVARCHAR(MAX),
    @general_health_status NVARCHAR(50),
    @treatment_plan NVARCHAR(MAX),
    @doctor_notes NVARCHAR(MAX),
    @follow_up_required bit ,
    @follow_up_date DATE,
    @lifestyle_notes NVARCHAR(MAX),
    @created_by INT,
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    INSERT INTO Visit.Medical_Records (visit_id, diagnosis_summary, test_summary, radiology_summary, chronic_conditions, allergies, general_health_status, treatment_plan, doctor_notes, follow_up_required, follow_up_required, lifestyle_notes, created_by, created_at, updated_at)
    VALUES (@visit_id, @diagnosis_summary, @test_summary, @radiology_summary, @chronic_conditions, @allergies, @general_health_status, @treatment_plan, @doctor_notes, @follow_up_required, @follow_up_date, @lifestyle_notes, @created_by, @created_at, @updated_at);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE Update_Medical_Records
    @record_id INT,
    @visit_id INT,
    @diagnosis_summary NVARCHAR(MAX),
    @test_summary NVARCHAR(MAX),
    @radiology_summary NVARCHAR(MAX),
    @chronic_conditions NVARCHAR(MAX),
    @allergies NVARCHAR(MAX),
    @general_health_status NVARCHAR(50),
    @treatment_plan NVARCHAR(MAX),
    @doctor_notes NVARCHAR(MAX),
    @follow_up_required Bit,
    @follow_up_date DATE,
    @lifestyle_notes NVARCHAR(MAX),
    @created_by INT,
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    UPDATE Visit.Medical_Records
    SET
        visit_id = @visit_id,
        diagnosis_summary = @diagnosis_summary,
        test_summary = @test_summary,
        radiology_summary = @radiology_summary,
        chronic_conditions = @chronic_conditions,
        allergies = @allergies,
        general_health_status = @general_health_status,
        treatment_plan = @treatment_plan,
        doctor_notes = @doctor_notes,
        follow_up_required = @follow_up_required,
        follow_up_required = @follow_up_required,
        lifestyle_notes = @lifestyle_notes,
        created_by = @created_by,
        created_at = @created_at,
        updated_at = @updated_at
    WHERE record_id = @record_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE Delete_Medical_Records
    @record_id INT
AS
BEGIN
    DELETE FROM Visit.Medical_Records
    WHERE record_id = @record_id;
END;
GO
