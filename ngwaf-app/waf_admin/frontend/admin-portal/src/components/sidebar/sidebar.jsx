import React from 'react'
import "./sidebar.css"
import DashboardOutlinedIcon from '@mui/icons-material/DashboardOutlined';
import StorageOutlinedIcon from '@mui/icons-material/StorageOutlined';
import ImportExportOutlinedIcon from '@mui/icons-material/ImportExportOutlined';
import PersonalVideoOutlinedIcon from '@mui/icons-material/PersonalVideoOutlined';
import FileUploadOutlinedIcon from '@mui/icons-material/FileUploadOutlined';
import WorkOutlineOutlinedIcon from '@mui/icons-material/WorkOutlineOutlined';
import SettingsOutlinedIcon from '@mui/icons-material/SettingsOutlined';
import { Link } from "react-router-dom";
import { useContext } from "react";
import { DarkModeContext } from "../../context/darkModeContext";

const Sidebar = () => {
  const { dispatch } = useContext(DarkModeContext);
  return (
    <div className="sidebar">
      <div className="top">
        <Link to="/dashboard" style={{ textDecoration: "none" }}>
          <span className="logo">NGWAF</span>
        </Link>
      </div>
      <hr />
      <div className="center">
        <ul>
          <p className="title">MAIN</p>
          <Link to="/dashboard" style={{ textDecoration: "none" }}>
          <li>
            <DashboardOutlinedIcon className="icon" />
            <span>Dashboard</span>
          </li>
          </Link>
          <p className="title">Data</p>
          <Link to="/import_data" style={{ textDecoration: "none" }}>
            <li>
              <ImportExportOutlinedIcon className="icon" />
              <span>Import Data</span>
            </li>
          </Link>
          <Link to="/manage_data" style={{ textDecoration: "none" }}>
            <li>
              <StorageOutlinedIcon className="icon" />
              <span>Manage Data</span>
            </li>
          </Link>
          <p className="title">Model</p>
          <Link to="/manage_model" style={{ textDecoration: "none" }}>
            <li>
              <PersonalVideoOutlinedIcon className="icon" />
              <span>Manage Model</span>
            </li>
          </Link>
          <Link to="/honey_pot" style={{ textDecoration: "none" }}>
            <li>
              <FileUploadOutlinedIcon className="icon" />
              <span>Load Honeypot</span>
            </li>
          </Link>
          <p className="title">Others</p>
          <Link to="/jobs" style={{ textDecoration: "none" }}>
            <li>
              <WorkOutlineOutlinedIcon className="icon" />
              <span>Jobs</span>
            </li>
          </Link>
          <Link to="/settings" style={{ textDecoration: "none" }}>
            <li>
              <SettingsOutlinedIcon className="icon" />
              <span>Settings</span>
            </li>
          </Link>
        </ul>
      </div>
      <div className="bottom">
        <div
          className="colorOption"
          onClick={() => dispatch({ type: "LIGHT" })}
        ></div>
        <div
          className="colorOption"
          onClick={() => dispatch({ type: "DARK" })}
        ></div>
      </div>
    </div>
  );
};

export default Sidebar