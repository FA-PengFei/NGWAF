import "./job.css"
import Sidebar from "../../components/sidebar/sidebar"
import Navbar from "../../components/navbar/navbar"

import config from "../../config.json"
import axios from "axios";

import React, { useEffect, useState } from "react";
import { makeStyles } from "@mui/styles";

import PropTypes from 'prop-types';
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
import IconButton from '@mui/material/IconButton';
import Tooltip from '@mui/material/Tooltip';

import RefreshIcon from '@mui/icons-material/Refresh';
import { Store } from 'react-notifications-component';
import 'react-notifications-component/dist/theme.css'

const useStyles = makeStyles(theme => ({
    tableOverflow: {
        overflow: 'auto'
    }
}))

export var fileListLength = 0;

export default function Jobs() {
    const classes = useStyles();

    var [fileList, setFileList] = useState([]);
    const [selected, setSelected] = useState([]);
    const [page, setPage] = useState(0);
    const [rowsPerPage, setRowsPerPage] = useState(5);

    async function fetchFileList() {
        try {
            let res = await axios.get(`${config.SERVER_URL}/check_train_status`)
            //TODO: do checks to ensure the status code is 200, error handling etc
            setFileList(res.data.status);
            //console.log(res.data.status[0])
            fileListLength = res.data.status.length;
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

    // React State Hook refresh DOM update
    // https://reactjs.org/docs/hooks-reference.html#useeffect
    useEffect(() => {
        fetchFileList();
    }, [])


    const headCells = [
        {
            id: 'job_key',
            numeric: false,
            disablePadding: true,
            label: 'Jobs',
        },
        {
            id: 'status',
            numeric: true,
            disablePadding: false,
            label: 'Status',
        }
    ];

    function EnhancedTableHead() {
        return (
            <TableHead>
                <TableRow>
                    <TableCell>
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

    function renderJobStatusRow(status) {
        let text_class = ""
        if(status === "training") {
            text_class = "text-waiting"
        } else if (status === "success") {
            text_class = "text-success"
        } else if (status === "failed"){
            text_class = "text-warning"
        } else {
            text_class = "text-other"
        }

        return (
            <span className={text_class}>{status}</span>
        )
    }

    const EnhancedTableToolbar = (props) => {
        const { numSelected } = props;

        return (
            <Toolbar
                sx={{
                    pl: { sm: 2 },
                    pr: { xs: 1, sm: 1 },
                    ...(numSelected > 0)
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
                        List of jobs
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

    const handleChangePage = (event, newPage) => {
        setPage(newPage);
    };

    const handleChangeRowsPerPage = (event) => {
        setRowsPerPage(parseInt(event.target.value, 10));
        setPage(0);
    };

    const isSelected = (name) => selected.indexOf(name) !== -1;

    // Avoid a layout jump when reaching the last page with empty rows.
    const emptyRows = page > 0 ? Math.max(0, (1 + page) * rowsPerPage - fileList.length) : 0;

    return (
        <div className="managemodel">
            <Sidebar />
            <div className="container">
                <Navbar />
                <div
                />
                <Paper sx={{ width: '100%', mb: 2 }}>
                    <EnhancedTableToolbar numSelected={selected.length} />
                    <TableContainer>
                        <Table
                            sx={{ minWidth: 750 }}
                            aria-labelledby="tableTitle"
                            size={'medium'}
                        >
                            <EnhancedTableHead
                            />
                            <TableBody>
                                {fileList.map((row, index) => {
                                    const labelId = `enhanced-table-checkbox-${index}`;

                                    return (
                                        <TableRow>
                                            <TableCell>
                                            </TableCell>
                                            <TableCell
                                                component="th"
                                                id={labelId}
                                                scope="row"
                                                padding="none"
                                            >
                                                {row.job_key}
                                            </TableCell>
                                            <TableCell align="left">
                                                {renderJobStatusRow(row.status)}
                                            </TableCell>
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
            </div>
        </div>
    )
}