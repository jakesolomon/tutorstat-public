import React from 'react';


const TopBar = (props) => {
  return(
    <ul className="vertical medium-horizontal menu">
      <li><i><button className="fi-list" onClick={props.onClick}>Query</button></i></li>
      <li><a><i className="fi-list"></i> <span>Tutors</span></a></li>
    </ul>
  );
};

export default TopBar;
