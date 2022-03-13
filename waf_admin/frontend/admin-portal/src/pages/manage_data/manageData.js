import React, { useEffect, useState } from "react";
import {
  Grid,
  IconButton,
  Button
} from "@material-ui/core";
import { makeStyles } from "@material-ui/styles";

import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

import {
  Delete as DeleteIcon
} from "@material-ui/icons";

// components
import PageTitle from "../../components/PageTitle";
import axios from "axios";

import config from "../../config.json"

const useStyles = makeStyles(theme => ({
  tableOverflow: {
    overflow: 'auto'
  }
}))

export default function ManageData() {
  const classes = useStyles();

  var [fileList, setFileList] = useState([]);

  async function deleteDataset(fileName) {
    try{
      // Extract the file names
      // let deleteFileList = fileList.map((file) => {
      //   return file.fileName
      // })

      let res = await axios.post(`${config.SERVER_URL}/delete_train_data`, {"fileNames": [fileName]})
      if(res.data.message === "File deleted Successful") {
        alert("Dataset Delete Successful")
        fetchFileList()
      }
    }catch(e) {
      alert("Delete Failed")
    }
  }

  async function fetchFileList() {
    try{
      let res = await axios.get("http://localhost:8088/list_train_data")
      //TODO: do checks to ensure the status code is 200, error handling etc
      setFileList(res.data)
    } catch(e) {
      alert("Failed to Load Data")
    }

  }

  // React State Hook refresh DOM update
  // https://reactjs.org/docs/hooks-reference.html#useeffect
  useEffect(() => {
    fetchFileList()
  }, [])

  return (
    <>
      <PageTitle title="List of Datasets" button={<Button
      variant="contained"
      size="medium"
      color="secondary"
      onClick={()=>fetchFileList()}
    >
        Refresh Datasets
    </Button> 
    }
    />


      <Grid container spacing={2}>

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
              <TableCell align="left">{row.fileSize / 1000 } kb</TableCell>
              <TableCell align="left">{row.rowNum} rows</TableCell>
              <TableCell align="left">Sample Dataset Comment</TableCell>
              <TableCell align="left">
                <IconButton style={{color: 'red'}} onClick={() => deleteDataset(row.fileName)}>
                  <DeleteIcon/>
                </IconButton>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>

      </Grid>
    </>
  );
}
