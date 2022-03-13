import React from "react";
import {
  Route,
  Switch,
  withRouter,
} from "react-router-dom";
import classnames from "classnames";

// styles
import useStyles from "./styles";

// components
import Header from "../Header";
import Sidebar from "../Sidebar";

// pages
import Dashboard from "../../pages/dashboard";

// context
import { useLayoutState } from "../../context/LayoutContext";
import ImportData from "../../pages/import_data/ImportData";
import ManageData from "../../pages/manage_data/manageData";
import ManageModel from "../../pages/manage_model/manageModel";

function Layout(props) {
  var classes = useStyles();

  // global
  var layoutState = useLayoutState();

  return (
    <div className={classes.root}>
        <>
          <Header history={props.history} />
          <Sidebar />
          <div
            className={classnames(classes.content, {
              [classes.contentShift]: layoutState.isSidebarOpened,
            })}
          >
            <div className={classes.fakeToolbar} />
            <Switch
              display={"flex"}>
              <Route path="/app/dashboard" component={Dashboard} />
              <Route path="/app/import_data" component={ImportData} />
              <Route path="/app/manage_data" component={ManageData} />
              <Route path="/app/manage_model" component={ManageModel} />
            </Switch>

          </div>
        </>
    </div>
  );
}

export default withRouter(Layout);
