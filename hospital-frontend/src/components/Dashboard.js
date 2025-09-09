import { useNavigate } from 'react-router-dom';
import React, { useState, useEffect, useRef } from 'react';
import axios from 'axios';
import './Dashboard.css';
import {
  HeartPulse, FileText, FlaskConical, Calendar
} from 'lucide-react';
import {
  FaUserInjured, FaFileInvoiceDollar, FaHeartbeat, 
  FaBed, FaChartLine, FaUsers, FaHospital, 
  FaFolderOpen, FaCog, FaSignOutAlt, FaSearch, FaFlask
} from 'react-icons/fa';
import { Bar, Line } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Tooltip, Legend, PointElement, LineElement } from 'chart.js';
import Patients from './Patients';
import MedicalRecords from './MedicalRecords';
import VitalsDashboard from './VitalsDashboard';
import BillingDashboard from './BillingDashboard';
import LabTestsDashboard from './LabTestsDashboard';
import Reports from './Reports';

// Register ChartJS components
ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  PointElement,
  LineElement,
  Tooltip,
  Legend
);

// Helper function for counter animation
const useCounterAnimation = (target, duration = 1000) => {
  const [count, setCount] = useState(0);
  const animationRef = useRef(null);

  useEffect(() => {
    if (target > 0) {
      const increment = target / (duration / 16); // 60fps
      let current = 0;

      const animate = () => {
        current += increment;
        if (current < target) {
          setCount(Math.ceil(current));
          animationRef.current = requestAnimationFrame(animate);
        } else {
          setCount(target);
        }
      };

      animationRef.current = requestAnimationFrame(animate);
    }

    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
    };
  }, [target, duration]);

  return count;
};

const Dashboard = () => {
  const navigate = useNavigate();
  const [activeMenuItem, setActiveMenuItem] = useState('Dashboard');
  const [userData, setUserData] = useState({});
  const [stats, setStats] = useState({
    totalPatients: 0,
    activeVisits: 0,
    availableRooms: 0,
    staffMembers: 0,
    todayRevenue: 0,
    todays_appointments: 0
  });
  const [isLoading, setIsLoading] = useState(true);
  const [appointmentsData, setAppointmentsData] = useState([]);

  // Animated counters
  const animatedTotalPatients = useCounterAnimation(stats.totalPatients);
  const animatedActiveVisits = useCounterAnimation(stats.activeVisits);
  const animatedAvailableRooms = useCounterAnimation(stats.availableRooms);
  const animatedStaffMembers = useCounterAnimation(stats.staffMembers);
  const animatedTodayRevenue = useCounterAnimation(stats.todayRevenue);
  const animatedTodaysAppointments = useCounterAnimation(stats.todays_appointments);

  useEffect(() => {
    const user = {
      name: localStorage.getItem('userName'),
      role: localStorage.getItem('userRole'),
      id: localStorage.getItem('userId')
    };
    setUserData(user);

    const fetchStats = async () => {
      try {
        const token = localStorage.getItem('token');
        const res = await axios.get('http://localhost:5173/api/statistics/dashboard-metrics', {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });

        const data = res.data;

        setStats({
          totalPatients: data.total_patients || 0,
          activeVisits: 35,
          availableRooms: data.available_rooms || 0,
          staffMembers: data.staff_members || 0,
          todayRevenue: 300,
          todays_appointments: 4
        });

        // Generate sample appointments data for the chart
        const sampleAppointments = [
          { day: 'Mon', appointments: 12 },
          { day: 'Tue', appointments: 19 },
          { day: 'Wed', appointments: 15 },
          { day: 'Thu', appointments: 22 },
          { day: 'Fri', appointments: 18 },
          { day: 'Sat', appointments: 8 },
          { day: 'Sun', appointments: 5 }
        ];
        setAppointmentsData(sampleAppointments);
      } catch (err) {
        console.error('Error loading dashboard metrics:', err);
      } finally {
        setIsLoading(false);
      }
    };

    fetchStats();
  }, []);

  const handleLogout = () => {
    localStorage.clear();
    navigate('/login', { replace: true });
  };

  const dashboardData = {
    date: new Date().toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    }),
    stats: [
      { 
        icon: <FaUsers />, 
        title: 'Total Patients', 
        count: animatedTotalPatients, 
        percentage: '+12% from last month', 
        color: '#4CAF50', 
        iconBg: '#e8f5e9' 
      },
      { 
        icon: <Calendar />,
        title: "Today's Appointments",
        count: animatedTodaysAppointments,
        percentage: '+5 from yesterday', 
        color: '#2196F3',
        iconBg: '#e3f2fd' 
      },
      { 
        icon: <FaChartLine />, 
        title: 'Active Visits', 
        count: animatedActiveVisits, 
        color: '#FFC107', 
        iconBg: '#fffde7' 
      },
      { 
        icon: <FaBed />, 
        title: 'Available Rooms', 
        count: animatedAvailableRooms, 
        color: '#9C27B0', 
        iconBg: '#f3e5f5' 
      },
      { 
        icon: <FaFileInvoiceDollar />, 
        title: 'Revenue (Today)', 
        count: `$${animatedTodayRevenue.toLocaleString()}`, 
        percentage: '+8.2% from yesterday', 
        color: '#FF5722', 
        iconBg: '#fbe9e7' 
      },
    ],
    departmentStatus: [
      { name: 'Emergency', patients: 12, status: 'High' },
      { name: 'Cardiology', patients: 8, status: 'Normal' },
      { name: 'Pediatrics', patients: 15, status: 'Normal' },
    ]
  };

  const sidebarNavItems = [
    { name: 'Dashboard', icon: <FaHospital />, label: 'Dashboard' },
    { name: 'Patients', icon: <FaUserInjured />, label: 'Patients' },
    { name: 'Medical Records', icon: <FileText />, label: 'Medical Records' },
    { name: 'Vitals', icon: <HeartPulse />, label: 'Vitals' },
    { name: 'Lab Tests', icon: <FaFlask />, label: 'Lab Tests' },
    { name: 'Billing', icon: <FaFileInvoiceDollar />, label: 'Billing' },
    { name: 'Reports', icon: <FaChartLine />, label: 'Reports' },
    { name: 'Settings', icon: <FaCog />, label: 'Settings' },
  ];

  const renderContent = () => {
    if (isLoading) return <div className="loading">Loading dashboard...</div>;

    switch(activeMenuItem) {
      case 'Patients':
        return <Patients isPatient={userData.role === 'Patient'} />;
      case 'Medical Records':
        return <MedicalRecords />;
      case 'Vitals':
        return <VitalsDashboard />;
      case 'Billing':
        return <BillingDashboard isPatient={userData.role === 'Patient'} />;
      case 'Lab Tests':
        return <LabTestsDashboard />;
      case 'Reports':
        return <Reports />;
      case 'Dashboard':
        return (
          <>
            <div className="dashboard-stats-grid">
              {dashboardData.stats.map((item, index) => (
                <div className="stat-card" key={index} style={{ borderLeft: `5px solid ${item.color}` }}>
                  <div className="stat-icon-wrapper" style={{ backgroundColor: item.iconBg, color: item.color }}>
                    {item.icon}
                  </div>
                  <div className="stat-info">
                    <p className="stat-title">{item.title}</p>
                    <h3 className="stat-count">{item.count}</h3>
                    {item.percentage && <p className="stat-percentage" style={{ color: item.color }}>{item.percentage}</p>}
                  </div>
                </div>
              ))}
            </div>

            <div className="dashboard-sections-grid">
              <div className="section-card">
                <h3 className="section-title"><FaChartLine /> Weekly Appointments Trend</h3>
                <div className="chart-container">
                  <Line 
                    data={{
                      labels: appointmentsData.map(item => item.day),
                      datasets: [{
                        label: 'Appointments',
                        data: appointmentsData.map(item => item.appointments),
                        backgroundColor: 'rgba(99, 102, 241, 0.2)',
                        borderColor: 'rgba(99, 102, 241, 1)',
                        borderWidth: 3,
                        tension: 0.3,
                        fill: true,
                        pointBackgroundColor: 'rgba(255, 255, 255, 1)',
                        pointBorderColor: 'rgba(99, 102, 241, 1)',
                        pointRadius: 5,
                        pointHoverRadius: 7,
                        pointBorderWidth: 2
                      }]
                    }}
                    options={{
                      responsive: true,
                      maintainAspectRatio: false,
                      plugins: {
                        legend: { display: false },
                        tooltip: {
                          backgroundColor: 'rgba(17, 24, 39, 0.9)',
                          titleColor: '#fff',
                          bodyColor: '#fff',
                          borderColor: 'rgba(99, 102, 241, 1)',
                          borderWidth: 1,
                          padding: 12,
                          callbacks: {
                            label: function(context) {
                              return `Appointments: ${context.raw}`;
                            }
                          }
                        }
                      },
                      scales: {
                        y: {
                          beginAtZero: true,
                          grid: {
                            color: 'rgba(229, 231, 235, 0.5)'
                          },
                          ticks: {
                            color: 'rgba(107, 114, 128, 1)'
                          }
                        },
                        x: {
                          grid: {
                            display: false
                          },
                          ticks: {
                            color: 'rgba(107, 114, 128, 1)'
                          }
                        }
                      }
                    }}
                  />
                </div>
              </div>

              <div className="section-card">
                <h3 className="section-title">Department Status</h3>
                <ul className="department-list">
                  {dashboardData.departmentStatus.map((dept, index) => (
                    <li key={index} className="department-item">
                      <div className="department-details">
                        <span className="department-name">{dept.name}</span>
                        <span className="department-patients">{dept.patients} active patients</span>
                      </div>
                      <span className={`department-status-badge ${dept.status.toLowerCase()}`}>
                        {dept.status}
                      </span>
                    </li>
                  ))}
                </ul>
              </div>
            </div>
          </>
        );
      default:
        return (
          <div className="coming-soon">
            <h2>{activeMenuItem} Section</h2>
            <p>This section is under development and will be available soon.</p>
          </div>
        );
    }
  };

  return (
    <div className="app-layout">
      <aside className="sidebar">
        <div className="sidebar-header">
          <img src="https://placehold.co/40x40/6366F1/FFFFFF?text=MC" alt="MediCare Logo" className="sidebar-logo" />
          <span className="sidebar-app-name">MediCare</span>
          <span className="sidebar-system-name">Hospital System</span>
        </div>
        <nav className="sidebar-nav">
          <ul>
            {sidebarNavItems.map((item) => (
              <li 
                key={item.name} 
                className={activeMenuItem === item.name ? 'active' : ''} 
                onClick={() => setActiveMenuItem(item.name)}
              >
                {item.icon}
                <span>{item.label}</span>
              </li>
            ))}
          </ul>
        </nav>
        <div className="sidebar-footer" onClick={handleLogout}>
          <FaSignOutAlt />
          <span>Logout</span>
        </div>
      </aside>

      <div className="main-content-area">
        <header className="main-header">
          <h1 className="header-title">{activeMenuItem}</h1>
          <p className="header-date">{dashboardData.date}</p>
          <div className="header-right">
            <div className="search-bar">
              <FaSearch className="search-icon" />
              <input type="text" placeholder="Search..." />
            </div>
            <div className="user-profile">
              <img
                src={`https://placehold.co/40x40/8B5CF6/FFFFFF?text=${userData.name ? userData.name.charAt(0).toUpperCase() : 'U'}`}
                alt={userData.name || "User"}
                className="user-avatar"
              />
              <div className="user-info">
                <span className="user-name">{userData.name || 'User'}</span>
                <span className="user-role">{userData.role || 'Role'}</span>
              </div>
            </div>
          </div>
        </header>

        <div className="dashboard-content">
          {renderContent()}
        </div>
      </div>
    </div>
  );
};

export default Dashboard;