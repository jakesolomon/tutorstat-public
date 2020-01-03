import React, {Component} from 'react';

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

class BarGraph extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hoveredNode: {x: null, y: null},
      hint: false
    };
    this.changeHint = this.changeHint.bind(this);
  }

  changeHint(d) {
    if (this.state.hoveredNode.x != d.x || this.state.hoveredNode.y != d.y) {
      this.setState({
        hoveredNode: {
          x: d.x, y: Math.round(d.y*10)/10
        },
        hint: true
      });
    }
  }

  render() {
    const hoveredNode = this.state;

    let seriesColors = [
      "00EE00",
      "EE0000"
    ];

    let barSeries = this.props.data.data.map(data => {
      return(
        <VerticalBarSeries
        changeHint={this.changeHint}
        data={data}
        key={this.props.data.data.indexOf(data)}
        color={seriesColors[this.props.data.data.indexOf(data)]}
        onValueMouseOver={(d,e) => {
          this.changeHint(d);
        }}
        />
      );
    });

    let legendItems = [
      {
        title: this.props.data.legend[0],
        color: seriesColors[0]
      }
    ];

    if (this.props.data.data[1]) {
      legendItems.push(
        {
          title: this.props.data.legend[1],
          color: seriesColors[1]
        }
      );
    }

    let visibility = "";
    if (!this.props.showStudentCount) {
      visibility = "disappear";
    }

    let hideHint;
    if (this.state.hoveredNode.x == null) {
      hideHint = "disappear";
    } else {
      hideHint = "";
    }

    return (
      <div className="barGraph row">
      <h4 className="barGraph-header">{this.props.data.title}</h4>
      <XYPlot
      className="cell large-9"
      margin={{top: 40, left: 70, bottom: 45}}
      xType="ordinal"
      width={700}
      height={300}
      animation={true}
      onMouseLeave={() => this.setState({hoveredNode: {x: null, y: null} })}
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
      title={this.props.data.xLabel}
      style={{ line: {stroke:'none'} }}
      animation={false}
      top={303}
      />
      <XAxis
      tickFormat={v => this.props.data.studentCount.map(count => {
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
      title={this.props.data.yLabel}
      style={{ line: {stroke:'none'}, text: {fill: 'none'} }}
      left={-65}
      />
      {hoveredNode && (
            <Hint
              xType="ordinal"
              yType="literal"
              getX={d => d.x}
              getY={d => d.y}
              value={{
                x: this.state.hoveredNode.x,
                y: this.state.hoveredNode.y,
              }}
              className={hideHint}
              format={d => {
                let hint=[];
                if (d.y) {
                  hint.push(
                    {title: `Value`, value: d.y}
                  );
                }
                console.log(hint);
                return(hint);
              }}
            />
      )}
      </XYPlot>
      </div>
    );
  }
}

export default BarGraph;
