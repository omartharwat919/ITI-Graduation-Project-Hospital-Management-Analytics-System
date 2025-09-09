                                 --Users Table
DROP PROCEDURE IF EXISTS dbo.sp_InsertUser;
GO

DROP PROCEDURE IF EXISTS [Admin].[sp_InsertUser];
GO

CREATE PROCEDURE [Admin].[sp_InsertUser]
    @username VARCHAR(50),
    @password_hash VARCHAR(255),
    @employee_id INT = NULL,
    @role_id INT,
    @patient_id INT = NULL
AS
BEGIN
    INSERT INTO [Admin].[Users] (username, password_hash, created_at, last_login, employee_id, role_id, patient_id)
    VALUES (@username, @password_hash, GETDATE(), NULL, @employee_id, @role_id, @patient_id);
END;
GO


CREATE PROCEDURE [Admin].[sp_UpdateUserLastLogin]
    @user_id INT
AS
BEGIN
    UPDATE [Admin].[Users]
    SET last_login = GETDATE()
    WHERE user_id = @user_id;
END;
go
CREATE PROCEDURE [Admin].[sp_GetUserByUsername]
    @username VARCHAR(50)
AS
BEGIN
    SELECT * FROM [Admin].[Users] WHERE username = @username;
END;
go
CREATE TRIGGER [Admin].[tr_Users_Audit]
ON [Admin].[Users]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        ISNULL((SELECT user_id FROM inserted), (SELECT user_id FROM deleted)),
        @action,
        'Users',
        ISNULL((SELECT user_id FROM inserted), (SELECT user_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'New user created: ' + (SELECT username FROM inserted)
            WHEN @action = 'UPDATE' THEN 'User updated. Old username: ' + (SELECT username FROM deleted) + 
                                       ', New username: ' + (SELECT username FROM inserted)
            ELSE 'User deleted: ' + (SELECT username FROM deleted)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;


 go                                  --Roles Table
CREATE PROCEDURE [Admin].[sp_InsertRole]
    @role_id INT,
    @role_code VARCHAR(50),
    @role_name_en VARCHAR(100)
AS
BEGIN
    INSERT INTO [Admin].[Roles] (role_id, role_code, role_name_en)
    VALUES (@role_id, @role_code, @role_name_en);
END;
 go 
CREATE PROCEDURE [Admin].[sp_GetAllRoles]
AS
BEGIN
    SELECT * FROM [Admin].[Roles];
END;
go
CREATE TRIGGER [Admin].[tr_Roles_Audit]
ON [Admin].[Roles]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        NULL, -- System action
        @action,
        'Roles',
        ISNULL((SELECT role_id FROM inserted), (SELECT role_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'New role created: ' + (SELECT role_name_en FROM inserted)
            WHEN @action = 'UPDATE' THEN 'Role updated. Old name: ' + (SELECT role_name_en FROM deleted) + 
                                       ', New name: ' + (SELECT role_name_en FROM inserted)
            ELSE 'Role deleted: ' + (SELECT role_name_en FROM deleted)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;


 go                                 --RolePermissions Table
CREATE PROCEDURE [Admin].[sp_AssignPermissionToRole]
    @role_id INT,
    @permission_id INT
AS
BEGIN
    INSERT INTO [Admin].[RolePermissions] (role_id, permission_id)
    VALUES (@role_id, @permission_id);
END;
 go 
CREATE PROCEDURE [Admin].[sp_RemovePermissionFromRole]
    @role_id INT,
    @permission_id INT
AS
BEGIN
    DELETE FROM [Admin].[RolePermissions]
    WHERE role_id = @role_id AND permission_id = @permission_id;
END;
Go

CREATE PROCEDURE [Admin].[sp_GetPermissionsForRole]
    @role_id INT
AS
BEGIN
    SELECT p.* 
    FROM [Admin].[Permissions] p
    JOIN [Admin].[RolePermissions] rp ON p.permission_id = rp.permission_id
    WHERE rp.role_id = @role_id;
END;
 go 
CREATE TRIGGER [Admin].[tr_RolePermissions_Audit]
ON [Admin].[RolePermissions]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        NULL, -- System action
        @action,
        'RolePermissions',
        ISNULL((SELECT role_id FROM inserted), (SELECT role_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'Permission assigned to role. Role ID: ' + CAST((SELECT role_id FROM inserted) AS VARCHAR) + 
                                        ', Permission ID: ' + CAST((SELECT permission_id FROM inserted) AS VARCHAR)
            WHEN @action = 'UPDATE' THEN 'Role permission updated. Old: Role ID: ' + CAST((SELECT role_id FROM deleted) AS VARCHAR) + 
                                        ', Permission ID: ' + CAST((SELECT permission_id FROM deleted) AS VARCHAR) +
                                        ' New: Role ID: ' + CAST((SELECT role_id FROM inserted) AS VARCHAR) + 
                                        ', Permission ID: ' + CAST((SELECT permission_id FROM inserted) AS VARCHAR)
            ELSE 'Permission removed from role. Role ID: ' + CAST((SELECT role_id FROM deleted) AS VARCHAR) + 
                 ', Permission ID: ' + CAST((SELECT permission_id FROM deleted) AS VARCHAR)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;

  go                       --Permissions Table
CREATE PROCEDURE [Admin].[sp_InsertPermission]
    @permission_id INT,
    @permission_code VARCHAR(100),
    @permission_description NVARCHAR(200)
AS
BEGIN
    INSERT INTO [Admin].[Permissions] (permission_id, permission_code, permission_description)
    VALUES (@permission_id, @permission_code, @permission_description);
END;
Go
CREATE PROCEDURE [Admin].[sp_GetAllPermissions]
AS
BEGIN
    SELECT * FROM [Admin].[Permissions];
END;
Go
CREATE TRIGGER [Admin].[tr_Permissions_Audit]
ON [Admin].[Permissions]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        NULL, -- System action
        @action,
        'Permissions',
        ISNULL((SELECT permission_id FROM inserted), (SELECT permission_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'New permission created: ' + (SELECT permission_code FROM inserted)
            WHEN @action = 'UPDATE' THEN 'Permission updated. Old code: ' + (SELECT permission_code FROM deleted) + 
                                       ', New code: ' + (SELECT permission_code FROM inserted)
            ELSE 'Permission deleted: ' + (SELECT permission_code FROM deleted)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;
Go
                        --Notifications Table
CREATE PROCEDURE [Scheduling].[sp_CreateNotification]
    @user_id INT,
    @message NVARCHAR(MAX),
    @is_read BIT = 0
AS
BEGIN
    INSERT INTO [Scheduling].[Notifications] (user_id, message, is_read, created_at)
    VALUES (@user_id, @message, @is_read, GETDATE());
END;
GO
CREATE PROCEDURE [Scheduling].[sp_MarkNotificationAsRead]
    @notification_id INT
AS
BEGIN
    UPDATE [Scheduling].[Notifications]
    SET is_read = 1
    WHERE notification_id = @notification_id;
END;
GO
CREATE PROCEDURE [Scheduling].[sp_GetUserNotifications]
    @user_id INT,
    @unread_only BIT = 0
AS
BEGIN
    IF @unread_only = 1
        SELECT * FROM [Scheduling].[Notifications] 
        WHERE user_id = @user_id AND is_read = 0
        ORDER BY created_at DESC;
    ELSE
        SELECT * FROM [Scheduling].[Notifications] 
        WHERE user_id = @user_id
        ORDER BY created_at DESC;
END;
GO
CREATE TRIGGER [Scheduling].[tr_Notifications_Audit]
ON [Scheduling].[Notifications]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        (SELECT user_id FROM inserted),
        @action,
        'Notifications',
        ISNULL((SELECT notification_id FROM inserted), (SELECT notification_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'Notification created for user: ' + CAST((SELECT user_id FROM inserted) AS VARCHAR)
            WHEN @action = 'UPDATE' THEN 'Notification updated. ID: ' + CAST((SELECT notification_id FROM inserted) AS VARCHAR)
            ELSE 'Notification deleted. ID: ' + CAST((SELECT notification_id FROM deleted) AS VARCHAR)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;
Go
                                   --AuditLogs Table
CREATE PROCEDURE [Admin].[sp_GetAuditLogs]
    @start_date DATETIME = NULL,
    @end_date DATETIME = NULL,
    @user_id INT = NULL,
    @entity_type VARCHAR(50) = NULL
AS
BEGIN
    SELECT * FROM [Admin].[AuditLogs]
    WHERE 
        (@start_date IS NULL OR timestamp >= @start_date) AND
        (@end_date IS NULL OR timestamp <= @end_date) AND
        (@user_id IS NULL OR user_id = @user_id) AND
        (@entity_type IS NULL OR entity_type = @entity_type)
    ORDER BY timestamp DESC;
END;

  go                                      --Employees Table
CREATE PROCEDURE [Admin].[sp_InsertEmployee]
    @full_name NVARCHAR(100),
    @national_id NVARCHAR(20),
    @gender NVARCHAR(10),
    @birth_date DATE,
    @phone_number NVARCHAR(20),
    @email NVARCHAR(100),
    @emp_address NVARCHAR(255),
    @hire_date DATE,
    @department_id INT,
    @emp_status NVARCHAR(20) = 'Active',
    @employee_type NVARCHAR(50),
    @seniority_level NVARCHAR(50)
AS
BEGIN
    INSERT INTO [Admin].[Employees] (full_name, national_id, gender, birth_date, phone_number, email, emp_address, 
                          hire_date, department_id, emp_status, employee_type, seniority_level, 
                          created_at, updated_at)
    VALUES (@full_name, @national_id, @gender, @birth_date, @phone_number, @email, @emp_address, 
            @hire_date, @department_id, @emp_status, @employee_type, @seniority_level,
            GETDATE(), GETDATE());
    
    SELECT SCOPE_IDENTITY() AS employee_id;
END;
Go
CREATE PROCEDURE [Admin].[sp_UpdateEmployee]
    @employee_id INT,
    @full_name NVARCHAR(100) = NULL,
    @national_id NVARCHAR(20) = NULL,
    @gender NVARCHAR(10) = NULL,
    @birth_date DATE = NULL,
    @phone_number NVARCHAR(20) = NULL,
    @email NVARCHAR(100) = NULL,
    @emp_address NVARCHAR(255) = NULL,
    @department_id INT = NULL,
    @emp_status NVARCHAR(20) = NULL,
    @employee_type NVARCHAR(50) = NULL,
    @seniority_level NVARCHAR(50) = NULL
AS
BEGIN
    UPDATE [Admin].[Employees]
    SET 
        full_name = ISNULL(@full_name, full_name),
        national_id = ISNULL(@national_id, national_id),
        gender = ISNULL(@gender, gender),
        birth_date = ISNULL(@birth_date, birth_date),
        phone_number = ISNULL(@phone_number, phone_number),
        email = ISNULL(@email, email),
        emp_address = ISNULL(@emp_address, emp_address),
        department_id = ISNULL(@department_id, department_id),
        emp_status = ISNULL(@emp_status, emp_status),
        employee_type = ISNULL(@employee_type, employee_type),
        seniority_level = ISNULL(@seniority_level, seniority_level),
        updated_at = GETDATE()
    WHERE employee_id = @employee_id;
END;
Go
CREATE PROCEDURE [Admin].[sp_GetEmployeeById]
    @employee_id INT
AS
BEGIN
    SELECT * FROM [Admin].[Employees] WHERE employee_id = @employee_id;
END;
Go
CREATE TRIGGER [Admin].[tr_Employees_Audit]
ON [Admin].[Employees]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        NULL, -- System action
        @action,
        'Employees',
        ISNULL((SELECT employee_id FROM inserted), (SELECT employee_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'New employee created: ' + (SELECT full_name FROM inserted)
            WHEN @action = 'UPDATE' THEN 'Employee updated. ID: ' + CAST((SELECT employee_id FROM inserted) AS VARCHAR) + 
                                        ', Name: ' + (SELECT full_name FROM inserted)
            ELSE 'Employee deleted. ID: ' + CAST((SELECT employee_id FROM deleted) AS VARCHAR) + 
                 ', Name: ' + (SELECT full_name FROM deleted)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;
Go
CREATE TRIGGER [Admin].[tr_Employees_CreateUser]
ON [Admin].[Employees]
AFTER INSERT
AS
BEGIN
    DECLARE @employee_id INT;
    DECLARE @username VARCHAR(50);
    DECLARE @default_password VARCHAR(255) = 'TempPassword123!'; -- Should be hashed in production
    
    SELECT @employee_id = employee_id, 
           @username = LOWER(REPLACE(full_name, ' ', '.')) + CAST(employee_id AS VARCHAR)
    FROM inserted;
    
    -- Assign default role (e.g., 3 for employee)
    EXEC [Admin].[sp_InsertUser] @username, @default_password, @employee_id, 3, NULL;
END;
GO
                              --Leave_Requests Table
CREATE PROCEDURE [Admin].[sp_CreateLeaveRequest]
    @employee_id INT,
    @leave_type NVARCHAR(50),
    @start_date DATE,
    @end_date DATE,
    @reason NVARCHAR(255)
AS
BEGIN
    INSERT INTO [Admin].[Leave_Requests] (employee_id, leave_type, start_date, end_date, reason, status, requested_at)
    VALUES (@employee_id, @leave_type, @start_date, @end_date, @reason, 'Pending', GETDATE());
    
    SELECT SCOPE_IDENTITY() AS leave_id;
END;
Go
CREATE PROCEDURE [Admin].[sp_UpdateLeaveStatus]
    @leave_id INT,
    @status NVARCHAR(20),
    @updated_by INT
AS
BEGIN
    UPDATE [Admin].[Leave_Requests]
    SET status = @status
    WHERE leave_id = @leave_id;
    
    -- Create notification for employee
    DECLARE @employee_id INT;
    DECLARE @message NVARCHAR(255);
    
    SELECT @employee_id = employee_id FROM [Admin].[Leave_Requests] WHERE leave_id = @leave_id;
    
    SET @message = 'Your leave request (ID: ' + CAST(@leave_id AS NVARCHAR) + ') status has been updated to: ' + @status;
    
    EXEC [Scheduling].[sp_CreateNotification] @employee_id, @message;
END;
Go
CREATE PROCEDURE [Admin].[sp_GetEmployeeLeaveRequests]
    @employee_id INT,
    @status NVARCHAR(20) = NULL
AS
BEGIN
    SELECT * FROM [Admin].[Leave_Requests]
    WHERE employee_id = @employee_id
    AND (@status IS NULL OR status = @status)
    ORDER BY requested_at DESC;
END;
GO
CREATE TRIGGER [Admin].[tr_LeaveRequests_Audit]
ON [Admin].[Leave_Requests]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        (SELECT employee_id FROM inserted),
        @action,
        'Leave_Requests',
        ISNULL((SELECT leave_id FROM inserted), (SELECT leave_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'Leave request created by employee: ' + CAST((SELECT employee_id FROM inserted) AS VARCHAR)
            WHEN @action = 'UPDATE' THEN 'Leave request updated. ID: ' + CAST((SELECT leave_id FROM inserted) AS VARCHAR) + 
                                        ', Status: ' + (SELECT status FROM inserted)
            ELSE 'Leave request deleted. ID: ' + CAST((SELECT leave_id FROM deleted) AS VARCHAR)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;
Go

                      --Shifts Table
CREATE PROCEDURE [Admin].[sp_CreateShift]
    @employee_id INT,
    @shift_day VARCHAR(10),
    @start_time TIME(7),
    @end_time TIME(7),
    @location NVARCHAR(100)
AS
BEGIN
    -- Check for overlapping shifts
    IF EXISTS (
        SELECT 1 FROM [Admin].[Shifts] 
        WHERE employee_id = @employee_id 
        AND shift_day = @shift_day
        AND (
            (@start_time BETWEEN start_time AND end_time) OR
            (@end_time BETWEEN start_time AND end_time) OR
            (start_time BETWEEN @start_time AND @end_time) OR
            (end_time BETWEEN @start_time AND @end_time)
        )
    )
    BEGIN
        RAISERROR('Employee already has a shift scheduled during this time', 16, 1);
        RETURN;
    END
    
    INSERT INTO [Admin].[Shifts] (employee_id, shift_day, start_time, end_time, location, created_at, updated_at)
    VALUES (@employee_id, @shift_day, @start_time, @end_time, @location, GETDATE(), GETDATE());
END;
Go
CREATE PROCEDURE [Admin].[sp_UpdateShift]
    @shift_id INT,
    @shift_day VARCHAR(10) = NULL,
    @start_time TIME(7) = NULL,
    @end_time TIME(7) = NULL,
    @location NVARCHAR(100) = NULL
AS
BEGIN
    UPDATE [Admin].[Shifts]
    SET 
        shift_day = ISNULL(@shift_day, shift_day),
        start_time = ISNULL(@start_time, start_time),
        end_time = ISNULL(@end_time, end_time),
        location = ISNULL(@location, location),
        updated_at = GETDATE()
    WHERE shift_id = @shift_id;
END;
Go
CREATE PROCEDURE [Admin].[sp_GetEmployeeShifts]
    @employee_id INT,
    @start_date DATE = NULL,
    @end_date DATE = NULL
AS
BEGIN
    SELECT * FROM [Admin].[Shifts]
    WHERE employee_id = @employee_id
    AND (@start_date IS NULL OR shift_day >= @start_date)
    AND (@end_date IS NULL OR shift_day <= @end_date)
    ORDER BY shift_day, start_time;
END;
Go
CREATE TRIGGER [Admin].[tr_Shifts_Audit]
ON [Admin].[Shifts]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        (SELECT employee_id FROM inserted),
        @action,
        'Shifts',
        ISNULL((SELECT shift_id FROM inserted), (SELECT shift_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'Shift created for employee: ' + CAST((SELECT employee_id FROM inserted) AS VARCHAR)
            WHEN @action = 'UPDATE' THEN 'Shift updated. ID: ' + CAST((SELECT shift_id FROM inserted) AS VARCHAR)
            ELSE 'Shift deleted. ID: ' + CAST((SELECT shift_id FROM deleted) AS VARCHAR)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;
GO
                             --Departments Table
CREATE PROCEDURE [Admin].[sp_CreateDepartment]
    @department_name NVARCHAR(100),
    @description NVARCHAR(255),
    @manager_id INT = NULL,
    @phone_number NVARCHAR(20) = NULL,
    @location NVARCHAR(100) = NULL
AS
BEGIN
    INSERT INTO [Admin].[Departments] (department_name, description, manager_id, phone_number, location, created_at, updated_at)
    VALUES (@department_name, @description, @manager_id, @phone_number, @location, GETDATE(), GETDATE());
    
    SELECT SCOPE_IDENTITY() AS department_id;
END;
Go
CREATE PROCEDURE [Admin].[sp_UpdateDepartment]
    @department_id INT,
    @department_name NVARCHAR(100) = NULL,
    @description NVARCHAR(255) = NULL,
    @manager_id INT = NULL,
    @phone_number NVARCHAR(20) = NULL,
    @location NVARCHAR(100) = NULL
AS
BEGIN
    UPDATE [Admin].[Departments]
    SET 
        department_name = ISNULL(@department_name, department_name),
        description = ISNULL(@description, description),
        manager_id = ISNULL(@manager_id, manager_id),
        phone_number = ISNULL(@phone_number, phone_number),
        location = ISNULL(@location, location),
        updated_at = GETDATE()
    WHERE department_id = @department_id;
END;
Go
CREATE PROCEDURE [Admin].[sp_GetAllDepartments]
AS
BEGIN
    SELECT d.*, e.full_name AS manager_name
    FROM [Admin].[Departments] d
    LEFT JOIN [Admin].[Employees] e ON d.manager_id = e.employee_id;
END;
Go
CREATE TRIGGER [Admin].[tr_Departments_Audit]
ON [Admin].[Departments]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action VARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT';
    ELSE
        SET @action = 'DELETE';
    
    INSERT INTO [Admin].[AuditLogs] (user_id, action, entity_type, entity_id, timestamp, details)
    SELECT 
        NULL, -- System action
        @action,
        'Departments',
        ISNULL((SELECT department_id FROM inserted), (SELECT department_id FROM deleted)),
        GETDATE(),
        CASE 
            WHEN @action = 'INSERT' THEN 'Department created: ' + (SELECT department_name FROM inserted)
            WHEN @action = 'UPDATE' THEN 'Department updated. ID: ' + CAST((SELECT department_id FROM inserted) AS VARCHAR) + 
                                        ', Name: ' + (SELECT department_name FROM inserted)
            ELSE 'Department deleted. ID: ' + CAST((SELECT department_id FROM deleted) AS VARCHAR) + 
                 ', Name: ' + (SELECT department_name FROM deleted)
        END
    FROM inserted FULL OUTER JOIN deleted ON 1=1;
END;



