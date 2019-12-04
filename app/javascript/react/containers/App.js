import React from 'react';
import { BrowserRouter, Route, Switch } from "react-router-dom";

import TopBar from '../components/TopBar';
import QueryPage from './QueryPage';
import TutorPage from './TutorPage';


// Use Router to direct to data entry. Data viewing (tutors, query) happen
// in the same route.

// Make a new branch in which App.js is a stateful container. From there, I
// can store what type of data display (tutors, query, or more) is active
// by storing this in the state of App.js, and avoid the need of using React
// router to switch to different rails routes (at least, where the data being
// displayed is the same stuff). Router and routes will be used to differentiate
// between data viewing and data manipulation.

export const App = (props) => {
  return (
    <div>
      <TopBar />
      <div className="main-content">
        <BrowserRouter>
          <Switch>
            <Route path="/" component={QueryPage} />
          </Switch>
        </BrowserRouter>
      </div>
    </div>
  );
};

export default App;
