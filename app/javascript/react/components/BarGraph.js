import React from 'react';
// import '../../../../../node_modules/react-vis/dist/style.css';
import {
  XYPlot,
  XAxis,
  YAxis,
  VerticalBarSeries,
  VerticalBarSeriesCanvas
} from 'react-vis';

  // const myDATA = [
  //   {x: "800–1199", y: 40},
  //   {x: "1200–1399", y: 142},
  //   {x: "1400–1499", y: 102},
  //   {x: "1500–1600", y: 59}
  // ];

// const {useCanvas} = this.state;
// const content = useCanvas ? 'TOGGLE TO SVG' : 'TOGGLE TO CANVAS';
// const BarSeries = useCanvas ? VerticalBarSeriesCanvas : VerticalBarSeries;

const BarGraph = (props) => {
  return (
    <div>
      <XYPlot
        margin={{top: 40}}
        xType="ordinal"
        width={600}
        height={300}
      >
        <VerticalBarSeries data={props.data} />
        <XAxis />
        <YAxis />
      </XYPlot>
    </div>
  );
};

export default BarGraph;
