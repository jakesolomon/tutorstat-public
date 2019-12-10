import React, { Component } from 'react';

import QueryParams from '../components/QueryParams';
import BarGraph from '../components/BarGraph';

class QueryPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      tests: [
        {x: "800–1199", y: 0},
        {x: "1200–1399", y: 0},
        {x: "1400–1499", y: 0},
        {x: "1500–1600", y: 0}
      ]
      // Use state to determine which params have been checked.
    };
  }

  // componentDidMount() {
  //   // FETCH ALL TESTS
  //   fetch("http://localhost:3000/api/v1/tests")
  //   .then(response => {
  //     if (response.ok) {
  //       return response;
  //     } else {
  //       let errorMessage = `${response.status} (${response.statusText})`,
  //         error = new Error(errorMessage);
  //       throw(error);
  //     }
  //   })
  //   .then(response => response.json())
  //   .then(body => {
  //     let data = [
  //       {x: "800–1199", y: body.low},
  //       {x: "1200–1399", y: body.mid},
  //       {x: "1400–1499", y: body.high},
  //       {x: "1500–1600", y: body.veryHigh}
  //     ];
  //     this.setState( { tests: data } );
  //   })
  //   .catch(error => console.error(`Error in fetch: ${error.message}`));
  // }

// TODO: Build function to send to QueryParams to collect data about user actions.

  render() {

    const SATDATA = [
      {x: "800–1199", y: 109.7},
      {x: "1200–1399", y: 106.6},
      {x: "1400–1499", y: 72.7},
      {x: "1500–1600", y: 38}
    ];

    return(
      <div>
        <h2 className="main-header">Query</h2>
        <div className="grid-x data-container">
          <div className="cell medium-6 large-4 query-params">
            <QueryParams />
          </div>
          <div className="cell medium-6 large-8 query-display">
            <BarGraph data={SATDATA}/>
          </div>
        </div>
      </div>
    );
  }
}

export default QueryPage;
