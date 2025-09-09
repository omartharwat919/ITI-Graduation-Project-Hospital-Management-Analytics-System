import React, { useState, useEffect } from 'react';
import { 
  FaFlask, FaSearch, FaArrowRight, FaExclamationTriangle,
  FaCheckCircle, FaExclamationCircle, FaVial, FaSyringe,
  FaMicroscope, FaHeartbeat, FaFileMedicalAlt
} from 'react-icons/fa';
import { labResultAPI } from '../api';
import './LabTestsDashboard.css';

const LabTestsDashboard = () => {
  const [visitId, setVisitId] = useState('');
  const [labResults, setLabResults] = useState([]);
  const [groupedResults, setGroupedResults] = useState({});
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (labResults.length > 0) {
      const grouped = labResults.reduce((acc, result) => {
        if (!acc[result.testName]) {
          acc[result.testName] = [];
        }
        acc[result.testName].push(result);
        return acc;
      }, {});
      setGroupedResults(grouped);
    }
  }, [labResults]);

  const fetchLabResults = async (id) => {
    if (!id) return;
    
    try {
      setIsLoading(true);
      setError(null);
      const response = await labResultAPI.getByVisitId(id);
      
      if (response.data && response.data.length > 0) {
        setLabResults(response.data);
      } else {
        setError('No lab results found for this Visit ID');
        setLabResults([]);
      }
    } catch (err) {
      let errorMessage = 'Failed to fetch lab results';
      
      if (err.response) {
        switch (err.response.status) {
          case 400:
            errorMessage = 'Invalid Visit ID format';
            break;
          case 404:
            errorMessage = 'No results found for this Visit ID';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later';
            break;
          default:
            errorMessage = `Error: ${err.response.status}`;
        }
      } else if (err.request) {
        errorMessage = 'Network error. Please check your connection';
      } else {
        errorMessage = 'An unexpected error occurred';
      }
      
      setError(errorMessage);
      setLabResults([]);
      console.error('Error details:', err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSearch = (e) => {
    e.preventDefault();
    
    if (!visitId.trim()) {
      setError('Please enter a Visit ID');
      return;
    }
    
    if (!/^\d+$/.test(visitId)) {
      setError('Visit ID should contain only numbers');
      return;
    }
    
    fetchLabResults(visitId);
  };

  const getTestStatus = (value, normalRange) => {
    if (!value || !normalRange) return 'unknown';
    
    const rangeMatch = normalRange.match(/(\d+\.?\d*)\s*-\s*(\d+\.?\d*)/);
    if (!rangeMatch) return 'unknown';
    
    const [, minStr, maxStr] = rangeMatch;
    const min = parseFloat(minStr);
    const max = parseFloat(maxStr);
    const numericValue = parseFloat(value);
    
    if (isNaN(numericValue) || isNaN(min) || isNaN(max)) return 'unknown';
    
    if (numericValue >= min && numericValue <= max) return 'normal';
    if (numericValue < min) return 'low';
    return 'high';
  };

  const getTestIcon = (testName) => {
    switch(testName.toLowerCase()) {
      case 'blood glucose':
        return <FaHeartbeat className="test-icon glucose" />;
      case 'kidney function test':
        return <FaFileMedicalAlt className="test-icon kidney" />;
      case 'coagulation profile':
        return <FaSyringe className="test-icon coagulation" />;
      default:
        return <FaFlask className="test-icon default" />;
    }
  };

  const renderTestCard = (testName, testResults) => {
    return (
      <div key={testName} className="test-card">
        <div className="test-header">
          <div className="test-icon-container">
            {getTestIcon(testName)}
          </div>
          <h3>{testName}</h3>
        </div>
        
        <div className="test-attributes">
          {testResults.map((result, index) => {
            const status = getTestStatus(result.attributeValue, result.normalRange);
            return (
              <div key={index} className={`attribute-row ${status}`}>
                <div className="attribute-name">
                  {result.attributeName}
                </div>
                <div className="attribute-value">
                  {result.attributeValue}
                </div>
                <div className="attribute-range">
                  {result.normalRange}
                </div>
                <div className="attribute-status">
                  {status === 'normal' ? (
                    <FaCheckCircle className="status-icon normal" />
                  ) : (
                    <FaExclamationCircle className={`status-icon ${status}`} />
                  )}
                  <span className="status-text">
                    {status === 'normal' ? 'Normal' : status === 'low' ? 'Low' : 'High'}
                  </span>
                </div>
              </div>
            );
          })}
        </div>
        
        <div className="test-footer">
          <span className="test-date">
            {new Date(testResults[0].resultDate).toLocaleDateString()}
          </span>
        </div>
      </div>
    );
  };

  return (
    <div className="lab-tests-dashboard">
      <div className="dashboard-header">
        <h1>
          <FaFlask /> Laboratory Tests
        </h1>
      </div>

      <form onSubmit={handleSearch} className="search-form">
        <div className="search-container">
          <FaSearch className="search-icon" />
          <input
            type="text"
            placeholder="Enter Visit ID..."
            value={visitId}
            onChange={(e) => {
              setVisitId(e.target.value);
              if (error) setError(null);
            }}
            required
            pattern="\d*"
            title="Please enter numbers only"
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
          <p>Loading lab results...</p>
        </div>
      ) : error ? (
        <div className="error-state">
          <FaExclamationTriangle className="error-icon" />
          <p>{error}</p>
          {error.includes('Server error') && (
            <p className="error-hint">Please contact support if the problem persists</p>
          )}
          <button 
            onClick={() => fetchLabResults(visitId)} 
            className="retry-button"
            disabled={isLoading}
          >
            {isLoading ? 'Retrying...' : 'Try Again'}
          </button>
        </div>
      ) : labResults.length > 0 ? (
        <div className="tests-grid">
          {Object.entries(groupedResults).map(([testName, testResults]) => 
            renderTestCard(testName, testResults)
          )}
        </div>
      ) : (
        <div className="empty-state">
          <p>Enter a Visit ID to view lab results</p>
        </div>
      )}
    </div>
  );
};

export default LabTestsDashboard;