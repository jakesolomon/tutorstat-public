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
      satData: [],
      actData: [],
      convertedActData: [],
      combinedData: []
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
      data = [this.state.satData];
    }
    else if (this.state.parameters.test == "act") {
      data = [this.state.actData];
    }
    else if (this.state.parameters.test == "combined") {
      data = [this.state.combinedData];
    }
    else if (this.state.parameters.test == "compare") {
      data = [this.state.satData, this.state.convertedActData];
    }
    else {
      data = [[ ]];
    }
    return data;
  }

  assignXAndY(scores) {
    let output = [];
    Object.keys(scores).forEach(range => {
      output.push( { x: range, y: scores[range] } );
    });
    return output;
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
      this.setState( {
        satData: this.assignXAndY(body.satScores),
        actData: this.assignXAndY(body.actScores),
        convertedActData: this.assignXAndY(body.convertedActScores),
        combinedData: this.assignXAndY(body.combinedScores)
        }
      );
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

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
