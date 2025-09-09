import React, { useState, useEffect } from 'react';
import { 
  FaFileInvoiceDollar, FaMoneyBillWave, FaCreditCard, 
  FaSearch, FaChevronDown, FaChevronUp, 
  FaPrint, FaFileDownload, FaHistory
} from 'react-icons/fa';
import { billingAPI } from '../api';
import './BillingDashboard.css';

const BillingDashboard = ({ isPatient }) => {
  const [bills, setBills] = useState([]);
  const [selectedBill, setSelectedBill] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [searchTerm, setSearchTerm] = useState('');

  useEffect(() => {
    const fetchBills = async () => {
      try {
        setIsLoading(true);
        const response = isPatient 
          ? await billingAPI.getMyBills() 
          : await billingAPI.getAllBills();
        setBills(response.data);
      } catch (err) {
        setError('Failed to load billing data');
        console.error('Error fetching bills:', err);
      } finally {
        setIsLoading(false);
      }
    };

    fetchBills();
  }, [isPatient]);

  const filteredBills = bills.filter(bill => 
    bill.billId.toString().includes(searchTerm) ||
    bill.totalAmount.toString().includes(searchTerm)
  );

  const toggleBillDetails = (bill) => {
    setSelectedBill(selectedBill?.billId === bill.billId ? null : bill);
  };

  const renderPaymentMethodIcon = (method) => {
    switch(method.toLowerCase()) {
      case 'credit card':
        return <FaCreditCard className="payment-icon credit-card" />;
      case 'cash':
        return <FaMoneyBillWave className="payment-icon cash" />;
      case 'insurance':
        return <FaFileInvoiceDollar className="payment-icon insurance" />;
      default:
        return <FaMoneyBillWave className="payment-icon default" />;
    }
  };

  return (
    <div className="billing-dashboard">
      <div className="dashboard-header">
        <h1>
          <FaFileInvoiceDollar /> Billing Management
        </h1>
        <div className="header-actions">
          <button className="action-button print">
            <FaPrint /> Print Statements
          </button>
          <button className="action-button export">
            <FaFileDownload /> Export
          </button>
        </div>
      </div>

      <div className="search-container">
        <FaSearch className="search-icon" />
        <input
          type="text"
          placeholder="Search by Bill ID or Amount..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
      </div>

      {isLoading ? (
        <div className="loading-state">
          <div className="spinner"></div>
          <p>Loading billing data...</p>
        </div>
      ) : error ? (
        <div className="error-state">
          <p>{error}</p>
          <button 
            onClick={() => window.location.reload()} 
            className="retry-button"
          >
            Retry
          </button>
        </div>
      ) : filteredBills.length > 0 ? (
        <div className="bills-container">
          {filteredBills.map((bill) => (
            <div key={bill.billId} className="bill-card">
              <div 
                className="bill-summary"
                onClick={() => toggleBillDetails(bill)}
              >
                <div className="bill-id">Bill #{bill.billId}</div>
                <div className="bill-amounts">
                  <div className="amount-total">
                    <span className="label">Total:</span>
                    <span className="value">${bill.totalAmount.toFixed(2)}</span>
                  </div>
                  <div className="amount-paid">
                    <span className="label">Paid:</span>
                    <span className="value">${bill.totalPaid.toFixed(2)}</span>
                  </div>
                  <div className={`amount-outstanding ${bill.outstandingAmount > 0 ? 'unpaid' : 'paid'}`}>
                    <span className="label">Balance:</span>
                    <span className="value">${bill.outstandingAmount.toFixed(2)}</span>
                  </div>
                </div>
                <div className="bill-toggle">
                  {selectedBill?.billId === bill.billId ? <FaChevronUp /> : <FaChevronDown />}
                </div>
              </div>

              {selectedBill?.billId === bill.billId && (
                <div className="bill-details">
                  <div className="services-section">
                    <h3>
                      <FaFileInvoiceDollar /> Services
                    </h3>
                    <div className="services-list">
                      {bill.services.map((service, index) => (
                        <div key={index} className="service-item">
                          <div className="service-name">{service.serviceName}</div>
                          <div className="service-amount">${service.amount.toFixed(2)}</div>
                        </div>
                      ))}
                    </div>
                  </div>

                  <div className="payments-section">
                    <h3>
                      <FaHistory /> Payment History
                    </h3>
                    {bill.payments.length > 0 ? (
                      <div className="payments-list">
                        {bill.payments.map((payment, index) => (
                          <div key={index} className="payment-item">
                            <div className="payment-method">
                              {renderPaymentMethodIcon(payment.methodName)}
                              <span>{payment.methodName}</span>
                            </div>
                            <div className="payment-amount">${payment.amount.toFixed(2)}</div>
                            <div className="payment-date">
                              {new Date(payment.paymentDate).toLocaleDateString()}
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <p className="no-payments">No payment records found</p>
                    )}
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>
      ) : (
        <div className="empty-state">
          <p>No billing records found</p>
        </div>
      )}
    </div>
  );
};

export default BillingDashboard;