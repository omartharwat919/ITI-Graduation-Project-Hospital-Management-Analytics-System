

/****** Object:  Database [DWH] ******/
CREATE DATABASE [DWH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'oo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\oo.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'oo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\oo_log.ldf' , SIZE = 598016KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DWH] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DWH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DWH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DWH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DWH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DWH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DWH] SET ARITHABORT OFF 
GO
ALTER DATABASE [DWH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DWH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DWH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DWH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DWH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DWH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DWH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DWH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DWH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DWH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DWH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DWH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DWH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DWH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DWH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DWH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DWH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DWH] SET RECOVERY FULL 
GO
ALTER DATABASE [DWH] SET  MULTI_USER 
GO
ALTER DATABASE [DWH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DWH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DWH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DWH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DWH] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DWH] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DWH] SET QUERY_STORE = ON
GO
ALTER DATABASE [DWH] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DWH]
GO
/****** Object:  Table [dbo].[Dim_Allergy]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Allergy](
	[allergy_id] [int] NOT NULL,
	[allergy_type] [nvarchar](100) NULL,
	[allergen_name] [nvarchar](100) NULL,
	[severity] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[allergy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Bed]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Bed](
	[bed_id] [int] NOT NULL,
	[room_id] [int] NULL,
	[bed_number] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[bed_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Bill]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Bill](
	[bill_sk] [int] IDENTITY(1,1) NOT NULL,
	[bill_id] [int] NULL,
	[bill_type] [varchar](50) NULL,
	[number_of_services] [int] NULL,
	[bill_total_amount] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[bill_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[bill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Date]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Date](
	[date_sk] [int] IDENTITY(1,1) NOT NULL,
	[date_id] [int] NOT NULL,
	[full_date] [date] NULL,
	[day] [int] NULL,
	[month] [int] NULL,
	[year] [int] NULL,
	[day_of_week] [nvarchar](20) NULL,
	[is_weekend] [bit] NULL,
	[week_number] [int] NULL,
	[quarter] [int] NULL,
	[full_datetime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[date_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[date_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Department]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Department](
	[department_sk] [int] IDENTITY(1,1) NOT NULL,
	[department_id] [int] NOT NULL,
	[department_name] [nvarchar](100) NULL,
	[location] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[department_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Doctor]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Doctor](
	[doctor_sk] [int] IDENTITY(1,1) NOT NULL,
	[doctor_id] [int] NOT NULL,
	[full_name] [nvarchar](100) NULL,
	[gender] [nvarchar](10) NULL,
	[specialization] [nvarchar](100) NULL,
	[years_of_experience] [int] NULL,
	[department_id] [int] NULL,
	[is_active] [bit] NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NULL,
	[IsCurrent] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[doctor_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Employee]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Employee](
	[employee_sk] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NOT NULL,
	[full_name] [nvarchar](100) NULL,
	[gender] [nvarchar](10) NULL,
	[department_id] [int] NULL,
	[employee_type] [nvarchar](50) NULL,
	[seniority_level] [nvarchar](50) NULL,
	[hire_date] [date] NULL,
	[is_active] [bit] NULL,
	[EffectiveFrom] [datetime] NULL,
	[EffectiveTo] [datetime] NULL,
	[IsCurrent] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ExpenseCategory]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ExpenseCategory](
	[expense_category_sk] [int] IDENTITY(1,1) NOT NULL,
	[category_id] [int] NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[expense_category_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Insurance]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Insurance](
	[insurance_sk] [int] IDENTITY(1,1) NOT NULL,
	[insurance_company_id] [int] NOT NULL,
	[company_name] [nvarchar](100) NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NULL,
	[IsCurrent] [bit] NOT NULL,
	[policy_number] [nvarchar](50) NULL,
	[contact_info] [nvarchar](100) NULL,
	[covarage_type] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[insurance_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[insurance_company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_LabTest]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_LabTest](
	[test_id] [int] NOT NULL,
	[test_name] [nvarchar](100) NULL,
	[description] [nvarchar](100) NULL,
	[department_id] [int] NULL,
 CONSTRAINT [PK__Dim_LabT__F3FF1C02CA95F1B8] PRIMARY KEY CLUSTERED 
(
	[test_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Patient]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Patient](
	[patient_sk] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NOT NULL,
	[first_name] [nvarchar](100) NULL,
	[last_name] [nvarchar](100) NULL,
	[gender] [nvarchar](10) NULL,
	[date_of_birth] [date] NULL,
	[has_chronic_conditions] [bit] NULL,
	[is_insured] [bit] NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NULL,
	[IsCurrent] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[patient_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_PaymentMethod]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_PaymentMethod](
	[payment_method_sk] [int] IDENTITY(1,1) NOT NULL,
	[payment_method_id] [int] NULL,
	[method_name] [nvarchar](50) NULL,
	[source_method_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_method_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_PrescriptionDrug]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_PrescriptionDrug](
	[prescription_drug_Id] [int] IDENTITY(1,1) NOT NULL,
	[medicine_name] [nvarchar](100) NULL,
	[dosage] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[prescription_drug_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Radiology]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Radiology](
	[radiology_id] [int] NOT NULL,
	[radiology_type] [nvarchar](100) NULL,
	[department_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[radiology_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Room]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Room](
	[room_id] [int] NOT NULL,
	[room_number] [nvarchar](20) NULL,
	[floor] [int] NULL,
	[capacity] [int] NULL,
	[room_type] [nvarchar](50) NULL,
	[department_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[room_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Visit]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Visit](
	[visit_sk] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NOT NULL,
	[patient_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[visit_date] [date] NOT NULL,
	[visit_type] [nvarchar](50) NULL,
	[status] [nvarchar](20) NULL,
	[discharge_date] [date] NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NULL,
	[IsCurrent] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[visit_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[visit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_VisitType]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_VisitType](
	[visit_type_sk] [int] IDENTITY(1,1) NOT NULL,
	[visit_type_id] [int] NOT NULL,
	[visit_type_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[visit_type_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[visit_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Billing]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Billing](
	[billing_sk] [int] IDENTITY(1,1) NOT NULL,
	[patient_sk] [int] NOT NULL,
	[visit_sk] [int] NULL,
	[insurance_sk] [int] NULL,
	[payment_method_sk] [int] NULL,
	[department_sk] [int] NULL,
	[bill_date_sk] [int] NOT NULL,
	[payment_date_sk] [int] NULL,
	[total_billed_amount] [decimal](18, 2) NULL,
	[total_paid_amount] [decimal](18, 2) NULL,
	[number_of_services] [int] NULL,
	[bill_sk] [int] NULL,
	[outstanding_amount]  AS (abs(isnull([total_billed_amount],(0))-isnull([total_paid_amount],(0)))),
PRIMARY KEY CLUSTERED 
(
	[billing_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Clinical]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Clinical](
	[clinical_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_id] [int] NULL,
	[patient_sk] [int] NULL,
	[department_sk] [int] NULL,
	[doctor_sk] [int] NULL,
	[clinical_date_sk] [int] NULL,
	[number_of_diagnoses] [int] NULL,
	[chronic_condition_flag] [bit] NULL,
	[allergy_count] [int] NULL,
	[has_high_severity_allergy] [bit] NULL,
	[vital_blood_pressure_systolic] [int] NULL,
	[vital_blood_pressure_diastolic] [int] NULL,
	[vital_heart_rate] [int] NULL,
	[vital_temperature] [decimal](4, 1) NULL,
	[vital_blood_oxygen_level] [int] NULL,
	[vital_respiratory_rate] [int] NULL,
	[vital_status_flag] [bit] NULL,
	[number_of_lab_tests] [int] NULL,
	[number_of_abnormal_results] [int] NULL,
	[abnormal_result_flag] [bit] NULL,
	[has_radiology] [bit] NULL,
	[radiology_types_count] [int] NULL,
	[follow_up_required_flag] [bit] NULL,
	[general_health_status] [nvarchar](50) NULL,
	[severity_score] [int] NULL,
	[prescription_drug_Id] [int] NULL,
	[allergy_sk] [int] NULL,
	[radiology_sk] [int] NULL,
	[lab_test_sk] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[clinical_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Employee_Workload]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Employee_Workload](
	[workload_id] [int] IDENTITY(1,1) NOT NULL,
	[date_sk] [int] NOT NULL,
	[employee_sk] [int] NOT NULL,
	[total_shifts] [int] NULL,
	[total_shift_hours] [decimal](5, 2) NULL,
	[leave_days] [int] NULL,
	[absent_days] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[workload_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Employee_Workload_Staging]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Employee_Workload_Staging](
	[date_sk] [int] NULL,
	[employee_sk] [int] NULL,
	[total_shifts] [int] NULL,
	[total_shift_hours] [decimal](5, 2) NULL,
	[leave_days] [int] NULL,
	[absent_days] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Expense]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Expense](
	[expense_sk] [int] IDENTITY(1,1) NOT NULL,
	[expense_id] [int] NOT NULL,
	[department_sk] [int] NULL,
	[expense_category_sk] [int] NOT NULL,
	[expense_date_sk] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[created_by_employee_sk] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[expense_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Resource]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Resource](
	[resource_occupancy_id] [int] IDENTITY(1,1) NOT NULL,
	[date_id] [int] NOT NULL,
	[room_id] [int] NOT NULL,
	[bed_id] [int] NOT NULL,
	[room_occupancy_rate] [decimal](5, 2) NULL,
	[avg_room_occupancy_duration] [decimal](5, 2) NULL,
	[bed_occupancy_rate] [decimal](5, 2) NULL,
	[bed_turnover_rate] [decimal](5, 2) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[resource_occupancy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Visits]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Visits](
	[visit_id] [int] NOT NULL,
	[patient_sk] [int] NULL,
	[department_sk] [int] NULL,
	[doctor_sk] [int] NULL,
	[visit_date_sk] [int] NULL,
	[discharge_date_sk] [int] NULL,
	[visit_type_sk] [int] NULL,
	[visit_duration_days] [int] NULL,
	[visit_status] [nvarchar](50) NULL,
	[is_emergency] [bit] NULL,
	[is_followup] [bit] NULL,
	[visit_outcome] [nvarchar](50) NULL,
	[time_to_discharge_minutes] [int] NULL,
	[no_show_flag] [bit] NULL,
	[followup_required_flag] [bit] NULL,
	[number_of_visits_for_patient] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[visit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stage_Fact_Visits]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stage_Fact_Visits](
	[visit_id] [int] NOT NULL,
	[patient_sk] [int] NULL,
	[department_sk] [int] NULL,
	[doctor_sk] [int] NULL,
	[visit_date_sk] [int] NULL,
	[discharge_date_sk] [int] NULL,
	[visit_type_sk] [int] NULL,
	[visit_duration_days] [int] NULL,
	[visit_status] [nvarchar](50) NULL,
	[is_emergency] [bit] NULL,
	[is_followup] [bit] NULL,
	[visit_outcome] [nvarchar](50) NULL,
	[time_to_discharge_minutes] [int] NULL,
	[no_show_flag] [bit] NULL,
	[followup_required_flag] [bit] NULL,
	[number_of_visits_for_patient] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[visit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staging_Clinical]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_Clinical](
	[visit_id] [int] NULL,
	[patient_sk] [int] NULL,
	[department_sk] [int] NULL,
	[doctor_sk] [int] NULL,
	[clinical_date_sk] [int] NULL,
	[number_of_diagnoses] [int] NULL,
	[chronic_condition_flag] [bit] NULL,
	[allergy_count] [int] NULL,
	[has_high_severity_allergy] [bit] NULL,
	[vital_blood_pressure_systolic] [int] NULL,
	[vital_blood_pressure_diastolic] [int] NULL,
	[vital_heart_rate] [int] NULL,
	[vital_temperature] [decimal](4, 1) NULL,
	[vital_blood_oxygen_level] [int] NULL,
	[vital_respiratory_rate] [int] NULL,
	[vital_status_flag] [bit] NULL,
	[number_of_lab_tests] [int] NULL,
	[number_of_abnormal_results] [int] NULL,
	[abnormal_result_flag] [bit] NULL,
	[has_radiology] [bit] NULL,
	[radiology_types_count] [int] NULL,
	[follow_up_required_flag] [bit] NULL,
	[general_health_status] [nvarchar](50) NULL,
	[severity_score] [int] NULL,
	[prescription_drug_Id] [int] NULL,
	[allergy_sk] [int] NULL,
	[radiology_sk] [int] NULL,
	[lab_test_sk] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staging_Fact_Billing]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_Fact_Billing](
	[bill_sk] [int] NULL,
	[patient_sk] [int] NULL,
	[visit_sk] [int] NULL,
	[insurance_sk] [int] NULL,
	[payment_method_sk] [int] NULL,
	[department_sk] [int] NULL,
	[bill_date_sk] [int] NULL,
	[payment_date_sk] [int] NULL,
	[total_billed_amount] [decimal](18, 2) NULL,
	[total_paid_amount] [decimal](18, 2) NULL,
	[number_of_services] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staging_Fact_Expense]    Script Date: 7/19/2025 4:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_Fact_Expense](
	[expense_id] [int] NULL,
	[department_sk] [int] NULL,
	[expense_category_sk] [int] NOT NULL,
	[expense_date_sk] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[created_by_employee_sk] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dim_Employee] ADD  CONSTRAINT [DF_Dim_Employee_IsCurrent]  DEFAULT ((1)) FOR [IsCurrent]
GO
ALTER TABLE [dbo].[Dim_Insurance] ADD  CONSTRAINT [DF_Dim_Insurance_IsCurrent]  DEFAULT ((1)) FOR [IsCurrent]
GO
ALTER TABLE [dbo].[Dim_Visit] ADD  DEFAULT (getdate()) FOR [EffectiveFrom]
GO
ALTER TABLE [dbo].[Dim_Visit] ADD  DEFAULT ((1)) FOR [IsCurrent]
GO
ALTER TABLE [dbo].[Fact_Employee_Workload] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Fact_Visits] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Dim_Bed]  WITH CHECK ADD FOREIGN KEY([room_id])
REFERENCES [dbo].[Dim_Room] ([room_id])
GO
ALTER TABLE [dbo].[Fact_Billing]  WITH CHECK ADD FOREIGN KEY([bill_date_sk])
REFERENCES [dbo].[Dim_Date] ([date_sk])
GO
ALTER TABLE [dbo].[Fact_Billing]  WITH CHECK ADD FOREIGN KEY([department_sk])
REFERENCES [dbo].[Dim_Department] ([department_sk])
GO
ALTER TABLE [dbo].[Fact_Billing]  WITH CHECK ADD FOREIGN KEY([insurance_sk])
REFERENCES [dbo].[Dim_Insurance] ([insurance_sk])
GO
ALTER TABLE [dbo].[Fact_Billing]  WITH CHECK ADD FOREIGN KEY([patient_sk])
REFERENCES [dbo].[Dim_Patient] ([patient_sk])
GO
ALTER TABLE [dbo].[Fact_Billing]  WITH CHECK ADD FOREIGN KEY([payment_date_sk])
REFERENCES [dbo].[Dim_Date] ([date_sk])
GO
ALTER TABLE [dbo].[Fact_Billing]  WITH CHECK ADD FOREIGN KEY([payment_method_sk])
REFERENCES [dbo].[Dim_PaymentMethod] ([payment_method_sk])
GO
ALTER TABLE [dbo].[Fact_Billing]  WITH CHECK ADD FOREIGN KEY([visit_sk])
REFERENCES [dbo].[Dim_Visit] ([visit_sk])
GO
ALTER TABLE [dbo].[Fact_Billing]  WITH CHECK ADD  CONSTRAINT [FK_FactBilling_DimBill] FOREIGN KEY([bill_sk])
REFERENCES [dbo].[Dim_Bill] ([bill_sk])
GO
ALTER TABLE [dbo].[Fact_Billing] CHECK CONSTRAINT [FK_FactBilling_DimBill]
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([allergy_sk])
REFERENCES [dbo].[Dim_Allergy] ([allergy_id])
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([clinical_date_sk])
REFERENCES [dbo].[Dim_Date] ([date_sk])
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([department_sk])
REFERENCES [dbo].[Dim_Department] ([department_sk])
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([doctor_sk])
REFERENCES [dbo].[Dim_Doctor] ([doctor_sk])
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([lab_test_sk])
REFERENCES [dbo].[Dim_LabTest] ([test_id])
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([patient_sk])
REFERENCES [dbo].[Dim_Patient] ([patient_sk])
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([prescription_drug_Id])
REFERENCES [dbo].[Dim_PrescriptionDrug] ([prescription_drug_Id])
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([radiology_sk])
REFERENCES [dbo].[Dim_Radiology] ([radiology_id])
GO
ALTER TABLE [dbo].[Fact_Clinical]  WITH CHECK ADD FOREIGN KEY([visit_id])
REFERENCES [dbo].[Fact_Visits] ([visit_id])
GO
ALTER TABLE [dbo].[Fact_Employee_Workload]  WITH CHECK ADD FOREIGN KEY([date_sk])
REFERENCES [dbo].[Dim_Date] ([date_sk])
GO
ALTER TABLE [dbo].[Fact_Employee_Workload]  WITH CHECK ADD FOREIGN KEY([employee_sk])
REFERENCES [dbo].[Dim_Employee] ([employee_sk])
GO
ALTER TABLE [dbo].[Fact_Expense]  WITH CHECK ADD FOREIGN KEY([created_by_employee_sk])
REFERENCES [dbo].[Dim_Employee] ([employee_sk])
GO
ALTER TABLE [dbo].[Fact_Expense]  WITH CHECK ADD FOREIGN KEY([department_sk])
REFERENCES [dbo].[Dim_Department] ([department_sk])
GO
ALTER TABLE [dbo].[Fact_Expense]  WITH CHECK ADD FOREIGN KEY([expense_category_sk])
REFERENCES [dbo].[Dim_ExpenseCategory] ([expense_category_sk])
GO
ALTER TABLE [dbo].[Fact_Expense]  WITH CHECK ADD FOREIGN KEY([expense_date_sk])
REFERENCES [dbo].[Dim_Date] ([date_sk])
GO
ALTER TABLE [dbo].[Fact_Resource]  WITH CHECK ADD  CONSTRAINT [FK_FactRes_Bed] FOREIGN KEY([bed_id])
REFERENCES [dbo].[Dim_Bed] ([bed_id])
GO
ALTER TABLE [dbo].[Fact_Resource] CHECK CONSTRAINT [FK_FactRes_Bed]
GO
ALTER TABLE [dbo].[Fact_Resource]  WITH CHECK ADD  CONSTRAINT [FK_FactRes_Date] FOREIGN KEY([date_id])
REFERENCES [dbo].[Dim_Date] ([date_id])
GO
ALTER TABLE [dbo].[Fact_Resource] CHECK CONSTRAINT [FK_FactRes_Date]
GO
ALTER TABLE [dbo].[Fact_Resource]  WITH CHECK ADD  CONSTRAINT [FK_FactRes_Room] FOREIGN KEY([room_id])
REFERENCES [dbo].[Dim_Room] ([room_id])
GO
ALTER TABLE [dbo].[Fact_Resource] CHECK CONSTRAINT [FK_FactRes_Room]
GO
ALTER TABLE [dbo].[Fact_Visits]  WITH CHECK ADD FOREIGN KEY([department_sk])
REFERENCES [dbo].[Dim_Department] ([department_sk])
GO
ALTER TABLE [dbo].[Fact_Visits]  WITH CHECK ADD FOREIGN KEY([discharge_date_sk])
REFERENCES [dbo].[Dim_Date] ([date_sk])
GO
ALTER TABLE [dbo].[Fact_Visits]  WITH CHECK ADD FOREIGN KEY([doctor_sk])
REFERENCES [dbo].[Dim_Doctor] ([doctor_sk])
GO
ALTER TABLE [dbo].[Fact_Visits]  WITH CHECK ADD FOREIGN KEY([patient_sk])
REFERENCES [dbo].[Dim_Patient] ([patient_sk])
GO
ALTER TABLE [dbo].[Fact_Visits]  WITH CHECK ADD FOREIGN KEY([visit_date_sk])
REFERENCES [dbo].[Dim_Date] ([date_sk])
GO
ALTER TABLE [dbo].[Fact_Visits]  WITH CHECK ADD FOREIGN KEY([visit_type_sk])
REFERENCES [dbo].[Dim_VisitType] ([visit_type_sk])
GO
USE [master]
GO
ALTER DATABASE [DWH] SET  READ_WRITE 
GO
