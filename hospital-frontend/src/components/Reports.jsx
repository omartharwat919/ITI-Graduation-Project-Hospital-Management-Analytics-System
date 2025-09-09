import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { reportsAPI } from '../api';
import './Reports.css';
import {
  FaUserInjured, FaUserMd, FaUserNurse, FaChartBar,
  FaTable, FaChartPie, FaChartLine, FaFileAlt, FaArrowLeft
} from 'react-icons/fa';
import { Chart as ChartJS, registerables } from 'chart.js';
import { Bar, Pie, Line, Doughnut, PolarArea, Radar } from 'react-chartjs-2';

ChartJS.register(...registerables);

// Chart Components
const CustomBarChart = ({ title, data }) => (
  <div className="chart-container">
    <h4>{title}</h4>
    <Bar 
      data={data}
      options={{
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { display: false },
          tooltip: { enabled: true }
        },
        scales: {
          y: { 
            beginAtZero: true,
            grid: { color: 'rgba(0, 0, 0, 0.05)' }
          },
          x: { 
            grid: { color: 'rgba(0, 0, 0, 0.05)' }
          }
        }
      }}
    />
  </div>
);

const CustomPieChart = ({ title, data }) => (
  <div className="chart-container">
    <h4>{title}</h4>
    <Pie 
      data={data}
      options={{
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'right' }
        }
      }}
    />
  </div>
);

const CustomLineChart = ({ title, data }) => (
  <div className="chart-container">
    <h4>{title}</h4>
    <Line 
      data={data}
      options={{
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'top' }
        },
        scales: {
          y: { 
            beginAtZero: true,
            grid: { color: 'rgba(0, 0, 0, 0.05)' }
          },
          x: { 
            grid: { color: 'rgba(0, 0, 0, 0.05)' }
          }
        }
      }}
    />
  </div>
);

const CustomDoughnutChart = ({ title, data }) => (
  <div className="chart-container">
    <h4>{title}</h4>
    <Doughnut 
      data={data}
      options={{
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'right' }
        },
        cutout: '70%'
      }}
    />
  </div>
);

const CustomPolarChart = ({ title, data }) => (
  <div className="chart-container">
    <h4>{title}</h4>
    <PolarArea 
      data={data}
      options={{
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'right' }
        },
        scales: {
          r: {
            grid: { color: 'rgba(0, 0, 0, 0.05)' }
          }
        }
      }}
    />
  </div>
);

const CustomRadarChart = ({ title, data }) => (
  <div className="chart-container">
    <h4>{title}</h4>
    <Radar 
      data={data}
      options={{
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'top' }
        },
        scales: {
          r: {
            angleLines: { color: 'rgba(0, 0, 0, 0.1)' },
            grid: { color: 'rgba(0, 0, 0, 0.05)' }
          }
        }
      }}
    />
  </div>
);

// Data Processing Functions
const processVisitsByDay = (data) => {
  const daysMap = data.reduce((acc, visit) => {
    const date = new Date(visit.visitDate).toLocaleDateString();
    acc[date] = (acc[date] || 0) + 1;
    return acc;
  }, {});

  return {
    labels: Object.keys(daysMap),
    datasets: [{
      label: 'Visits Count',
      data: Object.values(daysMap),
      backgroundColor: 'rgba(100, 149, 237, 0.7)',
      borderColor: 'rgba(100, 149, 237, 1)',
      borderWidth: 1
    }]
  };
};

const processVisitTypes = (data) => {
  const typesMap = data.reduce((acc, visit) => {
    acc[visit.visitType] = (acc[visit.visitType] || 0) + 1;
    return acc;
  }, {});

  const backgroundColors = [
    'rgba(255, 105, 97, 0.7)',
    'rgba(119, 221, 119, 0.7)',
    'rgba(177, 156, 217, 0.7)',
    'rgba(253, 253, 150, 0.7)',
    'rgba(174, 198, 207, 0.7)'
  ];

  return {
    labels: Object.keys(typesMap),
    datasets: [{
      label: 'Visits Count',
      data: Object.values(typesMap),
      backgroundColor: backgroundColors.slice(0, Object.keys(typesMap).length),
      borderWidth: 1
    }]
  };
};

const processDoctorsBySpecialization = (data) => {
  const specMap = data.reduce((acc, doctor) => {
    acc[doctor.specializationName] = (acc[doctor.specializationName] || 0) + 1;
    return acc;
  }, {});

  return {
    labels: Object.keys(specMap),
    datasets: [{
      label: 'Doctors Count',
      data: Object.values(specMap),
      backgroundColor: 'rgba(77, 182, 172, 0.7)',
      borderColor: 'rgba(77, 182, 172, 1)',
      borderWidth: 1
    }]
  };
};

const processNurseShifts = (data) => {
  const shiftsMap = data.reduce((acc, nurse) => {
    acc[nurse.shiftDay] = (acc[nurse.shiftDay] || 0) + 1;
    return acc;
  }, {});

  return {
    labels: Object.keys(shiftsMap),
    datasets: [{
      label: 'Nurses Count',
      data: Object.values(shiftsMap),
      backgroundColor: 'rgba(195, 155, 211, 0.7)',
      borderColor: 'rgba(195, 155, 211, 1)',
      borderWidth: 1,
      tension: 0.3
    }]
  };
};

const processNurseSpecializations = (data) => {
  const specMap = data.reduce((acc, nurse) => {
    acc[nurse.specialization] = (acc[nurse.specialization] || 0) + 1;
    return acc;
  }, {});

  return {
    labels: Object.keys(specMap),
    datasets: [{
      label: 'Specializations',
      data: Object.values(specMap),
      backgroundColor: [
        'rgba(255, 153, 153, 0.7)',
        'rgba(158, 202, 225, 0.7)',
        'rgba(196, 223, 155, 0.7)',
        'rgba(247, 202, 201, 0.7)'
      ],
      borderWidth: 1
    }]
  };
};

const processVisitDurations = (data) => {
  const durations = data.map(visit => {
    const admission = new Date(visit.visitDate);
    const discharge = visit.dischargeDate ? new Date(visit.dischargeDate) : new Date();
    return Math.round((discharge - admission) / (1000 * 60 * 60 * 24));
  });

  return {
    labels: data.map((_, i) => `Visit ${i+1}`),
    datasets: [{
      label: 'Duration (days)',
      data: durations,
      backgroundColor: 'rgba(255, 178, 102, 0.7)',
      borderColor: 'rgba(255, 178, 102, 1)',
      borderWidth: 1
    }]
  };
};

const Reports = () => {
  const [activeReport, setActiveReport] = useState(null);
  const [reportData, setReportData] = useState({});
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const reports = [
    {
      id: 'patient-visits',
      title: 'Patient Visits Report',
      icon: <FaUserInjured />,
      description: 'Detailed patient visits with diagnosis information'
    },
    {
      id: 'doctors-by-specialization',
      title: 'Doctors by Specialization',
      icon: <FaUserMd />,
      description: 'List of doctors grouped by medical specializations'
    },
    {
      id: 'nurse-shift-assignments',
      title: 'Nurse Shift Assignments',
      icon: <FaUserNurse />,
      description: 'Nurse assignments with room and shift details'
    }
  ];

  const fetchReportData = async (reportId) => {
    setIsLoading(true);
    setError(null);
    
    try {
      let response;
      switch(reportId) {
        case 'patient-visits':
          response = await reportsAPI.getPatientVisits();
          break;
        case 'doctors-by-specialization':
          response = await reportsAPI.getDoctorsBySpecialization();
          break;
        case 'nurse-shift-assignments':
          response = await reportsAPI.getNurseShiftAssignments();
          break;
        default:
          throw new Error('Invalid report type');
      }

      setReportData({ ...reportData, [reportId]: response.data });
    } catch (error) {
      console.error('Error fetching report:', error);
      setError(error.message || 'Failed to load report data');
    } finally {
      setIsLoading(false);
    }
  };

  const handleReportClick = (reportId) => {
    setActiveReport(reportId);
    fetchReportData(reportId);
  };

  const renderReportContent = () => {
    if (!activeReport) {
      return (
        <div className="reports-grid">
          {reports.map((report) => (
            <div 
              key={report.id} 
              className="report-card"
              onClick={() => handleReportClick(report.id)}
            >
              <div className="report-icon">{report.icon}</div>
              <h3>{report.title}</h3>
              <p>{report.description}</p>
            </div>
          ))}
        </div>
      );
    }

    if (isLoading) {
      return <div className="loading">Loading report data...</div>;
    }

    if (error) {
      return (
        <div className="error-message">
          <p>{error}</p>
          <button onClick={() => setActiveReport(null)} className="back-button">
            <FaArrowLeft /> Back to Reports
          </button>
        </div>
      );
    }

    switch (activeReport) {
      case 'patient-visits':
        return (
          <div className="report-details">
            <div className="report-header">
              <h2>Patient Visits Report</h2>
              <button onClick={() => setActiveReport(null)} className="back-button">
                <FaArrowLeft /> Back to Reports
              </button>
            </div>
            
            {reportData[activeReport]?.length > 0 ? (
              <div className="report-visualizations">
                {/* Charts now appear first */}
                <div className="visualization-card">
                  <h3><FaChartBar /> Analytics Dashboard</h3>
                  <div className="charts-grid">
                    <CustomBarChart 
                      title="Daily Visits Trend"
                      data={processVisitsByDay(reportData[activeReport])}
                    />
                    <CustomPieChart
                      title="Visit Types Breakdown"
                      data={processVisitTypes(reportData[activeReport])}
                    />
                    <CustomLineChart
                      title="Visit Durations (Days)"
                      data={processVisitDurations(reportData[activeReport])}
                    />
                    <CustomRadarChart
                      title="Visit Type Radar"
                      data={processVisitTypes(reportData[activeReport])}
                    />
                  </div>
                </div>

                <div className="visualization-card">
                  <h3><FaTable /> Detailed Data</h3>
                  <div className="table-container">
                    <table>
                      <thead>
                        <tr>
                          <th>Patient ID</th>
                          <th>Full Name</th>
                          <th>Visit Date</th>
                          <th>Visit Type</th>
                          <th>Diagnosis</th>
                          <th>Discharge Date</th>
                        </tr>
                      </thead>
                      <tbody>
                        {reportData[activeReport].map((item, index) => (
                          <tr key={index}>
                            <td>{item.patientId}</td>
                            <td>{item.fullName}</td>
                            <td>{new Date(item.visitDate).toLocaleDateString()}</td>
                            <td>{item.visitType}</td>
                            <td>{item.diagnosisText}</td>
                            <td>{item.dischargeDate ? new Date(item.dischargeDate).toLocaleDateString() : 'N/A'}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            ) : (
              <p className="no-data">No patient visits data available</p>
            )}
          </div>
        );

      case 'doctors-by-specialization':
        return (
          <div className="report-details">
            <div className="report-header">
              <h2>Doctors by Specialization Report</h2>
              <button onClick={() => setActiveReport(null)} className="back-button">
                <FaArrowLeft /> Back to Reports
              </button>
            </div>
            
            {reportData[activeReport]?.length > 0 ? (
              <div className="report-visualizations">
                <div className="visualization-card">
                  <h3><FaChartPie /> Specialization Analytics</h3>
                  <div className="charts-grid">
                    <CustomBarChart 
                      title="Doctors per Specialization"
                      data={processDoctorsBySpecialization(reportData[activeReport])}
                    />
                    <CustomDoughnutChart
                      title="Specialization Distribution"
                      data={processDoctorsBySpecialization(reportData[activeReport])}
                    />
                    <CustomPolarChart
                      title="Specialization Comparison"
                      data={processDoctorsBySpecialization(reportData[activeReport])}
                    />
                  </div>
                </div>

                <div className="visualization-card">
                  <h3><FaTable /> Doctors List</h3>
                  <div className="table-container">
                    <table>
                      <thead>
                        <tr>
                          <th>Specialization</th>
                          <th>Doctor Name</th>
                          <th>Doctor ID</th>
                          <th>Years of Experience</th>
                        </tr>
                      </thead>
                      <tbody>
                        {reportData[activeReport].map((item, index) => (
                          <tr key={index}>
                            <td>{item.specializationName}</td>
                            <td>{item.doctorName}</td>
                            <td>{item.doctorId}</td>
                            <td>{item.yearsOfExperience}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            ) : (
              <p className="no-data">No doctors data available</p>
            )}
          </div>
        );

      case 'nurse-shift-assignments':
        return (
          <div className="report-details">
            <div className="report-header">
              <h2>Nurse Shift Assignments Report</h2>
              <button onClick={() => setActiveReport(null)} className="back-button">
                <FaArrowLeft /> Back to Reports
              </button>
            </div>
            
            {reportData[activeReport]?.length > 0 ? (
              <div className="report-visualizations">
                <div className="visualization-card">
                  <h3><FaChartLine /> Shift Analytics</h3>
                  <div className="charts-grid">
                    <CustomLineChart 
                      title="Nurses per Shift Day"
                      data={processNurseShifts(reportData[activeReport])}
                    />
                    <CustomPieChart
                      title="Specialization Distribution"
                      data={processNurseSpecializations(reportData[activeReport])}
                    />
                    <CustomRadarChart
                      title="Shift Coverage Analysis"
                      data={processNurseShifts(reportData[activeReport])}
                    />
                  </div>
                </div>

                <div className="visualization-card">
                  <h3><FaTable /> Assignments List</h3>
                  <div className="table-container">
                    <table>
                      <thead>
                        <tr>
                          <th>Nurse Name</th>
                          <th>Specialization</th>
                          <th>Room Number</th>
                          <th>Floor</th>
                          <th>Shift Day</th>
                          <th>Shift Time</th>
                        </tr>
                      </thead>
                      <tbody>
                        {reportData[activeReport].map((item, index) => (
                          <tr key={index}>
                            <td>{item.nurseName}</td>
                            <td>{item.specialization}</td>
                            <td>{item.roomNumber}</td>
                            <td>{item.floor}</td>
                            <td>{item.shiftDay}</td>
                            <td>{item.startTime} - {item.endTime}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            ) : (
              <p className="no-data">No nurse assignments data available</p>
            )}
          </div>
        );

      default:
        return <div>Select a report to view details</div>;
    }
  };

  return (
    <div className="reports-container">
      {renderReportContent()}
    </div>
  );
};

export default Reports;