import Dashboard from './pages/dashboard/dashboard';
import { ReactNotifications } from 'react-notifications-component'

import React from "react";
import { 
  BrowserRouter, Routes, Route 
} from "react-router-dom";

import ImportData from './pages/import_data/import_data';
import ManageData from './pages/manage_data/manage_data';
import ManageModel from './pages/manage_model/manage_model';
import HoneyPot from './pages/load_honeypot/load_honeypot';
import Jobs from "./pages/jobs/job";
import Settings from "./pages/settings/settings"

import "./style/dark.css";
import { useContext } from 'react';
import { DarkModeContext } from './context/darkModeContext';

function App() {
  const { darkMode } = useContext(DarkModeContext);
  return (
    <div className={darkMode ? "app dark" : "app"}>
      <ReactNotifications />
      <BrowserRouter>
        <Routes>
          <Route path="/">
            <Route index element={<Dashboard/>}/>
            <Route path="dashboard" element={<Dashboard/>}/>
            <Route path="import_data" element={<ImportData/>}/>
            <Route path="manage_data" element={<ManageData/>}/>
            <Route path="manage_model" element={<ManageModel/>}/>
            <Route path="honey_pot" element={<HoneyPot/>}/>
            <Route path="jobs" element={<Jobs/>}/>
            <Route path="settings" element={<Settings/>}/>
          </Route>
        </Routes>
      </BrowserRouter>
    </div>
  );
}
export default App;
