import React, { Component } from 'react';

import TutorList from './TutorList';
import TutorListing from '../components/TutorListing';


class TutorPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      // store sorting and filtering preferences
    };
  }

  render() {
    return(
      <div>
        <h2 className="main-header">Tutors</h2>
        <div className="grid-x data-container">
          <div className="cell tutor-sortBy">
            <h4 className="float-left">Sort</h4>
            <div className="primary button-group float-left sorting-buttons">
              <a className="button small">SAT Avg</a>
              <a className="button small">ACT Avg</a>
              <a className="button small">Number of Students</a>
            </div>
          </div>
          <div className="cell small-12">
            <TutorList />
          </div>
        </div>
      </div>
    );
  }
}

export default TutorPage;
