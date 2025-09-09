import React, { useState, useEffect, useMemo } from 'react';
import { FaUserInjured, FaSearch, FaEdit, FaTrash, FaPlus, FaEye } from 'react-icons/fa';
import { patientAPI } from '../api';
import './Patients.css';

const Patients = ({ isPatient }) => {
  const [patients, setPatients] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [currentPatient, setCurrentPatient] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [showViewModal, setShowViewModal] = useState(false);
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    dateOfBirth: '',
    gender: 'Male',
    phoneNumber: '',
    email: '',
    address: '',
    emergencyContactName: '',
    emergencyContactPhone: ''
  });

  useEffect(() => {
    const fetchPatients = async () => {
      try {
        if (isPatient) {
          const response = await patientAPI.getMyProfile();
          setPatients([response.data]);
        } else {
          const response = await patientAPI.getAll();
          setPatients(response.data);
        }
      } catch (error) {
        console.error('Error fetching patients:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchPatients();
  }, [isPatient]);

  const filteredPatients = useMemo(() => {
    if (isPatient) return patients;
    
    if (!searchTerm.trim()) return patients;
    
    return patients.filter(patient => 
      patient.patientId.toString().includes(searchTerm) ||
      `${patient.firstName} ${patient.lastName}`.toLowerCase().includes(searchTerm.toLowerCase())
    );
  }, [patients, searchTerm, isPatient]);

  const handleSearch = (e) => {
    setSearchTerm(e.target.value);
  };

  const handleFormChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (currentPatient) {
        await patientAPI.update(currentPatient.patientId, formData);
      } else {
        await patientAPI.create(formData);
      }
      const response = isPatient ? await patientAPI.getMyProfile() : await patientAPI.getAll();
      setPatients(isPatient ? [response.data] : response.data);
      setShowForm(false);
    } catch (error) {
      console.error('Error saving patient:', error);
    }
  };

  const handleViewPatient = (patient) => {
    setCurrentPatient(patient);
    setShowViewModal(true);
  };

  const handleEditPatient = (patient) => {
    setCurrentPatient(patient);
    setFormData({
      firstName: patient.firstName,
      lastName: patient.lastName,
      dateOfBirth: patient.dateOfBirth,
      gender: patient.gender,
      phoneNumber: patient.phoneNumber,
      email: patient.email,
      address: patient.address,
      emergencyContactName: patient.emergencyContactName,
      emergencyContactPhone: patient.emergencyContactPhone
    });
    setShowForm(true);
  };

  const handleDeletePatient = async (id) => {
    if (window.confirm('Are you sure you want to delete this patient?')) {
      try {
        await patientAPI.delete(id);
        setPatients(prev => prev.filter(p => p.patientId !== id));
      } catch (error) {
        console.error('Delete failed:', error);
      }
    }
  };

  const handleAddPatient = () => {
    setCurrentPatient(null);
    setFormData({
      firstName: '',
      lastName: '',
      dateOfBirth: '',
      gender: 'Male',
      phoneNumber: '',
      email: '',
      address: '',
      emergencyContactName: '',
      emergencyContactPhone: ''
    });
    setShowForm(true);
  };

  if (loading) {
    return <div className="loading">Loading patient data...</div>;
  }

  return (
    <div className="patients-container">
      <div className="patients-header">
        <h2><FaUserInjured /> {isPatient ? 'My Profile' : 'Patients Management'}</h2>
        
        {!isPatient && (
          <div className="controls-section">
            <div className="search-bar">
              <FaSearch className="search-icon" />
              <input
                type="text"
                placeholder="Search by ID or name..."
                value={searchTerm}
                onChange={handleSearch}
              />
            </div>
            
            <button 
              className="add-patient-btn"
              onClick={handleAddPatient}
            >
              <FaPlus /> Add New Patient
            </button>
          </div>
        )}
      </div>

      {isPatient && patients.length > 0 ? (
        <div className="patient-profile">
          <div className="profile-header">
            <div className="avatar">
              {patients[0].firstName.charAt(0)}{patients[0].lastName.charAt(0)}
            </div>
            <div>
              <h3>{patients[0].firstName} {patients[0].lastName}</h3>
              <p>Patient ID: {patients[0].patientId}</p>
            </div>
          </div>

          <div className="profile-details">
            <div className="detail-row">
              <span className="detail-label">Date of Birth:</span>
              <span className="detail-value">{patients[0].dateOfBirth}</span>
            </div>
            <div className="detail-row">
              <span className="detail-label">Gender:</span>
              <span className="detail-value">{patients[0].gender}</span>
            </div>
            <div className="detail-row">
              <span className="detail-label">Phone:</span>
              <span className="detail-value">{patients[0].phoneNumber}</span>
            </div>
            <div className="detail-row">
              <span className="detail-label">Email:</span>
              <span className="detail-value">{patients[0].email || 'N/A'}</span>
            </div>
            <div className="detail-row">
              <span className="detail-label">Address:</span>
              <span className="detail-value">{patients[0].address || 'N/A'}</span>
            </div>
            <div className="detail-row">
              <span className="detail-label">Emergency Contact:</span>
              <span className="detail-value">
                {patients[0].emergencyContactName || 'N/A'} - {patients[0].emergencyContactPhone || 'N/A'}
              </span>
            </div>
          </div>

          <button 
            className="edit-profile-btn"
            onClick={() => handleEditPatient(patients[0])}
          >
            <FaEdit /> Edit Profile
          </button>
        </div>
      ) : (
        <div className="patients-table-container">
          <table className="patients-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Date of Birth</th>
                <th>Gender</th>
                <th>Phone</th>
                <th>Email</th>
                {!isPatient && <th>Actions</th>}
              </tr>
            </thead>
            <tbody>
              {filteredPatients.length > 0 ? (
                filteredPatients.map(patient => (
                  <tr key={patient.patientId}>
                    <td>{patient.patientId}</td>
                    <td>{patient.firstName} {patient.lastName}</td>
                    <td>{patient.dateOfBirth}</td>
                    <td>{patient.gender}</td>
                    <td>{patient.phoneNumber}</td>
                    <td>{patient.email || 'N/A'}</td>
                    {!isPatient && (
                      <td className="actions-cell">
                        <button 
                          className="action-btn view-btn"
                          onClick={() => handleViewPatient(patient)}
                        >
                          <FaEye /> View
                        </button>
                        <button 
                          className="action-btn edit-btn"
                          onClick={() => handleEditPatient(patient)}
                        >
                          <FaEdit /> Edit
                        </button>
                        <button 
                          className="action-btn delete-btn"
                          onClick={() => handleDeletePatient(patient.patientId)}
                        >
                          <FaTrash /> Delete
                        </button>
                      </td>
                    )}
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={isPatient ? 6 : 7} className="no-results">
                    {patients.length === 0 ? 'No patients found' : 'No matching patients found'}
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      )}

      {showForm && (
        <div className="form-modal-overlay">
          <div className="form-modal-content">
            <h3>{currentPatient ? (isPatient ? 'Edit My Profile' : 'Edit Patient') : 'Add New Patient'}</h3>
            
            <form onSubmit={handleSubmit}>
              <div className="form-row">
                <div className="form-group">
                  <label>First Name:</label>
                  <input
                    type="text"
                    name="firstName"
                    value={formData.firstName}
                    onChange={handleFormChange}
                    required
                  />
                </div>
                <div className="form-group">
                  <label>Last Name:</label>
                  <input
                    type="text"
                    name="lastName"
                    value={formData.lastName}
                    onChange={handleFormChange}
                    required
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Date of Birth:</label>
                  <input
                    type="date"
                    name="dateOfBirth"
                    value={formData.dateOfBirth}
                    onChange={handleFormChange}
                    required
                  />
                </div>
                <div className="form-group">
                  <label>Gender:</label>
                  <select
                    name="gender"
                    value={formData.gender}
                    onChange={handleFormChange}
                  >
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                  </select>
                </div>
              </div>

              <div className="form-group">
                <label>Phone:</label>
                <input
                  type="tel"
                  name="phoneNumber"
                  value={formData.phoneNumber}
                  onChange={handleFormChange}
                  required
                />
              </div>

              <div className="form-group">
                <label>Email:</label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleFormChange}
                />
              </div>

              <div className="form-group">
                <label>Address:</label>
                <input
                  type="text"
                  name="address"
                  value={formData.address}
                  onChange={handleFormChange}
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Emergency Contact Name:</label>
                  <input
                    type="text"
                    name="emergencyContactName"
                    value={formData.emergencyContactName}
                    onChange={handleFormChange}
                  />
                </div>
                <div className="form-group">
                  <label>Emergency Contact Phone:</label>
                  <input
                    type="tel"
                    name="emergencyContactPhone"
                    value={formData.emergencyContactPhone}
                    onChange={handleFormChange}
                  />
                </div>
              </div>

              <div className="form-actions">
                <button type="submit" className="save-button">
                  {currentPatient ? 'Update' : 'Save'}
                </button>
                <button 
                  type="button"
                  className="cancel-button"
                  onClick={() => setShowForm(false)}
                >
                  Cancel
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {showViewModal && currentPatient && (
        <div className="form-modal-overlay">
          <div className="form-modal-content">
            <h3>{isPatient ? 'My Profile Details' : 'Patient Details'}</h3>
            <div className="patient-details">
              <div className="detail-row">
                <span className="detail-label">ID:</span>
                <span className="detail-value">{currentPatient.patientId}</span>
              </div>
              <div className="detail-row">
                <span className="detail-label">Full Name:</span>
                <span className="detail-value">{currentPatient.firstName} {currentPatient.lastName}</span>
              </div>
              <div className="detail-row">
                <span className="detail-label">Date of Birth:</span>
                <span className="detail-value">{currentPatient.dateOfBirth}</span>
              </div>
              <div className="detail-row">
                <span className="detail-label">Gender:</span>
                <span className="detail-value">{currentPatient.gender}</span>
              </div>
              <div className="detail-row">
                <span className="detail-label">Phone:</span>
                <span className="detail-value">{currentPatient.phoneNumber}</span>
              </div>
              <div className="detail-row">
                <span className="detail-label">Email:</span>
                <span className="detail-value">{currentPatient.email || 'N/A'}</span>
              </div>
              <div className="detail-row">
                <span className="detail-label">Address:</span>
                <span className="detail-value">{currentPatient.address || 'N/A'}</span>
              </div>
              <div className="detail-row">
                <span className="detail-label">Emergency Contact:</span>
                <span className="detail-value">
                  {currentPatient.emergencyContactName || 'N/A'} - {currentPatient.emergencyContactPhone || 'N/A'}
                </span>
              </div>
            </div>
            <button 
              className="close-button"
              onClick={() => setShowViewModal(false)}
            >
              Close
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default Patients;