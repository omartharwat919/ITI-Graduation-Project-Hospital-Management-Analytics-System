import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Login.css';
import { loginUser } from '../api';
import hospitalLogo from '../14.png';
function Login({ onLoginSuccess }) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      const response = await loginUser({ username, password });
      const { token, user } = response.data;
      const userName = user?.username;    
      
      localStorage.setItem('token', token);
      localStorage.setItem('userName', username);

      onLoginSuccess(userName);
      navigate('/dashboard');
    } catch (err) {
      console.error('Login failed:', err);
      const message = err.response?.data?.message || 'Login failed. Please try again.';
      setError(message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-container">
      <div className="login-card">
        <div className="logo-container">
          <img
            src={hospitalLogo}
            alt="Hospital Logo"
            className="login-logo"
            onError={(e) => {
              console.error('Failed to load image:', e.target.src);
              e.target.style.display = 'none';
            }}
          />
        </div>
        <h2 className="login-title">Welcome to Hospital System</h2>
        <p className="login-subtitle">Please sign in to access your dashboard.</p>

        <form onSubmit={handleLogin} className="login-form">
          <div className="form-group">
            <label htmlFor="username">Username</label>
            <input
              type="text"
              id="username"
              placeholder="Enter your username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
            />
          </div>
          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input
              type="password"
              id="password"
              placeholder="Enter your password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>

          {error && <p className="error-message">{error}</p>}

          <button type="submit" className="login-button" disabled={loading}>
            {loading ? <span className="loading-spinner"></span> : 'Login'}
          </button>
        </form>

        <p className="forgot-password">Forgot your password?</p>
      </div>
    </div>
  );
}

export default Login;