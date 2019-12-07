import React from 'react';


const TutorListing = (props) => {
  return(
    <li className="accordion-item" data-accordion-item>
      <a className="accordion-title">
        <div className="grid-x">
          <div className="cell small-3">
            {props.name}
          </div>
          <div className="cell small-3">
            SAT AVG: 0
          </div>
          <div className="cell small-3">
            ACT AVG: 0
          </div>
        </div>
      </a>
      <div className="accordion-content" data-tab-content>
        <div className="grid-x">
          <div className="cell small-3">
          </div>
          <div className="cell small-3">
            Reading: 0<br/>
            Writing: 0<br/>
            Math: 0<br/>
          </div>
          <div className="cell small-3">
            English: 0<br/>
            Math: 0<br/>
            Reading: 0<br/>
            Science: 0<br/>
          </div>
        </div>
      </div>
    </li>
  );
};

export default TutorListing;
