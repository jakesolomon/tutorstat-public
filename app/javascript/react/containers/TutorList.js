import React, { Component } from 'react';

import TutorListing from '../components/TutorListing';

class TutorList extends Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  render() {

    let tutorNames = [
      "Katherine Bailey",
      "Ronna Berman",
      "Paul Chiampa",
      "Don Lippincott",
      "Rory McHarg",
      "Matt McNicholas",
      "Samantha Meeker",
      "Travis Minor",
      "Ellen Neelands",
      "Tom Opp",
      "Alec Poitzsch",
      "Jake Solomon",
      "Mike Urban",
      "Erin Webb",
      "Leann Westin",
    ];
    let tutorList = tutorNames.map(tutor => {
      return(
        <TutorListing
          key={tutorNames.indexOf(tutor)}
          id={tutorNames.indexOf(tutor)}
          name={tutor}
        />
      );
    });

    return(
      <ul className="accordion tutor-list" data-accordion data-allow-all-closed="true">
        {tutorList}
      </ul>
    );
  }
}

export default TutorList;
