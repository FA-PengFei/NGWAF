import "./import_data.css"
import Sidebar from "../../components/sidebar/sidebar"
import Navbar from "../../components/navbar/navbar"
import config from "../../config.json"
import {useDropzone} from 'react-dropzone';
import { useCallback } from "react";
import React, { useState } from "react";
import Papa from 'papaparse';
import { Store } from 'react-notifications-component';
import 'react-notifications-component/dist/theme.css'

const axios = require('axios');

function uploadTrainingData(files, updateFiles) {
    let formData = new FormData();
    formData.append("training_data", files[0])
    
    axios.post(`${config.SERVER_URL}/upload_train_data`, formData, {
        headers: {
        'Content-Type': 'multipart/form-data'
        }
    }).then(res => {
        if(res.status === 200 && res.data.message === "Upload Successful") {
            // Wipe the files uploaded
            Store.addNotification({
                title: "Success!",
                message: "File upload success!",
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
            updateFiles([])
        } else {
            Store.addNotification({
                title: "Error 404!",
                message: "File not uploaded successfully!",
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

    const [parsedCsvData, setParsedCsvData] = useState([]);

    const onDrop = useCallback(files => {
        props.updateAcceptedFiles(files);
        if (files.length) {
            parseFile(files[0]);
        }
    }, []);

    const parseFile = file => {
        Papa.parse(file, {
            header: true,
            complete: results => {
                setParsedCsvData(results.data)
            },
        });
    };

    const {
        getRootProps, //returns an object of the properties needed on the root element
        getInputProps, //returns an object of the properties needed on the input element
        isDragActive, //true if a file is dragged over the dropzone area
        isDragAccept, //true if a file is dragged over the dropzone area and included in acceptable file types
        isDragReject, // true if a file is dragged over the dropzone area and not included in acceptable file types
    } = useDropzone({            
        maxFiles: 1,
        onDrop,
        accept: {
            'text/csv': ['.csv'],
        }
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
                <div className="table">
                    <table>
                    <thead>
                        <tr>
                        <th>Payload</th>
                        <th>isMalicious</th>
                        </tr>
                    </thead>
                    <tbody>
                    {parsedCsvData &&
                        parsedCsvData.map((parsedData, index) => (
                        <tr key={index}>
                            <td>{parsedData.Sentence}</td>
                            <td>{parsedData.Label}</td>
                        </tr>
                        ))}
                    </tbody>
                    </table>
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

export default function ImportData(props) {
    var [acceptedFiles, setAcceptedFiles] = useState([]);

    return (
        <div className="importdata">
            <Sidebar/>
            <div className="container">
                <Navbar/>
                <DragDropFile files={acceptedFiles} updateAcceptedFiles={setAcceptedFiles}/>
                    <button
                        variant="contained"
                        size="medium"
                        color="secondary"
                        onClick={() => {
                            uploadTrainingData(acceptedFiles, setAcceptedFiles);
                        }}
                        disabled={acceptedFiles.length == 0}>
                            Upload Data
                    </button>
            </div>
        </div>
    )
}