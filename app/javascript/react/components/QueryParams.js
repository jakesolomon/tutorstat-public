import React from 'react';


const QueryParams = (props) => {
  return(
    <div className="grid-x query-params-list">
      <div className="row small-12">
        <input type="radio" name="pokemon" value="Both" id="pokemonRed" required /><label htmlFor="pokemonRed">Combined</label>
        <input type="radio" name="pokemon" value="Separate" id="pokemonBlue" /><label htmlFor="pokemonBlue">Separate</label>
        <input type="radio" name="pokemon" value="SAT" id="pokemonYellow" /><label htmlFor="pokemonYellow">SAT</label>
        <input type="radio" name="pokemon" value="ACT" id="pokemonYellow" /><label htmlFor="pokemonYellow">ACT</label>
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
    </div>
  );
};

export default QueryParams;
