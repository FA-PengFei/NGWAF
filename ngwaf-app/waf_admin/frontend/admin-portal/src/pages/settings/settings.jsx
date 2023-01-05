import "./settings.css"
import React, { useEffect } from "react";
import Sidebar from "../../components/sidebar/sidebar";
import Navbar from "../../components/navbar/navbar";
import { Store } from 'react-notifications-component';
import Slider from '@mui/material/Slider';
import TextField from '@mui/material/TextField';
import {
    Button, Grid, Divider, FormControl, InputLabel, RadioGroup, FormControlLabel, Radio, OutlinedInput, InputAdornment
} from "@mui/material";
import axios from "axios";
import SaveIcon from '@mui/icons-material/Save';

import config from "../../config.json"

function valuetext(value) {
    return `${value}°C`;
}

function renderTelegramPreview(message) {
    const samplePayload = "-1 UNION SELECT * FROM (SELECT * FROM users JOIN users b)a"
    return `${message}\nDetected Payload: ${samplePayload}`
}

export default function Settings() {
    let [mlThreshold, setMlThreshold] = React.useState(0);
    let [telegramChatID, setTelegramChatID] = React.useState("");
    let [telegramDescription, setTelegramDescription] = React.useState("");
    let [honeypotMode, setHoneypotMode] = React.useState("duplicate");
    let [duplicateEndpoint, setDuplicateEndpoint] = React.useState("test");
    let [protectedEndpoint, setProtectedEndpoint] = React.useState("test");

    const updateTelegramDescription = (event) => {
        setTelegramDescription(event.target.value);
      };

    const updateTelegramChatID = (event) => {
        setTelegramChatID(event.target.value);
    };

    const updateHoneyPotMode = (event) => {
        setHoneypotMode(event.target.value);
    };

    const updateHoneyPotEndpoint = (event) => {
        setDuplicateEndpoint(event.target.value);
    };

    const updateProtectedEndpoint = (event) => {
        setProtectedEndpoint(event.target.value);
    };

    async function setSpecifiedConfig(configName, configValue) {
        try {
            let res = await axios.post(`${config.SERVER_URL}/set_config`, { "config_name": configName, "config_value": configValue })
            // console.log(res.data, 'config data');
            // console.log('test');
            // console.log(Object.keys(res.data), 'keys');
            // console.log(res.data[configName], 'value?');
            // return res.data[configName];
        } catch (e) {
            //alert("Delete Failed")
        }
    }

    async function getSpecifiedConfig(configName) {
        try {
            let res = await axios.post(`${config.SERVER_URL}/get_config`, { "config_name": configName })
            // console.log(res.data, 'config data');
            // console.log('test');
            // console.log(Object.keys(res.data), 'keys');
            // console.log(res.data[configName], 'value?')
            return res.data[configName];
        } catch (e) {
            //alert("Delete Failed")
        }
    }

    async function getAllConfig() {
        try {
            let res = await axios.get(`${config.SERVER_URL}/get_all_config`)
            setMlThreshold(parseFloat(res.data["ml_threshold"]))
            setTelegramChatID(res.data["telegram_chat_id"])
            setTelegramDescription(res.data["telegram_description"])
            setHoneypotMode(res.data["honeypot_mode"])
            setDuplicateEndpoint(res.data["duplicate_endpoint"])
            setProtectedEndpoint(res.data["protected_endpoint"])            
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

    async function updateConfig() {
        await setSpecifiedConfig("ml_threshold", mlThreshold);
        await setSpecifiedConfig("telegram_chat_id", telegramChatID);
        await setSpecifiedConfig("telegram_description", telegramDescription);
        await setSpecifiedConfig("honeypot_mode", honeypotMode);
        await setSpecifiedConfig("duplicate_endpoint", duplicateEndpoint);
        await setSpecifiedConfig("protected_endpoint", protectedEndpoint);

        Store.addNotification({
            title: "Success!",
            message: "Settings Update is Successful",
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
    }

    useEffect(() => {
        getAllConfig()
    }, [])

    function shouldRenderEndpointInput() {
        if(honeypotMode === "duplicate") {
            return (
                <Grid item xs={12} paddingLeft={9} paddingTop={2}>
                <FormControl fullWidth>
                    <InputLabel htmlFor="outlined-adornment-amount">Duplicate Endpoint</InputLabel>
                    <OutlinedInput
                        id="outlined-adornment-amount"
                        value={duplicateEndpoint}
                        onChange={updateHoneyPotEndpoint}
                        startAdornment={<InputAdornment position="start">{"http://"}</InputAdornment>}
                        label="Duplicate Endpoint"
                    />
                </FormControl>
            </Grid>
            )
        }
    }

    return (
        <div className="honeypot">
            <Sidebar />
            <div className="container">
                <Navbar />

                <Grid container padding={3}>

                <Grid item xs={12}>
                    <Divider>
                        {"NGWAF Configuration"}
                    </Divider>
                </Grid>


                    <Grid item xs={12} paddingLeft={3}>
                        <div className="element">Protected Endpoint:</div>
                    </Grid>

                    <Grid item xs={11} paddingLeft={9} paddingTop={2}>
                        <FormControl fullWidth>
                        <InputLabel htmlFor="outlined-adornment-amount">Protected Endpoint</InputLabel>
                        <OutlinedInput
                            id="outlined-adornment-amount"
                            value={protectedEndpoint}
                            onChange={updateProtectedEndpoint}
                            startAdornment={<InputAdornment position="start">{"http://"}</InputAdornment>}
                            label="Protected Endpoint"
                        />
                    </FormControl>
                    </Grid>

                    <Grid item xs={12} paddingLeft={3} paddingTop={2}>
                        <div className="element">Trigger Threshold:</div>
                    </Grid>
                    <Grid item xs={1}></Grid>
                    <Grid item xs={1}>
                        <p className="threshold" >{mlThreshold}</p>
                    </Grid>
                    <Grid item xs={10} paddingTop={2}>
                        <Slider
                            aria-label="Confidence Score"
                            getAriaValueText={valuetext}
                            value={mlThreshold}
                            valueLabelDisplay="auto"
                            onChangeCommitted={(_, v) => setMlThreshold(v)}
                            step={0.1}
                            marks
                            min={0.1}
                            max={1.0}
                            />
                    </Grid>

                    <Grid item xs={12} paddingLeft={3}>
                        <div className="element">Honeypot Mode:</div>
                    </Grid>

                    <Grid item xs={1}></Grid>
                    <Grid item xs={11}>
                        <RadioGroup
                            row
                            aria-labelledby="demo-row-radio-buttons-group-label"
                            name="row-radio-buttons-group"
                            value={honeypotMode}
                            onChange={updateHoneyPotMode}
                        >
                            <FormControlLabel value="duplicate" control={<Radio />} label="Digital Twin" />
                            <FormControlLabel value="custom" control={<Radio />} label="Bespoked Static Pot" />
                            <FormControlLabel value="drupot" control={<Radio />} label="H.I.P" />
                        </RadioGroup>
                    </Grid>

                    {shouldRenderEndpointInput()}

                    <Grid item xs={12} paddingTop={6}>
                        <Divider>
                            {"Telegram Configuration"}
                        </Divider>
                    </Grid>

                    <Grid item xs={12} paddingTop={3} paddingBottom={2}>
                        <div className="element">Telegram Chat ID:</div>
                    </Grid>
                    <Grid item xs={1}></Grid>
                    <Grid item xs={11}>
                        <TextField variant="outlined" onChange={updateTelegramChatID} value={telegramChatID} minRows={1} maxRows={1} style={{width: "100%"}} />
                    </Grid>

                    <Grid item xs={12} paddingTop={3} paddingBottom={2}>
                        <div className="element">Telegram Message:</div>
                    </Grid>
                    <Grid item xs={1}></Grid>
                    <Grid item xs={11}>
                        <TextField variant="outlined" onChange={updateTelegramDescription} value={telegramDescription} minRows={6} maxRows={6} multiline style={{width: "100%"}} />
                    </Grid>

                    <Grid item xs={1}></Grid>
                    <Grid item xs={11} paddingTop={3}>
                        <TextField disabled variant="outlined" value={renderTelegramPreview(telegramDescription)} minRows={6} maxRows={6} multiline style={{width: "100%"}} label="Telegram Alert Preview"/>
                    </Grid>

                    <Grid item xs={12} padding={3}>
                        <Divider>
                        </Divider>
                    </Grid>

                    <Grid item xs={12} paddingLeft={3}>
                    <Button
                            variant="contained"
                            startIcon={<SaveIcon />}
                            size="medium"
                            color="primary"
                            onClick={() => { updateConfig() }}>
                            Update Settings
                        </Button>
                    </Grid>

                </Grid>
            </div>
        </div>
    )
}