import React from 'react';


const TopBar = (props) => {
  return(
    <ul className="vertical medium-horizontal menu">
      <li><a href="#0"><i className="fi-list"></i> <span>Query</span></a></li>
      <li><a href="#0"><i className="fi-list"></i> <span>Tutors</span></a></li>
    </ul>
  );
};

export default TopBar;
