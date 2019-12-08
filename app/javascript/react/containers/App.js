import React, { Component } from 'react';
import { BrowserRouter, Route, Switch } from "react-router-dom";

import TopBar from '../components/TopBar';
import QueryPage from './QueryPage';
import TutorPage from './TutorPage';


class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      activePage: "query"
    };

    this.subNav = this.subNav.bind(this);
  }

  subNav(event) {
    event.preventDefault();
    console.log('click');
    // this.setState( { activePage: event.target.destination} );
  }

  render() {
    return (
      <div>
        <div>
            <BrowserRouter>
              <Switch>
                <Route path="/tutors" component={TutorPage} />
                <Route path="/" component={QueryPage} />
              </Switch>
            </BrowserRouter>
        </div>
      </div>
    );
  }
}

export default App;
