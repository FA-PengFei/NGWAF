import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import { DarkModeContextProvider } from './context/darkModeContext';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <DarkModeContextProvider>
    <App />
  </DarkModeContextProvider>
);