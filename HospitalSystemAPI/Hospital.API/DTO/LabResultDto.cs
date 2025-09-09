namespace Hospital.API.Dtos
{
    public class LabResultDto
    {
        public string TestName { get; set; }                // من جدول Lab_Tests
        public string AttributeName { get; set; }           // من Test_Result_Details
        public string AttributeValue { get; set; }          // القيمة المقاسة
        public string NormalRange { get; set; }             // النطاق الطبيعي
        public DateTime ResultDate { get; set; }            // تاريخ النتيجة
    }
}
