// App.js
import React, { useState } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Login from './components/Login';
import Dashboard from './components/Dashboard';

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const handleLoginSuccess = () => {
    setIsLoggedIn(true);
  };

  return (
    <Routes>
      <Route
        path="/Login"
        element={
          isLoggedIn ? <Navigate to="/Dashboard" /> : <Login onLoginSuccess={handleLoginSuccess} />
        }
      />
      <Route
        path="/dashboard"
        element={
          isLoggedIn ? <Dashboard /> : <Navigate to="/Login" />
        }
      />
      <Route path="*" element={<Navigate to="/Login" />} />
    </Routes>
  );
}

export default App;
