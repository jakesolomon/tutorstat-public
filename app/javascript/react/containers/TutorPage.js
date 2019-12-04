import React, { Component } from 'react';

class TutorPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  render() {
    return(
      <div>
        <h1 className="main-header">Tutors</h1>
        <div className="grid-x tutors-container">
          <div className="cell tutor-block">
            hello i am a tutor block
          </div>
        </div>
      </div>
    );
  }
}

export default TutorPage;
