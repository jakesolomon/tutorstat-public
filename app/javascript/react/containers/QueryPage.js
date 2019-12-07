import React, { Component } from 'react';

import QueryParams from '../components/QueryParams';
import BarGraph from '../components/BarGraph';

class QueryPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      // Use state to determine which params have been checked.
    };
  }

// User below to fetch data from Heroku or wherever.

  // componentDidMount() {
  //   // FETCH ALL ARTICLES
  //   fetch("http://localhost:4567/api/v1/articles")
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
  //     this.setState( { articles: body } );
  //   })
  //   .catch(error => console.error(`Error in fetch: ${error.message}`));
  // }


// TODO: Build function to send to QueryParams to collect data about user actions.

  render() {
    return(
      <div>
        <h2 className="main-header">Query</h2>
        <div className="grid-x data-container">
          <div className="cell medium-6 large-4 query-params">
            <QueryParams />
          </div>
          <div className="cell medium-6 large-8 query-display">
            <BarGraph />
          </div>
        </div>
      </div>
    );
  }
}

export default QueryPage;
