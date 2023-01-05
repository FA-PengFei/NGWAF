import "./manage_data.css"
import Sidebar from "../../components/sidebar/sidebar"
import Navbar from "../../components/navbar/navbar"

import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import axios from "axios";

import config from "../../config.json"

import React, { useEffect, useState } from "react";
import { Store } from 'react-notifications-component';
import 'react-notifications-component/dist/theme.css'

import {
    IconButton,
    Button
} from "@mui/material";

import DeleteIcon from '@mui/icons-material/Delete';

export default function ManageData() {
    var [fileList, setFileList] = useState([]);

    async function deleteDataset(fileName) {
        try {
            let res = await axios.post(`${config.SERVER_URL}/delete_train_data`, { "fileNames": [fileName] })
            if (res.data.message === "File deleted Successful") {
                //alert("Dataset Delete Successful")
                Store.addNotification({
                    title: "Success",
                    message: "Dataset Deletion Successful!",
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
                fetchFileList()
            }
        } catch (e) {
            //alert("Delete Failed")
            Store.addNotification({
                title: "Error",
                message: "Delete failed!",
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
    }

    async function fetchFileList() {
        try {
            let res = await axios.get(`${config.SERVER_URL}/list_train_data`)
            //TODO: do checks to ensure the status code is 200, error handling etc
            setFileList(res.data)
        } catch (e) {
            //alert("Failed to Load Data")
            Store.addNotification({
                title: "Error",
                message: "Failed to load data!",
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

    }

    useEffect(() => {
        fetchFileList()
    }, [])

    return (
        <div className="managedata">
            <Sidebar />
            <div className="container">
                <Navbar />

                <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 550 }} aria-label="simple table">
                        <TableHead>
                            <TableRow>
                                <TableCell>Dataset Name</TableCell>
                                <TableCell align="left">File Size</TableCell>
                                <TableCell align="left"># of Rows</TableCell>
                                <TableCell align="left">Comments</TableCell>
                                <TableCell align="left">Actions</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {fileList.map((row) => (
                                <TableRow
                                    key={row.fileName}
                                    sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                                >
                                    <TableCell component="th" scope="row">
                                        {row.fileName}
                                    </TableCell>
                                    <TableCell align="left">{row.fileSize} kb</TableCell>
                                    <TableCell align="left">{row.rowNum} rows</TableCell>
                                    <TableCell align="left">Sample Dataset Comment</TableCell>
                                    <TableCell align="left">
                                        <IconButton style={{ color: 'red' }} onClick={() => deleteDataset(row.fileName)}>
                                            <DeleteIcon />
                                        </IconButton>
                                    </TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </TableContainer>
                <div button={<Button
                    variant="contained"
                    size="medium"
                    color="secondary"
                    onClick={() => fetchFileList()}
                >
                    Refresh Datasets
                </Button>
                }
                ></div>
            </div>
        </div>
    )
}