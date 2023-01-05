import React from 'react';
import Sidebar from "../../components/sidebar/sidebar"
import Navbar from "../../components/navbar/navbar"
import "./dashboard.css"
import jsonString from "../../JSON/sample.json"
import { Chart as ChartJS } from 'chart.js/auto'
import { Chart, Line, getDatasetAtEvent } from 'react-chartjs-2'
import GridLayout from "react-grid-layout";
import Calendar from 'react-calendar';
import moment from 'moment';
import testData from "../../JSON/test.json"
import "react-slidedown/lib/slidedown.css";
import { SlideDown } from "react-slidedown";
import { Button } from "@mui/material";
import config from "../../config.json"
import axios from "axios";
import { Store } from 'react-notifications-component';

//Put all the dates into a set - By date we mean jsonString.training_completion_time minus the time

//Steps to retrieve dashboard
//   1) Retrieve all JSON files --> Currently local files are in ../../JSON
//So either save all these JSON files locally
//Or fetch them from a webpage
//   2) From each JSON file, retrieve the jsonString.training_completion_time, and retrieve all the dates to populate marks on calendar
//   3) When the particular date is clicked, a list of (if any) different training times for that day is displayed
//   4) When user click on this timing, we will retrieve the data values from that particular JSON and populate data for graph
//   5) Graph shows whatever the user needs

var date = new Date();
var timelist = [];
var newArray = [];
var dateArray = [];
var jsonDate = [];
var index = 0;
let marks = new Set();

export default class Dashboard extends React.Component {

    constructor(props) {
        super(props);
        this.handleToggle = () => {
            this.setState(_state => (
                {
                    open: true
                }
            ));
        };
        this.handleUpdate = () => {
            this.setState(_state => (
                {
                    itemCounts: this.generateItemCounts(),
                }
            ));
        };

        this.state = {
            open: false,
            itemCounts: this.generateItemCounts(),
            data: {
                labels: testData.model_diagnostics.threshold,
                datasets: [{
                    label: 'ML Accuracy',
                    data: testData.model_diagnostics.accuracy,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }, {
                    label: 'F1 Score',
                    data: testData.model_diagnostics.f1_score,
                    borderColor: 'rgb(255 ,0 ,0)',
                    tension: 0.1
                }, {
                    label: 'False Positive Rate',
                    data: testData.model_diagnostics.false_pos_rate,
                    borderColor: 'rgb(255, 173, 0)',
                    tension: 0.1
                }]
            }
        };
        this.setGraphState = this.setGraphState.bind(this);
    }

    async fetch_stats() {
        try{
            let res = await axios.get((`${config.SERVER_URL}/check_train_status`))
            let res_data_arr = res.data["status"]
            for (var idx = 0; idx < res_data_arr.length; idx++) {
                if (res_data_arr[idx].status === "success") {
                    console.log("Adding...")
                    var _date = new Date(res_data_arr[idx].training_completion_time.substring(0, 10).toString()).toLocaleDateString();
                    jsonDate.push(_date);
                    newArray.push(res_data_arr[idx])
                }
            }
            //console.log(jsonDate, "jsonDate fetch stats")
            //console.log(newArray, "new array fetch stats")
            marks = jsonDate;
            //console.log(marks, "marks fetch stats")
            this.setGraphState()
        } catch(e) {
            console.log(e)
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

    onChange(nextValue) {
        //console.log(nextValue);
        date = new Date(nextValue).toLocaleDateString(); //Gets date from String in DD-MM-YYYY format, same as marks
    }

    componentDidMount() {
        this.fetch_stats();
    }

    generateItemCounts() { //Returns how many item are there for the particular date
        timelist = [];
        //For all JSON files, get all the date
        const [day, month, year] = date.toString().split(/[.\-=/_]/);
        // YYYY-MM-DD
        //console.log(date, "old date");
        date = `${year}-${month}-${day}`;
        //console.log(date, "new date");
        //Filter array to only include json with the matching date as to the user clicked date
        dateArray = [];
        dateArray = newArray;
        //console.log(dateArray, "date array before filter");
        dateArray = dateArray.filter(el => el.training_completion_time.toString().includes(date.toString()));
        //console.log(dateArray, "Date array after filter");
        
        //Get time from each json in newArray)
        for (var idx = 0; idx < dateArray.length; idx++) {
            var _time = dateArray[idx].training_completion_time.substring(11).toString();
            _time = _time.replaceAll('-', ':');
            timelist.push(_time);
        }
        return [1, dateArray.length];
    }

    layout = [
        { i: "a", x: 0, y: 0, w: 15, h: 15, static: true },
        { i: "b", x: 20, y: 0, w: 5, h: 7, static: true }
    ];

    setGraphState() {
        if (newArray.length == 0) {
            console.log('im empty so i take sample data');
            newArray = jsonString;
        }

        if (dateArray.length == 0) {
            dateArray = newArray;
        }

        console.log(dateArray, "new array graph state")
        //console.log(newArray);
        console.log(index);
        console.log(dateArray[index]);
        console.log(dateArray[index].model_diagnostics.false_pos_rate);
        this.setState({
            data: {
                labels: dateArray[index].model_diagnostics.threshold,
                datasets: [{
                    label: 'ML Accuracy',
                    data: dateArray[index].model_diagnostics.accuracy,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }, {
                    label: 'F1 Score',
                    data: dateArray[index].model_diagnostics.f1_score,
                    borderColor: 'rgb(255 ,0 ,0)',
                    tension: 0.1
                }, {
                    label: 'False Positive Rate',
                    data: dateArray[index].model_diagnostics.false_pos_rate,
                    borderColor: 'rgb(255, 173, 0)',
                    tension: 0.1
                }]
            }
        })
    }

    render() {
        return (
            <div className="dashboard">
                <Sidebar />
                <div className="container">
                    <Navbar />
                    <GridLayout
                        className="layout"
                        layout={this.layout}
                        cols={21}
                        rowHeight={30}
                        width={1400}
                    >
                        <div key="a" className='a'>
                            <Line data={this.state.data} options={{
                                scales: {
                                    yAxes:{
                                        grid: {
                                            drawBorder: true,
                                            color: '#ff7f7f',
                                        },
                                    },
                                    xAxes: {
                                        grid: {
                                            drawBorder: true,
                                            color: '#ff7f7f',
                                        },
                                    },
                                }
                            }}/>
                        </div>
                        <div key="b" className='b'>
                            <b>List of Training data, by date</b>
                            <hr></hr>
                            <Calendar
                                tileClassName={({ date, view }) => {
                                    //console.log(marks.length, "marks.length")
                                    if (marks.length > 0 && marks.includes(moment(date).format("DD/MM/YYYY"))) {
                                        return 'highlight';
                                    }
                                }}
                                onChange={(e) => { this.onChange(e); this.handleToggle(); this.handleUpdate(); }} />
                            {/* <button
                                className={"main-toggle pure-button pure-button-primary button-large"}
                                onClick={this.handleToggle}
                                >
                                Toggle
                                </button>
                                <button
                                className={"main-toggle pure-button pure-button-primary button-large"}
                                onClick={this.handleUpdate}
                                >
                                Update
                                </button> */}
                            <div className={"main-columns"}>
                                {this.renderColumn(this.state.itemCounts[1], true, false)}
                                {/* {this.renderColumn(this.state.itemCounts[1], true, true)} */}
                            </div>
                        </div>
                    </GridLayout>
                </div>
            </div>
        )
    }

    renderDrop(overlay, alwaysRender) {
        let className = "dropdown-slidedown";
        return (
            <div className={"dropdown-container"}>
                <span className={"narrative"}>{ }</span>
                <SlideDown
                    className={"pure-menu pure-menu-scrollable " + className}>
                    {this.renderList(timelist)}
                </SlideDown>
            </div>
        );
    }

    getButtonId = (e) => {
        //console.log(dropdata);
        //console.log(e.currentTarget.id);
        index = e.currentTarget.id;
    }

    renderList(timelist) {
        const items = [];
        if (timelist.length > 0) {
            for (var idx = 0; idx < timelist.length; idx++) {
                items.push(
                    <div key={idx}>
                        <Button id={idx} onClick={(e) => { this.getButtonId(e); this.setGraphState(); }}>{timelist[idx]}</Button>
                    </div>
                );
            }
            return (
                <div>
                    {items}
                </div>
            );
        }
    }

    renderColumn(overlay, alwaysRender) {
        return (
            <div className={"main-column"}>
                {/* <span className={"narrative"}>
              {"I will " + (overlay ? "overlay" : "push down")}
                </span> */}
                {this.renderDrop(overlay, alwaysRender)}
                {/* <span className={"narrative"}>
                {"I am " + (overlay ? "underneath" : "below")}
                </span> */}
            </div>
        );
    }
}