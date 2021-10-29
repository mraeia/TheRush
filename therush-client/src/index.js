import React from "react";
import ReactDOM from "react-dom";
import {
  BrowserRouter as Router,
  Redirect,
  Route,
  Switch,
} from "react-router-dom";
import App from "./components/App";

import "./index.css";

ReactDOM.render(
  <Router>
    <Switch>
      <Route exact path="/results" component={App} />
      <Redirect to="/results" />
    </Switch>
  </Router>,
  document.getElementById("root")
);
