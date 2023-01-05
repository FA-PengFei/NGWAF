import React from 'react'
import "./navbar.css"
import SearchOutlinedIcon from '@mui/icons-material/SearchOutlined';
import LanguageOutlinedIcon from '@mui/icons-material/LanguageOutlined';
import NotificationsNoneOutlinedIcon from '@mui/icons-material/NotificationsNoneOutlined';
import NightsStayOutlinedIcon from '@mui/icons-material/NightsStayOutlined';
import { useContext } from "react";
import { DarkModeContext } from "../../context/darkModeContext";
import { Link } from "react-router-dom";
import { fileListLength } from '../../pages/jobs/job';

const Navbar = () => {
  const { dispatch } = useContext(DarkModeContext);

  return (
    <div className="navbar">
      <div className="wrapper">
        <div className="search">
          <input type="text" placeholder="Search..." />
          <SearchOutlinedIcon />
        </div>
        <div className="items">
          <div className="item">
            <LanguageOutlinedIcon className="icon" />
            English
          </div>
          <div className="item">
            <NightsStayOutlinedIcon
              className="icon"
              onClick={() => dispatch({ type: "TOGGLE" })}
            />
          </div>
          <Link to="/jobs" style={{ textDecoration: "none" }}>
            <div className="item">
              <NotificationsNoneOutlinedIcon className="icon" />
              <div className="counter">{fileListLength}</div>
            </div>
          </Link>
          <div className="item">
            <img
              src="https://pbs.twimg.com/profile_images/794107415876747264/g5fWe6Oh_400x400.jpg"
              alt=""
              className="avatar"
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default Navbar