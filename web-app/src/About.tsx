import { Link } from "react-router-dom";
import "./App.css";

const About = () => {
  return (
    <div className="App">
      <header className="App-header">
        <p>This is the About page</p>
        <p>
          <Link to="/" className="App-link">
            Home
          </Link>
        </p>
      </header>
    </div>
  );
};

export default About;
