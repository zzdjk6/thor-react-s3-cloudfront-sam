import React from "react";
import logo from "./logo.svg";
import "./App.css";
import { Link } from "react-router-dom";

const builtAt = process.env.REACT_APP_BUILT_AT;

const App = () => {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>This is an React web app</p>
        {builtAt && <p>Built at: {builtAt}</p>}
        <p>
          <Link to="/about" className="App-link">
            About
          </Link>
        </p>
      </header>
    </div>
  );
};

export default App;
