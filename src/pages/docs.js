import React from "react";
import { Switch, Route, Redirect } from "react-router-dom";

export default function Docs() {
  return (
    <Switch>
      <Route exact path="/docs">
        <Redirect to="/docs/neonkube" />
      </Route>
    </Switch>
  );
}
