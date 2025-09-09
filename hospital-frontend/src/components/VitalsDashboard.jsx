import React, { useState, useEffect } from 'react';
import { 
  FaHeartbeat, FaThermometerHalf, FaTint, 
  FaHeart, FaLungs, FaProcedures,
  FaSearch, FaArrowRight, FaExclamationTriangle
} from 'react-icons/fa';
import { vitalAPI } from '../api';
import './VitalsDashboard.css';

const VitalsDashboard = () => {
  const [visitId, setVisitId] = useState('');
  const [vitals, setVitals] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchVitals = async (id) => {
    if (!id) return;
    
    try {
      setIsLoading(true);
      setError(null);
      const response = await vitalAPI.getByVisitId(id);
      setVitals(response.data);
    } catch (err) {
      setError('No vitals found for this Visit ID');
      setVitals(null);
      console.error('Error fetching vitals:', err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSearch = (e) => {
    e.preventDefault();
    fetchVitals(visitId);
  };

  const getStatusLevel = (value, normalRange) => {
    if (value === null || value === undefined) return 'unknown';
    if (value >= normalRange.min && value <= normalRange.max) return 'normal';
    if (value < normalRange.min) return 'low';
    return 'high';
  };

  const renderVitalCard = (icon, title, value, unit, normalRange, severityLevels = {}) => {
    if (value === null || value === undefined) return null;

    const status = getStatusLevel(value, normalRange);
    const severity = severityLevels[status] || 'info';
    
    return (
      <div className="vital-card">
        <div className={`vital-icon-container ${severity}`}>
          <div className="vital-icon">
            {icon}
          </div>
        </div>
        <div className="vital-content">
          <h3>{title}</h3>
          <div className="vital-value">
            {value} {unit}
          </div>
          <div className={`vital-status ${severity}`}>
            {status === 'normal' ? (
              <span className="status-indicator normal">Within Normal Range</span>
            ) : (
              <span className={`status-indicator ${status}`}>
                {status === 'low' ? 'Below Normal' : 'Above Normal'}
              </span>
            )}
          </div>
          <div className="vital-range">
            Normal range: {normalRange.min}-{normalRange.max}{unit}
          </div>
        </div>
      </div>
    );
  };

  return (
    <div className="vitals-dashboard">
      <div className="dashboard-header">
        <h1>
          <FaHeartbeat /> Patient Vitals Dashboard
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
          <p>Loading patient vitals...</p>
        </div>
      ) : error ? (
        <div className="error-state">
          <FaExclamationTriangle className="error-icon" />
          <p>{error}</p>
          <button 
            onClick={() => fetchVitals(visitId)} 
            className="retry-button"
          >
            Try Again
          </button>
        </div>
      ) : vitals ? (
        <div className="vitals-container">
          <div className="vitals-grid">
            {renderVitalCard(
              <FaThermometerHalf />,
              "Body Temperature",
              vitals.bodyTemperature,
              "°C",
              { min: 36.1, max: 37.2 },
              { high: 'warning', low: 'warning' }
            )}

            {renderVitalCard(
              <FaTint />,
              "Blood Pressure",
              `${vitals.bloodPressureSystolic}/${vitals.bloodPressureDiastolic}`,
              "mmHg",
              { min: 90, max: 120 }, // Using systolic for status
              { high: 'danger', low: 'danger' }
            )}

            {renderVitalCard(
              <FaHeart />,
              "Heart Rate",
              vitals.heartRate,
              "bpm",
              { min: 60, max: 100 },
              { high: 'danger', low: 'warning' }
            )}

            {renderVitalCard(
              <FaLungs />,
              "Respiratory Rate",
              vitals.respiratoryRate,
              "breaths/min",
              { min: 12, max: 20 },
              { high: 'danger', low: 'danger' }
            )}

            {renderVitalCard(
              <FaProcedures />,
              "Blood Oxygen",
              vitals.bloodOxygenLevel,
              "%",
              { min: 95, max: 100 },
              { low: 'danger' }
            )}

            {vitals.bloodType && (
              <div className="vital-card">
                <div className="vital-icon-container info">
                  <div className="vital-icon">
                    <FaTint />
                  </div>
                </div>
                <div className="vital-content">
                  <h3>Blood Type</h3>
                  <div className="vital-value">
                    {vitals.bloodType}
                  </div>
                  <div className="vital-status info">
                    <span className="status-indicator">Recorded</span>
                  </div>
                </div>
              </div>
            )}
          </div>

          <div className="vitals-summary">
            <h3>Vitals Summary</h3>
            <div className="status-legend">
              <div className="legend-item normal">
                <span className="legend-color"></span>
                <span>Normal</span>
              </div>
              <div className="legend-item warning">
                <span className="legend-color"></span>
                <span>Caution</span>
              </div>
              <div className="legend-item danger">
                <span className="legend-color"></span>
                <span>Critical</span>
              </div>
            </div>
          </div>
        </div>
      ) : (
        <div className="empty-state">
          <p>Enter a Visit ID to view patient vitals</p>
        </div>
      )}
    </div>
  );
};

export default VitalsDashboard;