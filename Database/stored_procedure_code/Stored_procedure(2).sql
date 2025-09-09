CREATE PROCEDURE usp_ManageHospitalData
    @TableName NVARCHAR(100),
    @Action NVARCHAR(10),  -- 'SELECT', 'INSERT', 'UPDATE', 'DELETE'
    @PrimaryKeyID INT = NULL,  -- Used for UPDATE/DELETE to identify the row
    @JsonData NVARCHAR(MAX) = NULL  -- JSON string with column data for INSERT/UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Nurses
    IF @TableName = 'Nurses'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Nurses;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Nurses WHERE nurse_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @nurse_employee_id INT,
                    @nurse_license_number NVARCHAR(100),
                    @nurse_experience_years INT,
                    @nurse_specialization NVARCHAR(100);

            SELECT 
                @nurse_employee_id = JSON_VALUE(@JsonData, '$.employee_id'),
                @nurse_license_number = JSON_VALUE(@JsonData, '$.license_number'),
                @nurse_experience_years = JSON_VALUE(@JsonData, '$.experience_years'),
                @nurse_specialization = JSON_VALUE(@JsonData, '$.specialization');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Nurses (employee_id, license_number, experience_years, specialization)
                VALUES (@nurse_employee_id, @nurse_license_number, @nurse_experience_years, @nurse_specialization);
            END
            ELSE
            BEGIN
                UPDATE Nurses
                SET employee_id = @nurse_employee_id,
                    license_number = @nurse_license_number,
                    experience_years = @nurse_experience_years,
                    specialization = @nurse_specialization
                WHERE nurse_id = @PrimaryKeyID;
            END
        END
    END

    -- Nurse_Room_Assignments
    ELSE IF @TableName = 'Nurse_Room_Assignments'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Logistics.Nurse_Room_Assignments;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Logistics.Nurse_Room_Assignments WHERE assignment_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @nra_nurse_id INT,
                    @nra_room_id INT,
                    @nra_assigned_at DATETIME,
                    @nra_shift_id INT,
                    @nra_notes NVARCHAR(255);

            SELECT 
                @nra_nurse_id = JSON_VALUE(@JsonData, '$.nurse_id'),
                @nra_room_id = JSON_VALUE(@JsonData, '$.room_id'),
                @nra_assigned_at = JSON_VALUE(@JsonData, '$.assigned_at'),
                @nra_shift_id = JSON_VALUE(@JsonData, '$.shift_id'),
                @nra_notes = JSON_VALUE(@JsonData, '$.notes');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Logistics.Nurse_Room_Assignments (nurse_id, room_id, assigned_at, shift_id)
                VALUES (@nra_nurse_id, @nra_room_id, @nra_assigned_at, @nra_shift_id, @nra_notes);
            END
            ELSE
            BEGIN
                UPDATE Logistics.Nurse_Room_Assignments
                SET nurse_id = @nra_nurse_id,
                    room_id = @nra_room_id,
                    assigned_at = @nra_assigned_at,
                    shift_id = @nra_shift_id
                    
                WHERE assignment_id = @PrimaryKeyID;
            END
        END
    END

    -- Visit_Rooms
    ELSE IF @TableName = 'Visit_Rooms'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Visit.Visit_Rooms;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Visit.Visit_Rooms WHERE visit_room_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @vr_visit_id INT,
                    @vr_room_id INT,
                    @vr_start_time DATETIME,
                    @vr_end_time DATETIME;

            SELECT 
                @vr_visit_id = JSON_VALUE(@JsonData, '$.visit_id'),
                @vr_room_id = JSON_VALUE(@JsonData, '$.room_id'),
                @vr_start_time = JSON_VALUE(@JsonData, '$.start_time'),
                @vr_end_time = JSON_VALUE(@JsonData, '$.end_time');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Visit.Visit_Rooms (visit_id, room_id, start_time, end_time)
                VALUES (@vr_visit_id, @vr_room_id, @vr_start_time, @vr_end_time);
            END
            ELSE
            BEGIN
                UPDATE Visit.Visit_Rooms
                SET visit_id = @vr_visit_id,
                    room_id = @vr_room_id,
                    start_time = @vr_start_time,
                    end_time = @vr_end_time
                WHERE visit_room_id = @PrimaryKeyID;
            END
        END
    END

    -- Rooms
    ELSE IF @TableName = 'Rooms'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Logistics.Rooms;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Logistics.Rooms WHERE room_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @rooms_room_number NVARCHAR(20),
                    @rooms_floor INT,
                    @rooms_capacity INT,
                    @rooms_room_type NVARCHAR(50),
                    @rooms_department_id INT,
                    @rooms_status NVARCHAR(50),
                    @rooms_created_at DATETIME,
                    @rooms_updated_at DATETIME;

            SELECT 
                @rooms_room_number = JSON_VALUE(@JsonData, '$.room_number'),
                @rooms_floor = JSON_VALUE(@JsonData, '$.floor'),
                @rooms_capacity = JSON_VALUE(@JsonData, '$.capacity'),
                @rooms_room_type = JSON_VALUE(@JsonData, '$.room_type'),
                @rooms_department_id = JSON_VALUE(@JsonData, '$.department_id'),
                @rooms_status = JSON_VALUE(@JsonData, '$.status'),
                @rooms_created_at = JSON_VALUE(@JsonData, '$.created_at'),
                @rooms_updated_at = JSON_VALUE(@JsonData, '$.updated_at');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Logistics.Rooms (room_number, floor, capacity, room_type, department_id, status, created_at, updated_at)
                VALUES (@rooms_room_number, @rooms_floor, @rooms_capacity, @rooms_room_type, @rooms_department_id, @rooms_status, @rooms_created_at, @rooms_updated_at);
            END
            ELSE
            BEGIN
                UPDATE Logistics.Rooms
                SET room_number = @rooms_room_number,
                    floor = @rooms_floor,
                    capacity = @rooms_capacity,
                    room_type = @rooms_room_type,
                    department_id = @rooms_department_id,
                    status = @rooms_status,
                    created_at = @rooms_created_at,
                    updated_at = @rooms_updated_at
                WHERE room_id = @PrimaryKeyID;
            END
        END
    END

    -- Beds
    ELSE IF @TableName = 'Beds'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Logistics.Beds;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Logistics.Beds WHERE bed_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @beds_room_id INT,
                    @beds_bed_number NVARCHAR(10),
                    @beds_status NVARCHAR(50);

            SELECT 
                @beds_room_id = JSON_VALUE(@JsonData, '$.room_id'),
                @beds_bed_number = JSON_VALUE(@JsonData, '$.bed_number'),
                @beds_status = JSON_VALUE(@JsonData, '$.status');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Logistics.Beds (room_id, bed_number, status)
                VALUES (@beds_room_id, @beds_bed_number, @beds_status);
            END
            ELSE
            BEGIN
                UPDATE Logistics.Beds
                SET room_id = @beds_room_id,
                    bed_number = @beds_bed_number,
                    status = @beds_status
                WHERE bed_id = @PrimaryKeyID;
            END
        END
    END

    -- Visits
    ELSE IF @TableName = 'Visits'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Visit.Visits;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Visit.Visits WHERE visit_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @visits_patient_id INT,
                    @visits_department_id INT,
                    @visits_visit_date DATETIME,
                    @visits_visit_type NVARCHAR(50),
                    @visits_reason NVARCHAR(255),
                    @visits_status NVARCHAR(20),
                    @visits_leaving_date DATETIME,
                    @visits_created_at DATETIME,
                    @visits_updated_at DATETIME;

            SELECT 
                @visits_patient_id = JSON_VALUE(@JsonData, '$.patient_id'),
                @visits_department_id = JSON_VALUE(@JsonData, '$.department_id'),
                @visits_visit_date = JSON_VALUE(@JsonData, '$.visit_date'),
                @visits_visit_type = JSON_VALUE(@JsonData, '$.visit_type'),
                @visits_reason = JSON_VALUE(@JsonData, '$.reason'),
                @visits_status = JSON_VALUE(@JsonData, '$.status'),
                @visits_leaving_date = JSON_VALUE(@JsonData, '$.leaving_date'),
                @visits_created_at = JSON_VALUE(@JsonData, '$.created_at'),
                @visits_updated_at = JSON_VALUE(@JsonData, '$.updated_at');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Visit.Visits (patient_id, department_id, visit_date, visit_type, reason, status, discharge_date, created_at, updated_at)
                VALUES (@visits_patient_id, @visits_department_id, @visits_visit_date, @visits_visit_type, @visits_reason, @visits_status, @visits_leaving_date, @visits_created_at, @visits_updated_at);
            END
            ELSE
            BEGIN
                UPDATE Visit.Visits
                SET patient_id = @visits_patient_id,
                    department_id = @visits_department_id,
                    visit_date = @visits_visit_date,
                    visit_type = @visits_visit_type,
                    reason = @visits_reason,
                    status = @visits_status,
                    discharge_date = @visits_leaving_date,
                    created_at = @visits_created_at,
                    updated_at = @visits_updated_at
                WHERE visit_id = @PrimaryKeyID;
            END
        END
    END

    -- Patients
    ELSE IF @TableName = 'Patients'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Patient.Patients;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Patient.Patients WHERE patient_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @patients_first_name NVARCHAR(100),
                    @patients_last_name NVARCHAR(100),
                    @patients_date_of_birth DATE,
                    @patients_gender NVARCHAR(10),
                    @patients_phone_number NVARCHAR(20),
                    @patients_email NVARCHAR(100),
                    @patients_address NVARCHAR(255),
                    @patients_emergency_contact_name NVARCHAR(100),
                    @patients_emergency_contact_phone NVARCHAR(20),
                    @patients_created_at DATETIME,
                    @patients_updated_at DATETIME;

            SELECT 
                @patients_first_name = JSON_VALUE(@JsonData, '$.first_name'),
                @patients_last_name = JSON_VALUE(@JsonData, '$.last_name'),
                @patients_date_of_birth = JSON_VALUE(@JsonData, '$.date_of_birth'),
                @patients_gender = JSON_VALUE(@JsonData, '$.gender'),
                @patients_phone_number = JSON_VALUE(@JsonData, '$.phone_number'),
                @patients_email = JSON_VALUE(@JsonData, '$.email'),
                @patients_address = JSON_VALUE(@JsonData, '$.address'),
                @patients_emergency_contact_name = JSON_VALUE(@JsonData, '$.emergency_contact_name'),
                @patients_emergency_contact_phone = JSON_VALUE(@JsonData, '$.emergency_contact_phone'),
                @patients_created_at = JSON_VALUE(@JsonData, '$.created_at'),
                @patients_updated_at = JSON_VALUE(@JsonData, '$.updated_at');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Patient.Patients (
                    first_name, last_name, date_of_birth, gender, phone_number, email, address, emergency_contact_name, emergency_contact_phone, created_at, updated_at
                ) VALUES (
                    @patients_first_name, @patients_last_name, @patients_date_of_birth, @patients_gender, @patients_phone_number, @patients_email, @patients_address, @patients_emergency_contact_name, @patients_emergency_contact_phone, @patients_created_at, @patients_updated_at
                );
            END
            ELSE
            BEGIN
                UPDATE Patient.Patients
                SET first_name = @patients_first_name,
                    last_name = @patients_last_name,
                    date_of_birth = @patients_date_of_birth,
                    gender = @patients_gender,
                    phone_number = @patients_phone_number,
                    email = @patients_email,
                    address = @patients_address,
                    emergency_contact_name = @patients_emergency_contact_name,
                    emergency_contact_phone = @patients_emergency_contact_phone,
                    created_at = @patients_created_at,
                    updated_at = @patients_updated_at
                WHERE patient_id = @PrimaryKeyID;
            END
        END
    END

    -- Allergies
    ELSE IF @TableName = 'Allergies'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Patient.Allergies;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Patient.Allergies WHERE allergy_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @allergies_patient_id INT,
                    @allergies_allergy_name NVARCHAR(100),
                    @allergies_severity NVARCHAR(50);

            SELECT 
                @allergies_patient_id = JSON_VALUE(@JsonData, '$.patient_id'),
                @allergies_allergy_name = JSON_VALUE(@JsonData, '$.allergy_name'),
                @allergies_severity = JSON_VALUE(@JsonData, '$.severity');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Patient.Allergies (patient_id, allergy_name, severity)
                VALUES (@allergies_patient_id, @allergies_allergy_name, @allergies_severity);
            END
            ELSE
            BEGIN
                UPDATE Patient.Allergies
                SET patient_id = @allergies_patient_id,
                    allergy_name = @allergies_allergy_name,
                    severity = @allergies_severity
                WHERE allergy_id = @PrimaryKeyID;
            END
        END
    END

    -- Chronic_Conditions
    ELSE IF @TableName = 'Chronic_Conditions'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Patient.Chronic_Conditions;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Patient.Chronic_Conditions WHERE condition_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @cc_patient_id INT,
                    @cc_condition_name NVARCHAR(100),
                    @cc_diagnosis_date DATE,
                    @cc_created_at DATETIME,
                    @cc_updated_at DATETIME;

            SELECT 
                @cc_patient_id = JSON_VALUE(@JsonData, '$.patient_id'),
                @cc_condition_name = JSON_VALUE(@JsonData, '$.condition_name'),
                @cc_diagnosis_date = JSON_VALUE(@JsonData, '$.diagnosis_date'),
                @cc_created_at = JSON_VALUE(@JsonData, '$.created_at'),
                @cc_updated_at = JSON_VALUE(@JsonData, '$.updated_at');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Patient.Chronic_Conditions (patient_id, condition_name, diagnosis_date, created_at, updated_at)
                VALUES (@cc_patient_id, @cc_condition_name, @cc_diagnosis_date, @cc_created_at, @cc_updated_at);
            END
            ELSE
            BEGIN
                UPDATE Patient.Chronic_Conditions
                SET patient_id = @cc_patient_id,
                    condition_name = @cc_condition_name,
                    diagnosis_date = @cc_diagnosis_date,
                    created_at = @cc_created_at,
                    updated_at = @cc_updated_at
                WHERE condition_id = @PrimaryKeyID;
            END
        END
    END

    -- Medical_Records
    ELSE IF @TableName = 'Medical_Records'
    BEGIN
        IF @Action = 'SELECT'
        BEGIN
            SELECT * FROM Visit.Medical_Records;
        END
        ELSE IF @Action = 'DELETE'
        BEGIN
            DELETE FROM Visit.Medical_Records WHERE record_id = @PrimaryKeyID;
        END
        ELSE IF @Action IN ('INSERT', 'UPDATE')
        BEGIN
            DECLARE @mr_visit_id INT,
                    @mr_diagnosis_summary NVARCHAR(MAX),
                    @mr_test_summary NVARCHAR(MAX),
                    @mr_radiology_summary NVARCHAR(MAX),
                    @mr_chronic_conditions NVARCHAR(MAX),
                    @mr_allergies NVARCHAR(MAX),
                    @mr_general_health_status NVARCHAR(50),
                    @mr_treatment_plan NVARCHAR(MAX),
                    @mr_doctor_notes NVARCHAR(MAX),
                    @mr_follow_up_required BIT,
                    @mr_follow_up_date DATE,
                    @mr_lifestyle_notes NVARCHAR(MAX),
                    @mr_created_by INT,
                    @mr_created_at DATETIME,
                    @mr_updated_at DATETIME;

            SELECT 
                @mr_visit_id = JSON_VALUE(@JsonData, '$.visit_id'),
                @mr_diagnosis_summary = JSON_VALUE(@JsonData, '$.diagnosis_summary'),
                @mr_test_summary = JSON_VALUE(@JsonData, '$.test_summary'),
                @mr_radiology_summary = JSON_VALUE(@JsonData, '$.radiology_summary'),
                @mr_chronic_conditions = JSON_VALUE(@JsonData, '$.chronic_conditions'),
                @mr_allergies = JSON_VALUE(@JsonData, '$.allergies'),
                @mr_general_health_status = JSON_VALUE(@JsonData, '$.general_health_status'),
                @mr_treatment_plan = JSON_VALUE(@JsonData, '$.treatment_plan'),
                @mr_doctor_notes = JSON_VALUE(@JsonData, '$.doctor_notes'),
                @mr_follow_up_required = JSON_VALUE(@JsonData, '$.follow_up_required'),
                @mr_follow_up_date = JSON_VALUE(@JsonData, '$.follow_up_date'),
                @mr_lifestyle_notes = JSON_VALUE(@JsonData, '$.lifestyle_notes'),
                @mr_created_by = JSON_VALUE(@JsonData, '$.created_by'),
                @mr_created_at = JSON_VALUE(@JsonData, '$.created_at'),
                @mr_updated_at = JSON_VALUE(@JsonData, '$.updated_at');

            IF @Action = 'INSERT'
            BEGIN
                INSERT INTO Visit.Medical_Records (
                    visit_id, diagnosis_summary, test_summary, radiology_summary, chronic_conditions, allergies, 
                    general_health_status, treatment_plan, doctor_notes, follow_up_required, 
                    lifestyle_notes, created_by, created_at, updated_at
                )
                VALUES (
                    @mr_visit_id, @mr_diagnosis_summary, @mr_test_summary, @mr_radiology_summary, @mr_chronic_conditions, @mr_allergies, 
                    @mr_general_health_status, @mr_treatment_plan, @mr_doctor_notes, @mr_follow_up_required, @mr_follow_up_date, 
                    @mr_lifestyle_notes, @mr_created_by, @mr_created_at, @mr_updated_at
                );
            END
            ELSE
            BEGIN
                UPDATE Visit.Medical_Records
                SET 
                    visit_id = @mr_visit_id,
                    diagnosis_summary = @mr_diagnosis_summary,
                    test_summary = @mr_test_summary,
                    radiology_summary = @mr_radiology_summary,
                    chronic_conditions = @mr_chronic_conditions,
                    allergies = @mr_allergies,
                    general_health_status = @mr_general_health_status,
                    treatment_plan = @mr_treatment_plan,
                    doctor_notes = @mr_doctor_notes,
                    follow_up_required = @mr_follow_up_required,
                    lifestyle_notes = @mr_lifestyle_notes,
                    created_by = @mr_created_by,
                    created_at = @mr_created_at,
                    updated_at = @mr_updated_at
                WHERE record_id = @PrimaryKeyID;
            END
        END
    END

    ELSE
    BEGIN
        RAISERROR('TableName %s is not supported by this procedure.', 16, 1, @TableName);
    END
END
go
--1. Manage Nurses
CREATE PROCEDURE usp_ManageNurses
    @NurseID INT = NULL,
    @EmployeeID INT = NULL,
    @LicenseNumber NVARCHAR(100) = NULL,
    @ExperienceYears INT = NULL,
    @Specialization NVARCHAR(100) = NULL,
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    IF @Action = 'SELECT'
    BEGIN
        SELECT nurse_id, employee_id, license_number, experience_years, specialization
        FROM Nurses;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Nurses (employee_id, license_number, experience_years, specialization)
        VALUES (@EmployeeID, @LicenseNumber, @ExperienceYears, @Specialization);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Nurses
        SET employee_id = @EmployeeID,
            license_number = @LicenseNumber,
            experience_years = @ExperienceYears,
            specialization = @Specialization
        WHERE nurse_id = @NurseID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Nurses WHERE nurse_id = @NurseID;
    END
END
go
--2. Manage Nurse_Room_Assignments (link Nurses to Rooms)
CREATE PROCEDURE usp_ManageNurseRoomAssignments
    @AssignmentID INT = NULL,
    @NurseID INT,
    @RoomID INT,
    @AssignedAt DATETIME,
    @ShiftID INT,
    @Notes NVARCHAR(255),
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT nra.assignment_id, nra.nurse_id,  
               nra.room_id, r.room_number, nra.assigned_at, nra.shift_id
        FROM Logistics.Nurse_Room_Assignments nra
        JOIN Nurses n ON nra.nurse_id = n.nurse_id
        JOIN Logistics.Rooms r ON nra.room_id = r.room_id;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Logistics.Nurse_Room_Assignments (nurse_id, room_id, assigned_at, shift_id)
        VALUES (@NurseID, @RoomID, @AssignedAt, @ShiftID, @Notes);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Logistics.Nurse_Room_Assignments
        SET nurse_id = @NurseID,
            room_id = @RoomID,
            assigned_at = @AssignedAt,
            shift_id = @ShiftID
            
        WHERE assignment_id = @AssignmentID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Logistics.Nurse_Room_Assignments WHERE assignment_id = @AssignmentID;
    END
END
go
--3. Manage Visit_Rooms (link Visits to Rooms)
CREATE PROCEDURE usp_ManageVisitRooms
    @VisitRoomID INT = NULL,
    @VisitID INT,
    @RoomID INT,
    @StartTime DATETIME,
    @EndTime DATETIME,
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT vr.visit_room_id, vr.visit_id, v.patient_id, p.first_name + ' ' + p.last_name AS patient_name,
               vr.room_id, r.room_number, vr.start_time, vr.end_time
        FROM Visit.Visit_Rooms vr
        JOIN Visit.Visits v ON vr.visit_id = v.visit_id
        JOIN Patient.Patients p ON v.patient_id = p.patient_id
        JOIN Logistics.Rooms r ON vr.room_id = r.room_id;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Visit.Visit_Rooms (visit_id, room_id, start_time, end_time)
        VALUES (@VisitID, @RoomID, @StartTime, @EndTime);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Visit.Visit_Rooms
        SET visit_id = @VisitID,
            room_id = @RoomID,
            start_time = @StartTime,
            end_time = @EndTime
        WHERE visit_room_id = @VisitRoomID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Visit.Visit_Rooms WHERE visit_room_id = @VisitRoomID;
    END
END
go
--4. Manage Rooms
CREATE PROCEDURE usp_ManageRooms
    @RoomID INT = NULL,
    @RoomNumber NVARCHAR(20),
    @Floor INT,
    @Capacity INT,
    @RoomType NVARCHAR(50),
    @DepartmentID INT,
    @Status NVARCHAR(50),
    @CreatedAt DATETIME,
    @UpdatedAt DATETIME,
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT * FROM Logistics.Rooms;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Logistics.Rooms (room_number, floor, capacity, room_type, department_id, status, created_at, updated_at)
        VALUES (@RoomNumber, @Floor, @Capacity, @RoomType, @DepartmentID, @Status, @CreatedAt, @UpdatedAt);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Logistics.Rooms
        SET room_number = @RoomNumber,
            floor = @Floor,
            capacity = @Capacity,
            room_type = @RoomType,
            department_id = @DepartmentID,
            status = @Status,
            created_at = @CreatedAt,
            updated_at = @UpdatedAt
        WHERE room_id = @RoomID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Logistics.Rooms WHERE room_id = @RoomID;
    END
END
go
--5. Manage Beds (children of Rooms)
CREATE PROCEDURE usp_ManageBeds
    @BedID INT = NULL,
    @RoomID INT,
    @BedNumber NVARCHAR(10),
    @Status NVARCHAR(50),
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT b.bed_id, b.room_id, r.room_number, b.bed_number, b.status
        FROM Logistics.Beds b
        JOIN Logistics.Rooms r ON b.room_id = r.room_id;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Logistics.Beds (room_id, bed_number, status)
        VALUES (@RoomID, @BedNumber, @Status);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Logistics.Beds
        SET room_id = @RoomID,
            bed_number = @BedNumber,
            status = @Status
        WHERE bed_id = @BedID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Logistics.Beds WHERE bed_id = @BedID;
    END
END
go
--6. Manage Visits
CREATE PROCEDURE usp_ManageVisits
    @VisitID INT = NULL,
    @PatientID INT,
    @DepartmentID INT,
    @VisitDate DATETIME,
    @VisitType NVARCHAR(50),
    @Reason NVARCHAR(255),
    @Status NVARCHAR(20),
    @LeavingDate DATETIME = NULL,
    @CreatedAt DATETIME,
    @UpdatedAt DATETIME,
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT * FROM Visit.Visits;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Visit.Visits (patient_id, department_id, visit_date, visit_type, reason, status, discharge_date, created_at, updated_at)
        VALUES (@PatientID, @DepartmentID, @VisitDate, @VisitType, @Reason, @Status, @LeavingDate, @CreatedAt, @UpdatedAt);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Visit.Visits
        SET patient_id = @PatientID,
            department_id = @DepartmentID,
            visit_date = @VisitDate,
            visit_type = @VisitType,
            reason = @Reason,
            status = @Status,
            discharge_date = @LeavingDate,
            created_at = @CreatedAt,
            updated_at = @UpdatedAt
        WHERE visit_id = @VisitID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Visit.Visits WHERE visit_id = @VisitID;
    END
END
go
--7. Manage Patients
CREATE PROCEDURE usp_ManagePatients
    @PatientID INT = NULL,
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @PhoneNumber NVARCHAR(20),
    @Email NVARCHAR(100),
    @Address NVARCHAR(255),
    @EmergencyContactName NVARCHAR(100),
    @EmergencyContactPhone NVARCHAR(20),
    @CreatedAt DATETIME,
    @UpdatedAt DATETIME,
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT * FROM Patient.Patients;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Patient.Patients (first_name, last_name, date_of_birth, gender, phone_number, email, address, emergency_contact_name, emergency_contact_phone, created_at, updated_at)
        VALUES (@FirstName, @LastName, @DateOfBirth, @Gender, @PhoneNumber, @Email, @Address, @EmergencyContactName, @EmergencyContactPhone, @CreatedAt, @UpdatedAt);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Patient.Patients
        SET first_name = @FirstName,
            last_name = @LastName,
            date_of_birth = @DateOfBirth,
            gender = @Gender,
            phone_number = @PhoneNumber,
            email = @Email,
            address = @Address,
            emergency_contact_name = @EmergencyContactName,
            emergency_contact_phone = @EmergencyContactPhone,
            created_at = @CreatedAt,
            updated_at = @UpdatedAt
        WHERE patient_id = @PatientID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Patient.Patients WHERE patient_id = @PatientID;
    END
END
go
--8. Manage Allergies (per Patient)
CREATE PROCEDURE usp_ManageAllergies
    @AllergyID INT = NULL,
    @PatientID INT,
    @AllergyName NVARCHAR(100),
    @Severity NVARCHAR(50),
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT * FROM Patient.Allergies;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Patient.Allergies (patient_id, allergy_name, severity)
        VALUES (@PatientID, @AllergyName, @Severity);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Patient.Allergies
        SET patient_id = @PatientID,
            allergy_name = @AllergyName,
            severity = @Severity
        WHERE allergy_id = @AllergyID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Patient.Allergies WHERE allergy_id = @AllergyID;
    END
END

go

CREATE PROCEDURE usp_ManageAllergies
    @AllergyID INT = NULL,
    @PatientID INT,
    @AllergyName NVARCHAR(100),
    @Severity NVARCHAR(50),
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT * FROM Patient.Allergies;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Patient.Allergies (patient_id, allergy_name, severity)
        VALUES (@PatientID, @AllergyName, @Severity);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Patient.Allergies
        SET patient_id = @PatientID,
            allergy_name = @AllergyName,
            severity = @Severity
        WHERE allergy_id = @AllergyID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Patient.Allergies WHERE allergy_id = @AllergyID;
    END
END
go
--9. Manage Chronic_Conditions
CREATE PROCEDURE usp_ManageChronicConditions
    @ConditionID INT = NULL,
    @PatientID INT,
    @ConditionName NVARCHAR(100),
    @DiagnosisDate DATE,
    @CreatedAt DATETIME,
    @UpdatedAt DATETIME,
    @Action NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT * FROM Patient.Chronic_Conditions;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Patient.Chronic_Conditions (patient_id, condition_name, diagnosis_date, created_at, updated_at)
        VALUES (@PatientID, @ConditionName, @DiagnosisDate, @CreatedAt, @UpdatedAt);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Patient.Chronic_Conditions
        SET patient_id = @PatientID,
            condition_name = @ConditionName,
            diagnosis_date = @DiagnosisDate,
            created_at = @CreatedAt,
            updated_at = @UpdatedAt
        WHERE condition_id = @ConditionID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Patient.Chronic_Conditions WHERE condition_id = @ConditionID;
    END
END
go
--10. Manage Medical_Records
CREATE PROCEDURE usp_ManageMedicalRecords
    @RecordID INT = NULL,                            -- For update/delete
    @VisitID INT,                                    -- Unique visit reference
    @DiagnosisSummary NVARCHAR(MAX),
    @TestSummary NVARCHAR(MAX),
    @RadiologySummary NVARCHAR(MAX),
    @ChronicConditions NVARCHAR(MAX),
    @Allergies NVARCHAR(MAX),
    @GeneralHealthStatus NVARCHAR(50),               -- 'Good' | 'Fair' | 'Critical'
    @TreatmentPlan NVARCHAR(MAX),
    @DoctorNotes NVARCHAR(MAX),
    @FollowUpRequired BIT = 0,
    @FollowUpDate DATE = NULL,
    @LifestyleNotes NVARCHAR(MAX),
    @CreatedBy INT,
    @CreatedAt DATETIME = NULL,
    @UpdatedAt DATETIME = NULL,
    @Action NVARCHAR(10)                             -- 'SELECT', 'INSERT', 'UPDATE', 'DELETE'
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        -- Return all medical records with patient info
        SELECT mr.*, p.first_name + ' ' + p.last_name AS patient_name
        FROM Visit.Medical_Records mr
        JOIN Visit.Visits v ON mr.visit_id = v.visit_id
        JOIN Patient.Patients p ON v.patient_id = p.patient_id;
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        -- Insert new medical record
        INSERT INTO Visit.Medical_Records (
            visit_id, diagnosis_summary, test_summary, radiology_summary,
            chronic_conditions, allergies, general_health_status,
            treatment_plan, doctor_notes, follow_up_required,
             lifestyle_notes, created_by, created_at, updated_at
        )
        VALUES (
            @VisitID, @DiagnosisSummary, @TestSummary, @RadiologySummary,
            @ChronicConditions, @Allergies, @GeneralHealthStatus,
            @TreatmentPlan, @DoctorNotes, @FollowUpRequired,
            @FollowUpDate, @LifestyleNotes, @CreatedBy, 
            ISNULL(@CreatedAt, GETDATE()), ISNULL(@UpdatedAt, GETDATE())
        );
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        -- Update an existing record
        UPDATE Visit.Medical_Records
        SET diagnosis_summary = @DiagnosisSummary,
            test_summary = @TestSummary,
            radiology_summary = @RadiologySummary,
            chronic_conditions = @ChronicConditions,
            allergies = @Allergies,
            general_health_status = @GeneralHealthStatus,
            treatment_plan = @TreatmentPlan,
            doctor_notes = @DoctorNotes,
            follow_up_required = @FollowUpRequired,
            lifestyle_notes = @LifestyleNotes,
            created_by = @CreatedBy,
            updated_at = ISNULL(@UpdatedAt, GETDATE())
        WHERE record_id = @RecordID;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        -- Delete a record by ID
        DELETE FROM Visit.Medical_Records
        WHERE record_id = @RecordID;
    END
END
