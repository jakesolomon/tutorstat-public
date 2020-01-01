import React, { Component } from 'react';

import QueryParams from '../components/QueryParams';
import BarGraph from '../components/BarGraph';

class QueryPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      test: false,
      percentile: false,
      satScores: [],
      satPercentiles: [],
      actScores: [],
      actPercentiles: [],
      convertedactScores: [],
      convertedActPercentiles: [],
      combinedScores: [],
      combinedPercentiles: []
      // Use state to determine which query parameters have been checked.
    };
    this.changeTest=this.changeTest.bind(this);
    this.togglePercentile=this.togglePercentile.bind(this);
  }

  // Functions to track changes to query parameters
  changeTest() {
    this.setState( { test: event.target.value } );
  }

  togglePercentile() {
    if (this.state.percentile == false) {
      this.setState( { percentile: true } );
    } else {
      this.setState( { percentile: false } );
    }
  }

  graphData() {
    let data;
    let legend;
    let title;
    let yLabel;
    let xLabel = "Starting Score";

    if (this.state.percentile == false && this.state.test) {
      title = "Average Score Increase of Students by Starting Score";
      yLabel = "Points increase";
    } else if (this.state.test) {
      title = "Average Percentile Increase of Students by Starting Score";
      yLabel = "Percentile increase";
    }

    if (this.state.test == "sat" && this.state.percentile == false) {
      data = [this.state.satScores];
      legend = ["SAT Score Increase"];
    }
    else if (this.state.test == "sat" && this.state.percentile == true) {
      data = [this.state.satPercentiles];
      legend = ["SAT Percentile Increase"];
    }
    else if (this.state.test == "act" && this.state.percentile == false) {
      data = [this.state.actScores];
      legend = ["ACT Score Increase"];
    }
    else if (this.state.test == "act" && this.state.percentile == true) {
      data = [this.state.actPercentiles];
      legend = ["ACT Percentile Increase"];
    }
    else if (this.state.test == "combined" && this.state.percentile == false) {
      data = [this.state.combinedScores];
      legend = ["Combined SAT and ACT Score Increase"];
    }
    else if (this.state.test == "combined" && this.state.percentile == true) {
      data = [this.state.combinedPercentiles];
      legend = ["Combined SAT and ACT Percentile Increase"];
    }
    else if (this.state.test == "compare" && this.state.percentile == false) {
      data = [this.state.satScores, this.state.convertedactScores];
      legend = ["SAT Score Increase", "ACT Score Increase (as SAT equivalent)"];
    }
    else if (this.state.test == "compare" && this.state.percentile == true) {
      data = [this.state.satPercentiles, this.state.convertedActPercentiles];
      legend = ["SAT Percentile Increase", "ACT Percentile Increase (sorted by SAT equivalent)"];
    }
    else {
      data = [[ ]];
      legend = [""];
    }
    return {data: data, legend: legend, title: title, xLabel: xLabel, yLabel: yLabel};
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
        satScores: this.assignXAndY(body.satScores),
        satPercentiles: this.assignXAndY(body.satPercentiles),
        actScores: this.assignXAndY(body.actScores),
        actPercentiles: this.assignXAndY(body.actPercentiles),
        convertedactScores: this.assignXAndY(body.convertedActScores),
        convertedActPercentiles: this.assignXAndY(body.convertedActPercentiles),
        combinedScores: this.assignXAndY(body.combinedScores),
        combinedPercentiles: this.assignXAndY(body.combinedPercentiles)
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
            <QueryParams changeTest={this.changeTest} togglePercentile={this.togglePercentile}/>
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
