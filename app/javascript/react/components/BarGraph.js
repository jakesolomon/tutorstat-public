import React from 'react';
import '../../../../node_modules/react-vis/dist/style.css';
import {
  XYPlot,
  XAxis,
  YAxis,
  VerticalBarSeries,
  VerticalBarSeriesCanvas,
  DiscreteColorLegend,
  Hint
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

  let visibility = "";
  if (!props.showStudentCount) {
    visibility = "disappear";
  }

  return (
    <div className="barGraph row">
      <h4 className="barGraph-header">{props.data.title}</h4>
      <XYPlot
        className="cell large-9"
        margin={{top: 40, left: 70, bottom: 45}}
        xType="ordinal"
        width={700}
        height={300}
        animation={true}
      >
        <DiscreteColorLegend
        className="cell large-3"
        items={legendItems}
        orientation="horizontal"
        />
        {barSeries}
        <XAxis
        animation={false}
        tickSize={0}
        style={{ text: {fontSize: 14} }}
        />
        <XAxis
        title={props.data.xLabel}
        style={{ line: {stroke:'none'} }}
        animation={false}
        top={303}
        />
        <XAxis
        tickFormat={v => props.data.studentCount.map(count => {
          return (count[v]);
        }).join(" | ")}
        top={0}
        style={{ line: {stroke:'none'}, text: {fontSize: 14} }}
        animation={false}
        className={visibility}
        />
        <YAxis
        style={{ text: {fontSize: 14} }}
        />
        <YAxis
        title={props.data.yLabel}
        style={{ line: {stroke:'none'}, text: {fill: 'none'} }}
        left={-65}
        />
      </XYPlot>
    </div>
  );
};

export default BarGraph;
