import React, { Component } from 'react';
import { BrowserRouter, Route, Switch } from "react-router-dom";

import TopBar from '../components/TopBar';
import QueryPage from './QueryPage';
import TutorPage from './TutorPage';


// Use Router to direct to data entry. Data viewing (tutors, query) happen
// in the same route.

// EDIT: I should just do all the navigation in rails routing.

// Make a new branch in which App.js is a stateful container. From there, I
// can store what type of data display (tutors, query, or more) is active
// by storing this in the state of App.js, and avoid the need of using React
// router to switch to different rails routes (at least, where the data being
// displayed is the same stuff). Router and routes will be used to differentiate
// between data viewing and data manipulation.

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
