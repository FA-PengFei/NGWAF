import React, { useEffect, useState } from "react";
import {
  Grid,
  Button
} from "@material-ui/core";
import { makeStyles } from "@material-ui/styles";

import PropTypes from 'prop-types';
import { alpha } from '@mui/material/styles';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Checkbox from '@mui/material/Checkbox';
import IconButton from '@mui/material/IconButton';
import Tooltip from '@mui/material/Tooltip';

import { 
  Refresh as RefreshIcon
 } from '@material-ui/icons';

import config from "../../config.json"

// components
import PageTitle from "../../components/PageTitle";
import axios from "axios";
import BasicModal from "../../components/Modal/modal";

const useStyles = makeStyles(theme => ({
  tableOverflow: {
    overflow: 'auto'
  }
}))

export default function ManageModel() {
  const classes = useStyles();

  var [fileList, setFileList] = useState([]);
  const [selected, setSelected] = useState([]);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(5);
  const [showLoadingModal, setShowLoadingModal] = useState(false)

  async function fetchFileList() {
    try{
      let res = await axios.get(`${config.SERVER_URL}/list_train_data`)
      //TODO: do checks to ensure the status code is 200, error handling etc
      setFileList(res.data)
    } catch(e) {
      alert("Failed to Load Data")
    }
  }

  async function updateModel() {
    try{
      setShowLoadingModal(true)
      let res = await axios.post(`${config.SERVER_URL}/update_model`, {"fileNames": selected})
      setShowLoadingModal(false)
      //TODO: do checks to ensure the status code is 200, error handling etc
      console.log(res.data)
      if(res.data.message === "Model Update Successful") {
        alert("Model Updated!")
      }
      
    } catch(e) {
      alert("Failed to Update Model")
    }
  }

  // React State Hook refresh DOM update
  // https://reactjs.org/docs/hooks-reference.html#useeffect
  useEffect(() => {
    fetchFileList()
  }, [])

  
  const headCells = [
    {
      id: 'fileName',
      numeric: false,
      disablePadding: true,
      label: 'Dataset',
    },
    {
      id: 'fileSize',
      numeric: true,
      disablePadding: false,
      label: 'File Size (kb)',
    },
    {
      id: 'numRows',
      numeric: true,
      disablePadding: false,
      label: '# of Rows',
    },
    {
      id: 'comments',
      numeric: true,
      disablePadding: false,
      label: 'Comments',
    }
  ];
  
  function EnhancedTableHead(props) {
    const { onSelectAllClick, numSelected, rowCount} = props;
  
    return (
      <TableHead>
        <TableRow>
          <TableCell padding="checkbox">
            <Checkbox
              color="primary"
              indeterminate={numSelected > 0 && numSelected < rowCount}
              checked={rowCount > 0 && numSelected === rowCount}
              onChange={onSelectAllClick}
              inputProps={{
                'aria-label': 'select all datasets',
              }}
            />
          </TableCell>
          {headCells.map((headCell) => (
            <TableCell
              key={headCell.id}
              align='left'
              padding={headCell.disablePadding ? 'none' : 'normal'}
            >
              {headCell.label}
            </TableCell>
          ))}
        </TableRow>
      </TableHead>
    );
  }
  
  EnhancedTableHead.propTypes = {
    numSelected: PropTypes.number.isRequired,
    onSelectAllClick: PropTypes.func.isRequired,
    rowCount: PropTypes.number.isRequired,
  };
  
  const EnhancedTableToolbar = (props) => {
    const { numSelected } = props;
  
    return (
      <Toolbar
        sx={{
          pl: { sm: 2 },
          pr: { xs: 1, sm: 1 },
          ...(numSelected > 0 && {
            bgcolor: (theme) =>
              alpha(theme.palette.primary.main, theme.palette.action.activatedOpacity),
          }),
        }}
      >
        {numSelected > 0 ? (
          <Typography
            sx={{ flex: '1 1 100%' }}
            color="inherit"
            variant="subtitle1"
            component="div"
          >
            {numSelected} selected
          </Typography>
        ) : (
          <Typography
            sx={{ flex: '1 1 100%' }}
            variant="h6"
            id="tableTitle"
            component="div"
          >
            Select Dataset for Training Model
          </Typography>
        )}
  
        <Tooltip title="Reload">
          <IconButton onClick={() => fetchFileList()}>
            <RefreshIcon />
          </IconButton>
        </Tooltip>

      </Toolbar>
    );
  };
  
  EnhancedTableToolbar.propTypes = {
    numSelected: PropTypes.number.isRequired,
  };

  const handleSelectAllClick = (event) => {
    if (event.target.checked) {
      const newSelecteds = fileList.map((n) => n.fileName);
      setSelected(newSelecteds);
      return;
    }
    setSelected([]);
  };

  const handleClick = (event, name) => {
    const selectedIndex = selected.indexOf(name);
    let newSelected = [];

    if (selectedIndex === -1) {
      newSelected = newSelected.concat(selected, name);
    } else if (selectedIndex === 0) {
      newSelected = newSelected.concat(selected.slice(1));
    } else if (selectedIndex === selected.length - 1) {
      newSelected = newSelected.concat(selected.slice(0, -1));
    } else if (selectedIndex > 0) {
      newSelected = newSelected.concat(
        selected.slice(0, selectedIndex),
        selected.slice(selectedIndex + 1),
      );
    }

    setSelected(newSelected);
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  const isSelected = (name) => selected.indexOf(name) !== -1;

  // Avoid a layout jump when reaching the last page with empty rows.
  const emptyRows =
    page > 0 ? Math.max(0, (1 + page) * rowsPerPage - fileList.length) : 0;


  return (
    <>
    {showLoadingModal ? BasicModal("Loading", "Updating WAF Model.\nPlease Wait...", showLoadingModal, setShowLoadingModal) : null}

    <PageTitle title="List of Datasets" button={<Button
      variant="contained"
      size="medium"
      color="secondary"
      disabled = {selected.length == 0}
      onClick={()=>updateModel()}
    >
        Update WAF Model
    </Button> 
    }
    />
      <Grid container spacing={2}>

      <Paper sx={{ width: '100%', mb: 2 }}>
        <EnhancedTableToolbar numSelected={selected.length} />
        <TableContainer>
          <Table
            sx={{ minWidth: 750 }}
            aria-labelledby="tableTitle"
            size={'medium'}
          >
            <EnhancedTableHead
              numSelected={selected.length}
              onSelectAllClick={handleSelectAllClick}
              rowCount={fileList.length}
            />
            <TableBody>
              {fileList.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                .map((row, index) => {
                  const isItemSelected = isSelected(row.fileName);
                  const labelId = `enhanced-table-checkbox-${index}`;

                  return (
                    <TableRow
                      hover
                      onClick={(event) => handleClick(event, row.fileName)}
                      role="checkbox"
                      aria-checked={isItemSelected}
                      tabIndex={-1}
                      key={row.fileName}
                      selected={isItemSelected}
                    >
                      <TableCell padding="checkbox">
                        <Checkbox
                          color="primary"
                          checked={isItemSelected}
                          inputProps={{
                            'aria-labelledby': labelId,
                          }}
                        />
                      </TableCell>
                      <TableCell
                        component="th"
                        id={labelId}
                        scope="row"
                        padding="none"
                      >
                        {row.fileName}
                      </TableCell>
                      <TableCell align="left">{row.fileSize / 1000} kb</TableCell>
                      <TableCell align="left">{row.rowNum}</TableCell>
                      <TableCell align="left">Sample Dataset Comment</TableCell>
                    </TableRow>
                  );
                })}
              {emptyRows > 0 && (
                <TableRow
                  style={{
                    height: (53) * emptyRows,
                  }}
                >
                  <TableCell colSpan={6} />
                </TableRow>
              )}
            </TableBody>
          </Table>
        </TableContainer>
        <TablePagination
          rowsPerPageOptions={[5, 10, 25]}
          component="div"
          count={fileList.length}
          rowsPerPage={rowsPerPage}
          page={page}
          onPageChange={handleChangePage}
          onRowsPerPageChange={handleChangeRowsPerPage}
        />
      </Paper>

      </Grid>
    </>
  );
}
