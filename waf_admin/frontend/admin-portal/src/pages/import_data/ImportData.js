import React, { useState, useMemo } from "react";
import { Button, Grid } from "@material-ui/core";
import { useTheme } from "@material-ui/styles";

import {useDropzone} from 'react-dropzone';

// components
import PageTitle from "../../components/PageTitle/PageTitle";

import config from "../../config.json"

const axios = require('axios');

const baseStyle = {
  flex: 1,
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
  padding: '20px',
  borderWidth: 2,
  borderRadius: 2,
  borderColor: '#eeeeee',
  borderStyle: 'dashed',
  backgroundColor: '#fafafa',
  color: '#bdbdbd',
  outline: 'none',
  transition: 'border .24s ease-in-out'
};

const activeStyle = {
  borderColor: '#2196f3'
};

const acceptStyle = {
  borderColor: '#00e676'
};

const rejectStyle = {
  borderColor: '#ff1744'
};

function uploadTrainingData(files, updateFiles) {
  let formData = new FormData();
  formData.append("training_data", files[0])

  axios.post(`${config.SERVER_URL}/upload_train_data`, formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  }).then(res => {
    if(res.status === 200 && res.data.message === "Upload Successful") {
      alert("Training Data Uploaded Successfully")

      // Wipe the files uploaded
      updateFiles([])
    } else {
      alert(res.data.message)
    }

  })

}

function StyledDropzone(props) {

  // live upacking of files
  const {
    acceptedFiles,
    getRootProps,
    getInputProps,
    isDragActive,
    isDragAccept,
    isDragReject
  } = useDropzone({accept: 'text/csv', maxFiles: 1, onDrop: files => props.updateAcceptedFiles(files)})

  const files = props.files.map(file => (
    <li key={file.path}>
      {file.path} - {file.size} bytes
    </li>
  ));

  const style = useMemo(() => ({
    ...baseStyle,
    ...(isDragActive ? activeStyle : {}),
    ...(isDragAccept ? acceptStyle : {}),
    ...(isDragReject ? rejectStyle : {})
  }), [
    isDragActive,
    isDragReject,
    isDragAccept
  ]);

  if (files.length == 0) {
    return(
      <div className="container">
      <div {...getRootProps({style})}>
        <input {...getInputProps()} />
        <p>Drag and drop your .csv file here</p>
      </div>
    </div>
    )
  } else {
    return (
      <div className="container">
      <div {...getRootProps({style})}>
        <input {...getInputProps()} />
        <p>Drag and drop your .csv file here</p>
      </div>
      <aside>
        <h4>Files</h4>
        <ul>{files}</ul>
      </aside>
    </div>
    )
  }
}

export default function ImportData(props) {
    var theme = useTheme();
  
    // local
    var [acceptedFiles, setAcceptedFiles] = useState([]);

    return (
    <>
      <PageTitle title="Upload Training Data"/>
      <Grid container spacing={4}>
        <Grid item xs={12} md={6}>

        </Grid>
        <Grid item xs={12} md={12}>
          <StyledDropzone files={acceptedFiles} updateAcceptedFiles={setAcceptedFiles}/>
        </Grid>
        <Grid item xs={12} md={8}>

        </Grid>
        <Grid item xs={12} md={12}>
          <Button
            variant="contained"
            size="medium"
            color="secondary"
            onClick={() => uploadTrainingData(acceptedFiles, setAcceptedFiles)}
            disabled={acceptedFiles.length == 0}
          >
            Upload Data
          </Button>
        </Grid>
      </Grid>
    </>
    );
  }