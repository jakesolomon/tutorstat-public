import React from 'react';


const QueryParams = (props) => {
  return(
    <form className="grid-x query-params-list">
      <div className="row small-12">
        <input disabled type="radio" name="testSelect" value="both" id="both" required /><label htmlFor="both">Combined</label>
        <input disabled type="radio" name="testSelect" value="separate" id="separate" /><label htmlFor="separate">Separate</label>
        <input onChange={props.changeQueryParams} type="radio" name="testSelect" value="sat" id="sat" /><label htmlFor="sat">SAT</label>
        <input onChange={props.changeQueryParams} type="radio" name="testSelect" value="act" id="act" /><label htmlFor="act">ACT</label>
      </div>
      <div className="cell small-3">
        <div className="switch">
          <input className="switch-input" id="percentileSwitch" type="checkbox" name="percentileSwitch" />
          <label className="switch-paddle" htmlFor="percentileSwitch">
            <span className="switch-active" aria-hidden="true">On</span>
            <span className="switch-inactive" aria-hidden="true">Off</span>
          </label>
        </div>
      </div>
      <div className="cell small-9">
        <p>Show as percentile</p>
      </div>
      <div className="cell small-3">
        <div className="switch">
          <input className="switch-input" id="doSomethingSwitch" type="checkbox" name="doSomethingSwitch" />
          <label className="switch-paddle" htmlFor="doSomethingSwitch">
            <span className="switch-active" aria-hidden="true">On</span>
            <span className="switch-inactive" aria-hidden="true">Off</span>
          </label>
        </div>
      </div>
      <div className="cell small-9">
        <p>Do something else</p>
      </div>
      <div className="cell small-3">
        <div className="switch">
          <input className="switch-input" id="cakeSwitch" type="checkbox" name="cakeSwitch" />
          <label className="switch-paddle" htmlFor="cakeSwitch">
            <span className="switch-active" aria-hidden="true">On</span>
            <span className="switch-inactive" aria-hidden="true">Off</span>
          </label>
        </div>
      </div>
      <div className="cell small-9">
        <p>Bake cake</p>
      </div>
    </form>
  );
};

export default QueryParams;
