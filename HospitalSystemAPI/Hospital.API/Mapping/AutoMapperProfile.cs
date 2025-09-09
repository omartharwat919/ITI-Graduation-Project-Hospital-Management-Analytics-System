using AutoMapper;
using Hospital.API.Dtos;
using Hospital.API.Models;

namespace Hospital.API.Mapping
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<Patient, PatientDto>().ReverseMap();
            CreateMap<CreatePatientDto, Patient>();
            CreateMap<UpdatePatientDto, Patient>();
            CreateMap<MedicalRecord, MedicalRecordDto>().ReverseMap();
            CreateMap<MedicalRecord, MedicalRecordDto>();
            CreateMap<CreateMedicalRecordDto, MedicalRecord>();
            CreateMap<UpdateMedicalRecordDto, MedicalRecord>();
            CreateMap<VisitVital, VitalDto>().ReverseMap();
            CreateMap<VisitVital, CreateVitalDto>().ReverseMap();
            CreateMap<VisitVital, UpdateVitalDto>().ReverseMap();   
            CreateMap<Bill, BillingSummaryDto>()
                .ForMember(dest => dest.BillId, opt => opt.MapFrom(src => src.BillId))
                .ForMember(dest => dest.TotalAmount, opt => opt.MapFrom(src => src.TotalAmount ?? 0))
                .ForMember(dest => dest.TotalPaid, opt => opt.MapFrom(src => src.Payments.Sum(p => p.Amount ?? 0)))
                .ForMember(dest => dest.Services, opt => opt.MapFrom(src => src.BillItems))
                .ForMember(dest => dest.Payments, opt => opt.MapFrom(src => src.Payments));

            CreateMap<BillItem, BillingServiceItemDto>()
                .ForMember(dest => dest.ServiceName, opt => opt.MapFrom(src => src.Service.ServiceName))
                .ForMember(dest => dest.Amount, opt => opt.MapFrom(src => src.Amount ?? 0));

            CreateMap<Payment, BillingPaymentDto>()
                .ForMember(dest => dest.MethodName, opt => opt.MapFrom(src => src.Method.MethodName))
                .ForMember(dest => dest.Amount, opt => opt.MapFrom(src => src.Amount ?? 0))
                .ForMember(dest => dest.PaymentDate, opt => opt.MapFrom(src => src.PaymentDate ?? DateTime.MinValue));


        }
    }
}
