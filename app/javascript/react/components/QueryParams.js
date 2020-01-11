import React from 'react';


const QueryParams = (props) => {

  let percentileLabel = "cell small-9";
  let showStudentCountLabel = "cell small-9";
  let subdivideLabel = "cell small-9";

  let testSelectors;
  let percentileInput;
  let subdivideInput;
  let studentCountInput;

  if (props.muteCombined) {
    testSelectors =
      <div className="row small-12">
        <input disabled onChange={props.changeTest} type="radio" name="testSelect" value="combined" id="combined" /><label htmlFor="combined">Combined</label>
        <input disabled onChange={props.changeTest} type="radio" name="testSelect" value="compare" id="compare" /><label htmlFor="compare">Compare</label>
        <input onChange={props.changeTest} type="radio" name="testSelect" value="sat" id="sat" /><label htmlFor="sat">SAT</label>
        <input onChange={props.changeTest} type="radio" name="testSelect" value="act" id="act" /><label htmlFor="act">ACT</label>
      </div>;
  } else {
    testSelectors =
      <div className="row small-12">
        <input onChange={props.changeTest} type="radio" name="testSelect" value="combined" id="combined" /><label htmlFor="combined">Combined</label>
        <input onChange={props.changeTest} type="radio" name="testSelect" value="compare" id="compare" /><label htmlFor="compare">Compare</label>
        <input onChange={props.changeTest} type="radio" name="testSelect" value="sat" id="sat" /><label htmlFor="sat">SAT</label>
        <input onChange={props.changeTest} type="radio" name="testSelect" value="act" id="act" /><label htmlFor="act">ACT</label>
      </div>;
  }

  if (props.mutePercentile) {
    percentileInput =
      <input disabled checked={false} onChange={props.togglePercentile} className="switch-input" id="percentileSwitch" type="checkbox" name="percentileSwitch" />;
    percentileLabel += " disabled";
  }
  else if (props.percentileOn) {
    percentileInput =
      <input checked={true} onChange={props.togglePercentile} className="switch-input" id="percentileSwitch" type="checkbox" name="percentileSwitch" />;
  } else {
    percentileInput =
      <input checked={false} onChange={props.togglePercentile} className="switch-input" id="percentileSwitch" type="checkbox" name="percentileSwitch" />;
  }

  if (props.muteSubdivideBySection) {
    subdivideInput =
      <input disabled checked={false} onChange={props.toggleSubdivideBySection} className="switch-input disabled" id="subdivideBySection" type="checkbox" name="subdivideBySection" />;
    subdivideLabel += " disabled";
  } else if (props.subdivideBySectionOn) {
    subdivideInput =
      <input checked={true} onChange={props.toggleSubdivideBySection} className="switch-input" id="subdivideBySection" type="checkbox" name="subdivideBySection" />;
  } else {
    subdivideInput =
      <input checked={false} onChange={props.toggleSubdivideBySection} className="switch-input" id="subdivideBySection" type="checkbox" name="subdivideBySection" />;
  }

  if (props.studentCountOn) {
    studentCountInput =
      <input checked={true} onChange={props.toggleStudentCount} className="switch-input" id="showStudentCount" type="checkbox" name="showStudentCount" />;
  } else {
    studentCountInput =
      <input checked={false} onChange={props.toggleStudentCount} className="switch-input" id="showStudentCount" type="checkbox" name="showStudentCount" />;
  }

  return(
    <form className="grid-x query-params-list">
      {testSelectors}
      <div className="cell small-3">
        <div className="switch">
          <input onChange={props.togglePercentile} className="switch-input" id="percentileSwitch" type="checkbox" name="percentileSwitch" />
          <label className="switch-paddle" htmlFor="percentileSwitch">
            <span className="switch-active" aria-hidden="true">On</span>
            <span className="switch-inactive" aria-hidden="true">Off</span>
          </label>
        </div>
      </div>
      <div className={percentileLabel}>
        <p>Show as percentile</p>
      </div>
      <div className="cell small-3">
        <div className="switch">
          {studentCountInput}
          <label className="switch-paddle" htmlFor="showStudentCount">
            <span className="switch-active" aria-hidden="true">On</span>
            <span className="switch-inactive" aria-hidden="true">Off</span>
          </label>
        </div>
      </div>
      <div className={showStudentCountLabel}>
        <p>Show Student Count</p>
      </div>
      <div className="cell small-3">
        <div className="switch">
          {subdivideInput}
        <label className="switch-paddle" htmlFor="subdivideBySection">
          <span className="switch-active" aria-hidden="true">On</span>
          <span className="switch-inactive" aria-hidden="true">Off</span>
        </label>
      </div>
      </div>
      <div className={subdivideLabel}>
        <p>Subdivide by Section</p>
      </div>
    </form>
  );
};

export default QueryParams;
