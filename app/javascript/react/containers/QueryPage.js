import React, { Component } from 'react';

import QueryParams from '../components/QueryParams';
import BarGraph from '../components/BarGraph';

class QueryPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      parameters: {
        test: false
      },
      satData: [
        {x: "800–1199", y: 0},
        {x: "1200–1399", y: 0},
        {x: "1400–1499", y: 0},
        {x: "1500–1600", y: 0}
      ],
      actData: [
        {x: "1–15", y: 0},
        {x: "16–20", y: 0},
        {x: "21–25", y: 0},
        {x: "26–36", y: 0}
      ]
      // Use state to determine which query parameters have been checked.
    };
    this.changeQueryParams=this.changeQueryParams.bind(this);
  }

  // Function to track changes to query parameters
  changeQueryParams() {
    let parameters = {
      test: event.target.value
    };
    this.setState( {
      parameters: parameters
    } );
  }

  graphData() {
    let data;
    if (this.state.parameters.test == "sat") {
      data = this.state.satData;
    }
    else if (this.state.parameters.test == "act") {
      data = this.state.actData;
    }
    else {
      data = [
        {x: "Low", y: 0},
        {x: "Medium", y: 0},
        {x: "High", y: 0},
        {x: "Very High", y: 0}
      ];
    }
    return data;
  }

  componentDidMount() {
    // FETCH ALL TESTS
    fetch(`api/v1/tests`)
    .then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(body => {
      let satData = [
        {x: "800–1199", y: body.satScoresAvgIncreaseByStartingScore.low},
        {x: "1200–1399", y: body.satScoresAvgIncreaseByStartingScore.mid},
        {x: "1400–1499", y: body.satScoresAvgIncreaseByStartingScore.high},
        {x: "1500–1600", y: body.satScoresAvgIncreaseByStartingScore.veryHigh}
      ];
      let actData = [
        {x: "1–15", y: body.actScoresAvgIncreaseByStartingScore.low},
        {x: "16–20", y: body.actScoresAvgIncreaseByStartingScore.mid},
        {x: "21–25", y: body.actScoresAvgIncreaseByStartingScore.high},
        {x: "26–36", y: body.actScoresAvgIncreaseByStartingScore.veryHigh}
      ];
      this.setState( { satData: satData, actData: actData } );
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

// TODO: Build function to send to QueryParams to collect data about user actions.

  render() {

    return(
      <div>
        <h2 className="main-header">Query</h2>
        <div className="grid-x data-container">
          <div className="cell medium-6 large-4 query-params">
            <QueryParams changeQueryParams={this.changeQueryParams}/>
          </div>
          <div className="cell medium-6 large-8 query-display">
            <BarGraph data={this.graphData()}/>
          </div>
        </div>
      </div>
    );
  }
}

export default QueryPage;
