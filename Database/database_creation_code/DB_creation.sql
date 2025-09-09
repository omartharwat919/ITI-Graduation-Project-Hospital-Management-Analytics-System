
GO
/****** Object:  Schema [Admin]    ******/
CREATE SCHEMA [Admin]
GO
/****** Object:  Schema [Billing]     ******/
CREATE SCHEMA [Billing]
GO
/****** Object:  Schema [Clinical]     ******/
CREATE SCHEMA [Clinical]
GO
/****** Object:  Schema [Logistics]     ******/
CREATE SCHEMA [Logistics]
GO
/****** Object:  Schema [Patient]     ******/
CREATE SCHEMA [Patient]
GO
/****** Object:  Schema [Scheduling]     ******/
CREATE SCHEMA [Scheduling]
GO
/****** Object:  Schema [Staff]     ******/
CREATE SCHEMA [Staff]
GO
/****** Object:  Schema [Visit]     ******/
CREATE SCHEMA [Visit]
GO
/****** Object:  Table [Admin].[AuditLogs]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[AuditLogs](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[action] [varchar](20) NULL,
	[entity_type] [varchar](50) NULL,
	[entity_id] [int] NULL,
	[timestamp] [datetime] NULL,
	[details] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Admin].[Departments]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[Departments](
	[department_id] [int] IDENTITY(1,1) NOT NULL,
	[department_name] [nvarchar](100) NULL,
	[description] [nvarchar](255) NULL,
	[manager_id] [int] NULL,
	[phone_number] [nvarchar](20) NULL,
	[location] [nvarchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[department_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Admin].[Employees]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[Employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[national_id] [nvarchar](20) NOT NULL,
	[gender] [nvarchar](10) NULL,
	[birth_date] [date] NULL,
	[phone_number] [nvarchar](20) NULL,
	[email] [nvarchar](100) NULL,
	[emp_address] [nvarchar](255) NULL,
	[hire_date] [date] NOT NULL,
	[department_id] [int] NULL,
	[emp_status] [nvarchar](20) NULL,
	[employee_type] [nvarchar](50) NULL,
	[seniority_level] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[national_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Admin].[Leave_Requests]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[Leave_Requests](
	[leave_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NULL,
	[leave_type] [nvarchar](50) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[reason] [nvarchar](255) NULL,
	[status] [nvarchar](20) NULL,
	[requested_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[leave_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Admin].[Permissions]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[Permissions](
	[permission_id] [int] NOT NULL,
	[permission_code] [varchar](100) NULL,
	[permission_description] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Admin].[RolePermissions]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[RolePermissions](
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Admin].[Roles]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[Roles](
	[role_id] [int] NOT NULL,
	[role_code] [varchar](50) NULL,
	[role_name_en] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Admin].[Shifts]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[Shifts](
	[shift_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NULL,
	[shift_day] [varchar](10) NULL,
	[start_time] [time](7) NULL,
	[end_time] [time](7) NULL,
	[location] [nvarchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[shift_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Admin].[Users]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admin].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password_hash] [varchar](255) NOT NULL,
	[created_at] [datetime] NULL,
	[last_login] [datetime] NULL,
	[employee_id] [int] NULL,
	[role_id] [int] NULL,
	[patient_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Billing].[Bill_Items]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Billing].[Bill_Items](
	[bill_item_id] [int] NOT NULL,
	[bill_id] [int] NULL,
	[service_id] [int] NOT NULL,
	[amount] [decimal](10, 2) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[bill_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Billing].[Bills]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Billing].[Bills](
	[bill_id] [int] NOT NULL,
	[patient_id] [int] NULL,
	[visit_id] [int] NULL,
	[total_amount] [decimal](10, 2) NULL,
	[patient_insurance_id] [int] NULL,
	[created_by] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[bill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Billing].[Expense_Categories]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Billing].[Expense_Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[category_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Billing].[Expenses]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Billing].[Expenses](
	[expense_id] [int] IDENTITY(1,1) NOT NULL,
	[category_id] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[description] [nvarchar](255) NULL,
	[expense_date] [date] NOT NULL,
	[recorded_by] [int] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[expense_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Billing].[Insurance]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Billing].[Insurance](
	[insurance_id] [int] NOT NULL,
	[company_name] [nvarchar](100) NULL,
	[policy_number] [nvarchar](50) NULL,
	[coverage_type] [nvarchar](50) NULL,
	[contact_info] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[insurance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Billing].[Payment_Methods]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Billing].[Payment_Methods](
	[method_id] [int] NOT NULL,
	[method_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[method_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Billing].[Payments]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Billing].[Payments](
	[payment_id] [int] NOT NULL,
	[bill_id] [int] NULL,
	[method_id] [int] NULL,
	[amount] [decimal](10, 2) NULL,
	[payment_date] [datetime] NULL,
	[received_by] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Billing].[Services]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Billing].[Services](
	[service_id] [int] IDENTITY(1,1) NOT NULL,
	[service_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
	[standard_price] [decimal](10, 2) NOT NULL,
	[service_category] [nvarchar](50) NULL,
	[department_id] [int] NULL,
	[is_active] [bit] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clinical].[Lab_Tests]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clinical].[Lab_Tests](
	[lab_test_id] [int] NOT NULL,
	[test_name] [nvarchar](100) NULL,
	[description] [nvarchar](255) NULL,
	[department_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[lab_test_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clinical].[Radiology_Reports]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clinical].[Radiology_Reports](
	[report_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NULL,
	[radiology_type_id] [int] NULL,
	[image_url] [nvarchar](255) NULL,
	[report_text] [nvarchar](255) NULL,
	[report_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clinical].[Radiology_Types]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clinical].[Radiology_Types](
	[radiology_type_id] [int] NOT NULL,
	[type_name] [nvarchar](100) NULL,
	[description] [nvarchar](255) NULL,
	[department_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[radiology_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clinical].[Test_Result_Details]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clinical].[Test_Result_Details](
	[detail_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NULL,
	[lab_test_id] [int] NULL,
	[attribute_name] [nvarchar](100) NULL,
	[attribute_value] [nvarchar](100) NULL,
	[normal_range] [nvarchar](50) NULL,
	[result_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Logistics].[Ambulance_Requests]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logistics].[Ambulance_Requests](
	[request_id] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NULL,
	[ambulance_id] [int] NULL,
	[request_time] [datetime] NULL,
	[status] [nvarchar](20) NULL,
	[destination] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Logistics].[Ambulances]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logistics].[Ambulances](
	[ambulance_id] [int] IDENTITY(1,1) NOT NULL,
	[vehicle_number] [nvarchar](50) NULL,
	[model] [nvarchar](50) NULL,
	[driver_id] [int] NULL,
	[is_available] [bit] NULL,
	[notes] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ambulance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Logistics].[Beds]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logistics].[Beds](
	[bed_id] [int] IDENTITY(1,1) NOT NULL,
	[room_id] [int] NULL,
	[bed_number] [nvarchar](10) NULL,
	[status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[bed_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Logistics].[Nurse_Room_Assignments]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logistics].[Nurse_Room_Assignments](
	[assignment_id] [int] IDENTITY(1,1) NOT NULL,
	[nurse_id] [int] NULL,
	[room_id] [int] NULL,
	[assigned_at] [datetime] NULL,
	[shift_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[assignment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Logistics].[Rooms]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logistics].[Rooms](
	[room_id] [int] IDENTITY(1,1) NOT NULL,
	[room_number] [nvarchar](20) NULL,
	[floor] [int] NULL,
	[capacity] [int] NULL,
	[room_type] [nvarchar](50) NULL,
	[department_id] [int] NULL,
	[status] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[room_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Patient].[Allergies]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Patient].[Allergies](
	[allergy_id] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NULL,
	[allergy_name] [nvarchar](100) NULL,
	[severity] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[allergy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Patient].[Chronic_Conditions]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Patient].[Chronic_Conditions](
	[condition_id] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NULL,
	[condition_name] [nvarchar](100) NULL,
	[diagnosis_date] [date] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[condition_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Patient].[Patient_Insurance]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Patient].[Patient_Insurance](
	[patient_insurance_id] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NULL,
	[insurance_id] [int] NULL,
	[is_active] [bit] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[patient_insurance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Patient].[Patients]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Patient].[Patients](
	[patient_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](100) NULL,
	[last_name] [nvarchar](100) NULL,
	[date_of_birth] [date] NULL,
	[gender] [nvarchar](10) NULL,
	[phone_number] [nvarchar](20) NULL,
	[email] [nvarchar](100) NULL,
	[address] [nvarchar](255) NULL,
	[emergency_contact_name] [nvarchar](100) NULL,
	[emergency_contact_phone] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[patient_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Scheduling].[Appointments]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Scheduling].[Appointments](
	[appointment_id] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NULL,
	[doctor_id] [int] NULL,
	[appointment_time] [datetime] NULL,
	[status] [varchar](50) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[appointment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Scheduling].[Notifications]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Scheduling].[Notifications](
	[notification_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[message] [nvarchar](max) NULL,
	[is_read] [bit] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Staff].[Doctors]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staff].[Doctors](
	[doctor_id] [int] NOT NULL,
	[employee_id] [int] NULL,
	[license_number] [nvarchar](100) NULL,
	[years_of_experience] [int] NULL,
	[education] [nvarchar](255) NULL,
	[specialization_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[doctor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Staff].[Nurses]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staff].[Nurses](
	[nurse_id] [int] NOT NULL,
	[employee_id] [int] NULL,
	[license_number] [nvarchar](100) NULL,
	[experience_years] [int] NULL,
	[specialization] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[nurse_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Staff].[Specializations]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staff].[Specializations](
	[specialization_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[specialization_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Visit].[Diagnoses]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Visit].[Diagnoses](
	[diagnosis_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NULL,
	[doctor_id] [int] NULL,
	[diagnosis_text] [nvarchar](max) NULL,
	[diagnosis_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[diagnosis_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Visit].[Medical_Records]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Visit].[Medical_Records](
	[record_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NOT NULL,
	[diagnosis_summary] [nvarchar](max) NULL,
	[test_summary] [nvarchar](max) NULL,
	[radiology_summary] [nvarchar](max) NULL,
	[chronic_conditions] [nvarchar](max) NULL,
	[allergies] [nvarchar](max) NULL,
	[general_health_status] [nvarchar](50) NULL,
	[treatment_plan] [nvarchar](max) NULL,
	[doctor_notes] [nvarchar](max) NULL,
	[follow_up_required] [bit] NULL,
	[lifestyle_notes] [nvarchar](max) NULL,
	[created_by] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[record_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[visit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Visit].[PrescriptionItems]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Visit].[PrescriptionItems](
	[item_id] [int] IDENTITY(1,1) NOT NULL,
	[prescription_id] [int] NULL,
	[medicine_name] [nvarchar](100) NULL,
	[dosage] [nvarchar](100) NULL,
	[duration] [nvarchar](100) NULL,
	[instructions] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Visit].[Prescriptions]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Visit].[Prescriptions](
	[prescription_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NULL,
	[doctor_id] [int] NULL,
	[issue_date] [datetime] NULL,
	[notes] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[prescription_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Visit].[Visit_Rooms]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Visit].[Visit_Rooms](
	[visit_room_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NULL,
	[room_id] [int] NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[visit_room_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Visit].[Visit_Vitals]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Visit].[Visit_Vitals](
	[vital_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NOT NULL,
	[blood_type] [nvarchar](3) NULL,
	[body_temperature] [decimal](4, 1) NULL,
	[blood_pressure_systolic] [int] NULL,
	[blood_pressure_diastolic] [int] NULL,
	[heart_rate] [int] NULL,
	[respiratory_rate] [int] NULL,
	[blood_oxygen_level] [int] NULL,
	[recorded_by] [int] NULL,
	[recorded_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[vital_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[visit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Visit].[Visits]    Script Date: 7/19/2025 2:48:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Visit].[Visits](
	[visit_id] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[visit_date] [date] NULL,
	[visit_type] [nvarchar](50) NULL,
	[reason] [nvarchar](255) NULL,
	[status] [nvarchar](20) NULL,
	[discharge_date] [date] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK__Visits__375A75E16D8C7714] PRIMARY KEY CLUSTERED 
(
	[visit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Admin].[Employees] ADD  DEFAULT ('Active') FOR [emp_status]
GO
ALTER TABLE [Admin].[Employees] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [Admin].[Employees] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [Billing].[Bills] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [Billing].[Expenses] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [Billing].[Expenses] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [Billing].[Services] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Billing].[Services] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [Patient].[Patient_Insurance] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Visit].[Medical_Records] ADD  DEFAULT ((0)) FOR [follow_up_required]
GO
ALTER TABLE [Visit].[Medical_Records] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [Visit].[Medical_Records] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [Visit].[Visit_Vitals] ADD  DEFAULT (getdate()) FOR [recorded_at]
GO
ALTER TABLE [Visit].[Visits] ADD  CONSTRAINT [DF__Visits__status__0E6E26BF]  DEFAULT ('Ongoing') FOR [status]
GO
ALTER TABLE [Visit].[Visits] ADD  CONSTRAINT [DF__Visits__created___0F624AF8]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [Visit].[Visits] ADD  CONSTRAINT [DF__Visits__updated___10566F31]  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [Admin].[AuditLogs]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [Admin].[Users] ([user_id])
GO
ALTER TABLE [Admin].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_Departments_Employees] FOREIGN KEY([manager_id])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Admin].[Departments] CHECK CONSTRAINT [FK_Departments_Employees]
GO
ALTER TABLE [Admin].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Departments] FOREIGN KEY([department_id])
REFERENCES [Admin].[Departments] ([department_id])
GO
ALTER TABLE [Admin].[Employees] CHECK CONSTRAINT [FK_Employees_Departments]
GO
ALTER TABLE [Admin].[Leave_Requests]  WITH CHECK ADD  CONSTRAINT [FK_LeaveRequests_EmployeeID] FOREIGN KEY([employee_id])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Admin].[Leave_Requests] CHECK CONSTRAINT [FK_LeaveRequests_EmployeeID]
GO
ALTER TABLE [Admin].[RolePermissions]  WITH CHECK ADD FOREIGN KEY([permission_id])
REFERENCES [Admin].[Permissions] ([permission_id])
GO
ALTER TABLE [Admin].[RolePermissions]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [Admin].[Roles] ([role_id])
GO
ALTER TABLE [Admin].[Shifts]  WITH CHECK ADD  CONSTRAINT [FK_Shifts_EmployeeID] FOREIGN KEY([employee_id])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Admin].[Shifts] CHECK CONSTRAINT [FK_Shifts_EmployeeID]
GO
ALTER TABLE [Admin].[Users]  WITH CHECK ADD FOREIGN KEY([patient_id])
REFERENCES [Patient].[Patients] ([patient_id])
GO
ALTER TABLE [Admin].[Users]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [Admin].[Roles] ([role_id])
GO
ALTER TABLE [Admin].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_EmployeeID] FOREIGN KEY([employee_id])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Admin].[Users] CHECK CONSTRAINT [FK_Users_EmployeeID]
GO
ALTER TABLE [Billing].[Bill_Items]  WITH CHECK ADD FOREIGN KEY([bill_id])
REFERENCES [Billing].[Bills] ([bill_id])
GO
ALTER TABLE [Billing].[Bill_Items]  WITH CHECK ADD FOREIGN KEY([service_id])
REFERENCES [Billing].[Services] ([service_id])
GO
ALTER TABLE [Billing].[Bills]  WITH CHECK ADD FOREIGN KEY([patient_id])
REFERENCES [Patient].[Patients] ([patient_id])
GO
ALTER TABLE [Billing].[Bills]  WITH CHECK ADD FOREIGN KEY([patient_insurance_id])
REFERENCES [Patient].[Patient_Insurance] ([patient_insurance_id])
GO
ALTER TABLE [Billing].[Bills]  WITH CHECK ADD  CONSTRAINT [FK_Bills_CreatedBy] FOREIGN KEY([created_by])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Billing].[Bills] CHECK CONSTRAINT [FK_Bills_CreatedBy]
GO
ALTER TABLE [Billing].[Bills]  WITH CHECK ADD  CONSTRAINT [FK_Bills_Visits] FOREIGN KEY([visit_id])
REFERENCES [Visit].[Visits] ([visit_id])
GO
ALTER TABLE [Billing].[Bills] CHECK CONSTRAINT [FK_Bills_Visits]
GO
ALTER TABLE [Billing].[Expenses]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [Billing].[Expense_Categories] ([category_id])
GO
ALTER TABLE [Billing].[Expenses]  WITH CHECK ADD  CONSTRAINT [FK_Expenses_RecordedBy] FOREIGN KEY([recorded_by])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Billing].[Expenses] CHECK CONSTRAINT [FK_Expenses_RecordedBy]
GO
ALTER TABLE [Billing].[Payments]  WITH CHECK ADD FOREIGN KEY([bill_id])
REFERENCES [Billing].[Bills] ([bill_id])
GO
ALTER TABLE [Billing].[Payments]  WITH CHECK ADD FOREIGN KEY([method_id])
REFERENCES [Billing].[Payment_Methods] ([method_id])
GO
ALTER TABLE [Billing].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_ReceivedBy] FOREIGN KEY([received_by])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Billing].[Payments] CHECK CONSTRAINT [FK_Payments_ReceivedBy]
GO
ALTER TABLE [Billing].[Services]  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [Admin].[Departments] ([department_id])
GO
ALTER TABLE [Clinical].[Lab_Tests]  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [Admin].[Departments] ([department_id])
GO
ALTER TABLE [Clinical].[Radiology_Reports]  WITH CHECK ADD FOREIGN KEY([radiology_type_id])
REFERENCES [Clinical].[Radiology_Types] ([radiology_type_id])
GO
ALTER TABLE [Clinical].[Radiology_Reports]  WITH CHECK ADD  CONSTRAINT [FK__Radiology__visit__151B244E] FOREIGN KEY([visit_id])
REFERENCES [Visit].[Visits] ([visit_id])
GO
ALTER TABLE [Clinical].[Radiology_Reports] CHECK CONSTRAINT [FK__Radiology__visit__151B244E]
GO
ALTER TABLE [Clinical].[Radiology_Types]  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [Admin].[Departments] ([department_id])
GO
ALTER TABLE [Clinical].[Test_Result_Details]  WITH CHECK ADD FOREIGN KEY([lab_test_id])
REFERENCES [Clinical].[Lab_Tests] ([lab_test_id])
GO
ALTER TABLE [Clinical].[Test_Result_Details]  WITH CHECK ADD  CONSTRAINT [FK__Test_Resu__visit__18EBB532] FOREIGN KEY([visit_id])
REFERENCES [Visit].[Visits] ([visit_id])
GO
ALTER TABLE [Clinical].[Test_Result_Details] CHECK CONSTRAINT [FK__Test_Resu__visit__18EBB532]
GO
ALTER TABLE [Logistics].[Ambulance_Requests]  WITH CHECK ADD FOREIGN KEY([ambulance_id])
REFERENCES [Logistics].[Ambulances] ([ambulance_id])
GO
ALTER TABLE [Logistics].[Ambulance_Requests]  WITH CHECK ADD FOREIGN KEY([patient_id])
REFERENCES [Patient].[Patients] ([patient_id])
GO
ALTER TABLE [Logistics].[Ambulances]  WITH CHECK ADD  CONSTRAINT [FK_Ambulances_DriverID] FOREIGN KEY([driver_id])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Logistics].[Ambulances] CHECK CONSTRAINT [FK_Ambulances_DriverID]
GO
ALTER TABLE [Logistics].[Beds]  WITH CHECK ADD FOREIGN KEY([room_id])
REFERENCES [Logistics].[Rooms] ([room_id])
GO
ALTER TABLE [Logistics].[Nurse_Room_Assignments]  WITH CHECK ADD FOREIGN KEY([nurse_id])
REFERENCES [Staff].[Nurses] ([nurse_id])
GO
ALTER TABLE [Logistics].[Nurse_Room_Assignments]  WITH CHECK ADD FOREIGN KEY([room_id])
REFERENCES [Logistics].[Rooms] ([room_id])
GO
ALTER TABLE [Logistics].[Nurse_Room_Assignments]  WITH CHECK ADD FOREIGN KEY([shift_id])
REFERENCES [Admin].[Shifts] ([shift_id])
GO
ALTER TABLE [Logistics].[Rooms]  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [Admin].[Departments] ([department_id])
GO
ALTER TABLE [Patient].[Allergies]  WITH CHECK ADD FOREIGN KEY([patient_id])
REFERENCES [Patient].[Patients] ([patient_id])
GO
ALTER TABLE [Patient].[Chronic_Conditions]  WITH CHECK ADD FOREIGN KEY([patient_id])
REFERENCES [Patient].[Patients] ([patient_id])
GO
ALTER TABLE [Patient].[Patient_Insurance]  WITH CHECK ADD FOREIGN KEY([insurance_id])
REFERENCES [Billing].[Insurance] ([insurance_id])
GO
ALTER TABLE [Patient].[Patient_Insurance]  WITH CHECK ADD FOREIGN KEY([patient_id])
REFERENCES [Patient].[Patients] ([patient_id])
GO
ALTER TABLE [Scheduling].[Appointments]  WITH CHECK ADD FOREIGN KEY([doctor_id])
REFERENCES [Staff].[Doctors] ([doctor_id])
GO
ALTER TABLE [Scheduling].[Appointments]  WITH CHECK ADD FOREIGN KEY([patient_id])
REFERENCES [Patient].[Patients] ([patient_id])
GO
ALTER TABLE [Scheduling].[Notifications]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [Admin].[Users] ([user_id])
GO
ALTER TABLE [Staff].[Doctors]  WITH CHECK ADD FOREIGN KEY([specialization_id])
REFERENCES [Staff].[Specializations] ([specialization_id])
GO
ALTER TABLE [Staff].[Doctors]  WITH CHECK ADD  CONSTRAINT [FK_Doctors_EmployeeID] FOREIGN KEY([employee_id])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Staff].[Doctors] CHECK CONSTRAINT [FK_Doctors_EmployeeID]
GO
ALTER TABLE [Visit].[Diagnoses]  WITH CHECK ADD FOREIGN KEY([doctor_id])
REFERENCES [Staff].[Doctors] ([doctor_id])
GO
ALTER TABLE [Visit].[Diagnoses]  WITH CHECK ADD  CONSTRAINT [FK__Diagnoses__visit__3D2915A8] FOREIGN KEY([visit_id])
REFERENCES [Visit].[Visits] ([visit_id])
GO
ALTER TABLE [Visit].[Diagnoses] CHECK CONSTRAINT [FK__Diagnoses__visit__3D2915A8]
GO
ALTER TABLE [Visit].[Medical_Records]  WITH CHECK ADD  CONSTRAINT [FK__Medical_R__visit__57DD0BE4] FOREIGN KEY([visit_id])
REFERENCES [Visit].[Visits] ([visit_id])
GO
ALTER TABLE [Visit].[Medical_Records] CHECK CONSTRAINT [FK__Medical_R__visit__57DD0BE4]
GO
ALTER TABLE [Visit].[Medical_Records]  WITH CHECK ADD  CONSTRAINT [FK_MedicalRecords_CreatedBy] FOREIGN KEY([created_by])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Visit].[Medical_Records] CHECK CONSTRAINT [FK_MedicalRecords_CreatedBy]
GO
ALTER TABLE [Visit].[PrescriptionItems]  WITH CHECK ADD FOREIGN KEY([prescription_id])
REFERENCES [Visit].[Prescriptions] ([prescription_id])
GO
ALTER TABLE [Visit].[Prescriptions]  WITH CHECK ADD FOREIGN KEY([doctor_id])
REFERENCES [Staff].[Doctors] ([doctor_id])
GO
ALTER TABLE [Visit].[Prescriptions]  WITH CHECK ADD  CONSTRAINT [FK__Prescript__visit__40F9A68C] FOREIGN KEY([visit_id])
REFERENCES [Visit].[Visits] ([visit_id])
GO
ALTER TABLE [Visit].[Prescriptions] CHECK CONSTRAINT [FK__Prescript__visit__40F9A68C]
GO
ALTER TABLE [Visit].[Visit_Rooms]  WITH CHECK ADD FOREIGN KEY([room_id])
REFERENCES [Logistics].[Rooms] ([room_id])
GO
ALTER TABLE [Visit].[Visit_Rooms]  WITH CHECK ADD  CONSTRAINT [FK__Visit_Roo__visit__4A8310C6] FOREIGN KEY([visit_id])
REFERENCES [Visit].[Visits] ([visit_id])
GO
ALTER TABLE [Visit].[Visit_Rooms] CHECK CONSTRAINT [FK__Visit_Roo__visit__4A8310C6]
GO
ALTER TABLE [Visit].[Visit_Vitals]  WITH CHECK ADD  CONSTRAINT [FK__Visit_Vit__visit__5F7E2DAC] FOREIGN KEY([visit_id])
REFERENCES [Visit].[Visits] ([visit_id])
GO
ALTER TABLE [Visit].[Visit_Vitals] CHECK CONSTRAINT [FK__Visit_Vit__visit__5F7E2DAC]
GO
ALTER TABLE [Visit].[Visit_Vitals]  WITH CHECK ADD  CONSTRAINT [FK_VisitVitals_RecordedBy] FOREIGN KEY([recorded_by])
REFERENCES [Admin].[Employees] ([employee_id])
GO
ALTER TABLE [Visit].[Visit_Vitals] CHECK CONSTRAINT [FK_VisitVitals_RecordedBy]
GO
ALTER TABLE [Visit].[Visits]  WITH CHECK ADD  CONSTRAINT [FK__Visits__departme__123EB7A3] FOREIGN KEY([department_id])
REFERENCES [Admin].[Departments] ([department_id])
GO
ALTER TABLE [Visit].[Visits] CHECK CONSTRAINT [FK__Visits__departme__123EB7A3]
GO
ALTER TABLE [Visit].[Visits]  WITH CHECK ADD  CONSTRAINT [FK__Visits__patient___114A936A] FOREIGN KEY([patient_id])
REFERENCES [Patient].[Patients] ([patient_id])
GO
ALTER TABLE [Visit].[Visits] CHECK CONSTRAINT [FK__Visits__patient___114A936A]
GO
ALTER TABLE [Admin].[Employees]  WITH CHECK ADD CHECK  (([gender]='Female' OR [gender]='Male'))
GO
ALTER TABLE [Admin].[Employees]  WITH CHECK ADD  CONSTRAINT [CK_Employees_EmployeeType] CHECK  (([employee_type]='Paramedic' OR [employee_type]='Technician' OR [employee_type]='Security' OR [employee_type]='Receptionist' OR [employee_type]='Physiotherapist' OR [employee_type]='Pharmacist' OR [employee_type]='Nurse' OR [employee_type]='Manager' OR [employee_type]='Lab Technician' OR [employee_type]='IT Specialist' OR [employee_type]='Doctor' OR [employee_type]='Cleaning Staff' OR [employee_type]='Anesthetist' OR [employee_type]='Admin Staff' OR [employee_type]='Accountant'))
GO
ALTER TABLE [Admin].[Employees] CHECK CONSTRAINT [CK_Employees_EmployeeType]
GO
ALTER TABLE [Admin].[Employees]  WITH CHECK ADD  CONSTRAINT [CK_Employees_SeniorityLevel] CHECK  (([seniority_level]='Manager' OR [seniority_level]='Consultant' OR [seniority_level]='Senior' OR [seniority_level]='Mid' OR [seniority_level]='Junior'))
GO
ALTER TABLE [Admin].[Employees] CHECK CONSTRAINT [CK_Employees_SeniorityLevel]
GO
ALTER TABLE [Visit].[Medical_Records]  WITH CHECK ADD CHECK  (([general_health_status]='Critical' OR [general_health_status]='Fair' OR [general_health_status]='Good'))
GO
ALTER TABLE [Visit].[Visit_Vitals]  WITH CHECK ADD CHECK  (([blood_type]='O-' OR [blood_type]='O+' OR [blood_type]='AB-' OR [blood_type]='AB+' OR [blood_type]='B-' OR [blood_type]='B+' OR [blood_type]='A-' OR [blood_type]='A+'))
GO
ALTER TABLE [Visit].[Visits]  WITH CHECK ADD  CONSTRAINT [CK__Visits__visit_ty__0D7A0286] CHECK  (([visit_type]='Surgery' OR [visit_type]='check_up' OR [visit_type]='Follow_up' OR [visit_type]='Referral' OR [visit_type]='Emergency' OR [visit_type]='Inpatient' OR [visit_type]='Outpatient'))
GO
ALTER TABLE [Visit].[Visits] CHECK CONSTRAINT [CK__Visits__visit_ty__0D7A0286]
GO
