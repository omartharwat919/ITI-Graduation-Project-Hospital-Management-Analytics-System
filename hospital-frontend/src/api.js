// src/api.js
import axios from 'axios';

const API = axios.create({
  baseURL: 'https://localhost:7044/api',
});

// Interceptor لإضافة التوكن تلقائياً
API.interceptors.request.use(config => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});
export const reportsAPI = {
  getPatientVisits: () => API.get('/reports/patient-visits'),
  getDoctorsBySpecialization: () => API.get('/reports/doctors-by-specialization'),
  getNurseShiftAssignments: () => API.get('/reports/nurse-shift-assignments')
};
// الخدمات الحالية (الخاصة بالمصادقة)
export const loginUser = (credentials) => API.post('/login', credentials);
// Add to your existing API configuration
export const labResultAPI = {
  getByVisitId: (visitId) => API.get(`/LabResult/visit/${visitId}`),
  getPatientResults: () => API.get('/LabResult'),
  // Add other lab result endpoints as needed
};
// خدمات المرضى
export const patientAPI = {
  getAll: () => API.get('/Patient'),
  getById: (id) => API.get(`/Patient/${id}`),
  create: (data) => API.post('/Patient', data),
  update: (id, data) => API.put(`/Patient/${id}`, data),
  delete: (id) => API.delete(`/Patient/${id}`),
  getMyProfile: () => API.get('/Patient/myprofile'), // إضافة خدمة الملف الشخصي للمريض
};
// Add to your existing API configuration
export const billingAPI = {
  getMyBills: () => API.get('/Billing/my'),
  getAllBills: () => API.get('/Billing/all'),
  // Add other billing-related endpoints as needed
};
// خدمات السجلات الطبية
export const medicalRecordAPI = {
  getByVisit: (visitId) => API.get(`/MedicalRecord/${visitId}`),
  getPatientRecords: (patientId) => API.get(`/MedicalRecord/patient/${patientId}`),
  create: (data) => API.post('/MedicalRecord', data),
  update: (visitId, data) => API.put(`/MedicalRecord/${visitId}`, data),
};
export const vitalAPI = {
      getRecentVitals: () => API.get('/Vital/recent'),

  getByVisitId: (visitId) => API.get(`/Vital/${visitId}`),
  // Add other vital-related API calls as needed
};
// خدمات إضافية قد تحتاجها
export const visitAPI = {
  getById: (id) => API.get(`/Visit/${id}`),
  getPatientVisits: (patientId) => API.get(`/Visit/patient/${patientId}`),
};

export default API;