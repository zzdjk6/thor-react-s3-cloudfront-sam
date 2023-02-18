import React from "react";
import logo from "./logo.svg";
import "./App.css";

const builtAt = process.env.REACT_APP_BUILT_AT;

const App = () => {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>This is an React web app</p>
        {builtAt && <p>Built at: {builtAt}</p>}
        <a className="App-link" href="https://reactjs.org" target="_blank" rel="noopener noreferrer">
          Learn React
        </a>
      </header>
    </div>
  );
};

export default App;
