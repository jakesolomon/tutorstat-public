import React from 'react';
import '../../../../../node_modules/react-vis/dist/style.css';
import {
  XYPlot,
  XAxis,
  YAxis,
  VerticalBarSeries,
  VerticalBarSeriesCanvas
} from 'react-vis';

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
