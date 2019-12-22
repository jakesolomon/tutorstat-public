import React from 'react';
// import '../../../../../node_modules/react-vis/dist/style.css';
import {
  XYPlot,
  XAxis,
  YAxis,
  VerticalBarSeries,
  VerticalBarSeriesCanvas
} from 'react-vis';

const BarGraph = (props) => {

  let barSeries = props.data.map(data => {
    return(
      <VerticalBarSeries data={data} />
    );
  });

  return (
    <div>
      <XYPlot
        margin={{top: 40}}
        xType="ordinal"
        width={600}
        height={300}
      >
        {barSeries}
        <XAxis />
        <YAxis />
      </XYPlot>
    </div>
  );
};

export default BarGraph;
