import "./load_honeypot.css"
import React, { useState, useCallback } from "react";
import Button from '@mui/material/Button';
import Sidebar from "../../components/sidebar/sidebar"
import Navbar from "../../components/navbar/navbar"
import {useDropzone} from 'react-dropzone';
import { Store } from 'react-notifications-component';
import 'react-notifications-component/dist/theme.css'
// components
import config from "../../config.json"

const axios = require('axios');

function uploadHoneyPotFiles(files, updateFiles) {
    let formData = new FormData();
    formData.append("training_data", files[0])

    axios.post(`${config.SERVER_URL}/upload_honeypot_files`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    }).then(res => {
      if(res.status === 200 && res.data.message === "Upload Successful") {
          //alert("HoneyPot Data Uploaded")
          Store.addNotification({
            title: "Success",
            message: "HoneyPot Data Uploaded!",
            type: "success",
            insert: "top",
            container: "top-right",
            animationIn: ["animate__animated", "animate__fadeIn"],
            animationOut: ["animate__animated", "animate__fadeOut"],
            dismiss: {
            duration: 2000,
            onScreen: true
            }
        });
        // Wipe the files uploaded
        updateFiles([])
      } else {
          //alert(res.data.message)
          Store.addNotification({
            title: "Error",
            message: "HoneyPot Data Upload failed!",
            type: "danger",
            insert: "top",
            container: "top-right",
            animationIn: ["animate__animated", "animate__fadeIn"],
            animationOut: ["animate__animated", "animate__fadeOut"],
            dismiss: {
            duration: 2000,
            onScreen: true
            }
        });
      }
    })
}

function DragDropFile(props) {
  const onDrop = useCallback(files => {
      props.updateAcceptedFiles(files);
  }, []);


  const {
      getRootProps, //returns an object of the properties needed on the root element
      getInputProps, //returns an object of the properties needed on the input element
      isDragActive, //true if a file is dragged over the dropzone area
      isDragAccept, //true if a file is dragged over the dropzone area and included in acceptable file types
      isDragReject, // true if a file is dragged over the dropzone area and not included in acceptable file types
  } = useDropzone({            
      maxFiles: 1,
      onDrop,
      // accept: {
      //     'multipart/form-data': [],
      // }
      }); 

  //file path
  const files = props.files.map(file => (
      <li key={file.path}>
        {file.path} - {file.size} bytes
      </li>
  ));

  if (files.length) {
      return (
          <div className="test">
              <div {...getRootProps({className: `dropzone ${isDragAccept && 'dropzoneAccept'} ${isDragReject && 'dropzoneReject'}`,})}>
                  <input {...getInputProps()} />
                  {isDragActive ? (
                      <p>Drop the files here ...</p>) : (
                      <p>Drag 'n' drop some files here, or click to select files</p>)
                  }
              </div>
              <aside>
                  <h4>File - File size</h4>
                  <ul>{files}</ul>
              </aside>
          </div>
      );
  } else {
      return (
          <div className="test">
              <div {...getRootProps({className: `dropzone ${isDragAccept && 'dropzoneAccept'} ${isDragReject && 'dropzoneReject'}`,})}>
                  <input {...getInputProps()} />
                  {isDragActive ? (
                      <p>Drop the files here ...</p>) : (
                      <p>Drag 'n' drop some files here, or click to select files</p>)
                  }
              </div>
          </div>
      );
  }
};

export default function HoneyPot() {  
  // local
  var [acceptedFiles, setAcceptedFiles] = useState([]);

  return (
    <div className="honeypot">
          <Sidebar/>
          <div className="container">
              <Navbar/>
              <DragDropFile files={acceptedFiles} updateAcceptedFiles={setAcceptedFiles}/>
                  <Button
                      variant="contained"
                      size="medium"
                      color="secondary"
                      onClick={() => {
                          uploadHoneyPotFiles(acceptedFiles, setAcceptedFiles);
                      }}
                      disabled={acceptedFiles.length == 0}>
                          Deploy Honeypot Files
                  </Button>
          </div>
      </div>
  );
}