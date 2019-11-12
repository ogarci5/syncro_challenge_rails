import React from "react"
import PropTypes from "prop-types"
import { PieChart, Pie } from 'recharts';

export class MetricChart extends React.Component {
  render () {
    return (
      <div>
        <h3>{this.props.name}</h3>
        <PieChart width={730} height={250}>
          <Pie data={this.props.data} dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={100} fill="#8884d8" />
        </PieChart>
      </div>
    );
  }
}

MetricChart.propTypes = {
  name: PropTypes.string,
  data: PropTypes.array
};
