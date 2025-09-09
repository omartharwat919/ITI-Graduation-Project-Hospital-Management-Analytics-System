import React, { useState, useEffect } from 'react';
import { 
  FaFileMedical, FaSearch, FaUserInjured, FaCalendarAlt,
  FaHeartbeat, FaXRay, FaFlask, FaNotesMedical,
  FaAllergies, FaProcedures, FaClipboardCheck, FaRunning,
  FaArrowRight, FaExclamationTriangle
} from 'react-icons/fa';
import { medicalRecordAPI } from '../api';
import './MedicalRecords.css';

const MedicalRecords = () => {
  const [visitId, setVisitId] = useState('');
  const [medicalRecord, setMedicalRecord] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
  const [activeTab, setActiveTab] = useState('overview');

  const fetchMedicalRecord = async (id) => {
    if (!id) return;
    
    try {
      setIsLoading(true);
      setError(null);
      const response = await medicalRecordAPI.getByVisit(id);
      setMedicalRecord(response.data);
    } catch (err) {
      setError('No medical record found for this Visit ID');
      setMedicalRecord(null);
      console.error('Error fetching medical record:', err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSearch = (e) => {
    e.preventDefault();
    fetchMedicalRecord(visitId);
  };

  const renderOverviewTab = () => (
    <div className="dashboard-grid">
      <div className="dashboard-card diagnosis-card">
        <div className="card-header">
          <FaFileMedical className="card-icon" />
          <h3>Diagnosis</h3>
        </div>
        <div className="card-content">
          {medicalRecord.diagnosisSummary || 'No diagnosis recorded'}
        </div>
      </div>

      <div className="dashboard-card allergies-card">
        <div className="card-header">
          <FaAllergies className="card-icon" />
          <h3>Allergies</h3>
        </div>
        <div className="card-content">
          {medicalRecord.allergies || 'No allergies recorded'}
        </div>
      </div>

      <div className="dashboard-card conditions-card">
        <div className="card-header">
          <FaNotesMedical className="card-icon" />
          <h3>Chronic Conditions</h3>
        </div>
        <div className="card-content">
          {medicalRecord.chronicConditions || 'No chronic conditions'}
        </div>
      </div>

      <div className="dashboard-card health-card">
        <div className="card-header">
          <FaHeartbeat className="card-icon" />
          <h3>Health Status</h3>
        </div>
        <div className="card-content">
          {medicalRecord.generalHealthStatus || 'Not specified'}
        </div>
      </div>
    </div>
  );

  const renderDetailsTab = () => (
    <div className="details-section">
      <div className="detail-card">
        <div className="detail-header">
          <FaProcedures className="detail-icon" />
          <h4>Treatment Plan</h4>
        </div>
        <p>{medicalRecord.treatmentPlan || 'No treatment plan specified'}</p>
      </div>

      <div className="detail-card">
        <div className="detail-header">
          <FaClipboardCheck className="detail-icon" />
          <h4>Doctor's Notes</h4>
        </div>
        <p>{medicalRecord.doctorNotes || 'No notes recorded'}</p>
      </div>

      <div className="detail-card">
        <div className="detail-header">
          <FaRunning className="detail-icon" />
          <h4>Lifestyle Notes</h4>
        </div>
        <p>{medicalRecord.lifestyleNotes || 'No lifestyle recommendations'}</p>
      </div>

      <div className="detail-card">
        <div className="detail-header">
          <FaCalendarAlt className="detail-icon" />
          <h4>Follow-up</h4>
        </div>
        <div className={`follow-up-status ${medicalRecord.followUpRequired ? 'required' : 'not-required'}`}>
          {medicalRecord.followUpRequired ? 'Required' : 'Not Required'}
        </div>
      </div>
    </div>
  );

  const renderTestResultsTab = () => (
    <div className="test-results-section">
      <div className="test-card">
        <div className="test-header">
          <FaXRay className="test-icon" />
          <h4>Radiology Results</h4>
        </div>
        {medicalRecord.radiologySummary ? (
          <div className="test-content">
            {medicalRecord.radiologySummary.split(';').map((item, index) => (
              <p key={index}>{item.trim()}</p>
            ))}
          </div>
        ) : (
          <p>No radiology results available</p>
        )}
      </div>

      <div className="test-card">
        <div className="test-header">
          <FaFlask className="test-icon" />
          <h4>Lab Tests</h4>
        </div>
        <div className="test-content">
          {medicalRecord.testSummary || 'No lab test results available'}
        </div>
      </div>
    </div>
  );

  return (
    <div className="medical-dashboard">
      <div className="dashboard-header">
        <h1>
          <FaFileMedical /> Medical Record
        </h1>
      </div>

      <form onSubmit={handleSearch} className="search-form">
        <div className="search-container">
          <FaSearch className="search-icon" />
          <input
            type="text"
            placeholder="Enter Visit ID..."
            value={visitId}
            onChange={(e) => setVisitId(e.target.value)}
            required
          />
          <button 
            type="submit" 
            className="search-button"
            disabled={isLoading}
          >
            {isLoading ? 'Searching...' : <FaArrowRight />}
          </button>
        </div>
      </form>

      {isLoading ? (
        <div className="loading-state">
          <div className="spinner"></div>
          <p>Loading medical record...</p>
        </div>
      ) : error ? (
        <div className="error-state">
          <FaExclamationTriangle className="error-icon" />
          <p>{error}</p>
          <button 
            onClick={() => fetchMedicalRecord(visitId)} 
            className="retry-button"
          >
            Try Again
          </button>
        </div>
      ) : medicalRecord ? (
        <>
          <div className="visit-info">
            Visit ID: {visitId}
          </div>

          <div className="dashboard-tabs">
            <button
              className={`tab-button ${activeTab === 'overview' ? 'active' : ''}`}
              onClick={() => setActiveTab('overview')}
            >
              <FaUserInjured /> Overview
            </button>
            <button
              className={`tab-button ${activeTab === 'details' ? 'active' : ''}`}
              onClick={() => setActiveTab('details')}
            >
              <FaNotesMedical /> Details
            </button>
            <button
              className={`tab-button ${activeTab === 'tests' ? 'active' : ''}`}
              onClick={() => setActiveTab('tests')}
            >
              <FaFlask /> Test Results
            </button>
          </div>

          <div className="dashboard-content">
            {activeTab === 'overview' && renderOverviewTab()}
            {activeTab === 'details' && renderDetailsTab()}
            {activeTab === 'tests' && renderTestResultsTab()}
          </div>
        </>
      ) : (
        <div className="empty-state">
          <p>Enter a Visit ID to search for medical records</p>
        </div>
      )}
    </div>
  );
};

export default MedicalRecords;