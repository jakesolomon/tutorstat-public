import React from 'react';
import '../../../../node_modules/react-vis/dist/style.css';
import {
  XYPlot,
  XAxis,
  YAxis,
  VerticalBarSeries,
  VerticalBarSeriesCanvas,
  DiscreteColorLegend
} from 'react-vis';

const BarGraph = (props) => {

  let seriesColors = [
    "00EE00",
    "EE0000"
  ];

  let barSeries = props.data.data.map(data => {
    return(
      <VerticalBarSeries
      data={data}
      key={props.data.data.indexOf(data)}
      color={seriesColors[props.data.data.indexOf(data)]}
      />
    );
  });

  let legendItems = [
    {
      title: props.data.legend[0],
      color: seriesColors[0]
    }
  ];

  if (props.data.data[1]) {
    legendItems.push(
      {
        title: props.data.legend[1],
        color: seriesColors[1]
      }
    );
  }

  return (
    <div className="barGraph row">
      <XYPlot
        className="cell large-9"
        margin={{top: 40}}
        xType="ordinal"
        width={600}
        height={300}
      >
        <DiscreteColorLegend
        className="cell large-3"
        items={legendItems}
        orientation="horizontal"
        />
        {barSeries}
        <XAxis />
        <YAxis />
      </XYPlot>
    </div>
  );
};

export default BarGraph;
