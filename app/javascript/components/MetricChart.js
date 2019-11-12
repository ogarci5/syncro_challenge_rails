import React from "react"
import PropTypes from "prop-types"
import { PieChart, Pie } from 'recharts';

export class MetricChart extends React.Component {
  render () {
    return (
      <div>
        <h3 className="text-center">{this.props.category}</h3>
        <PieChart width={300} height={250}>
          <Pie data={this.props.data} dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={100} fill="#8884d8" />
        </PieChart>
      </div>
    );
  }
}

MetricChart.propTypes = {
  category: PropTypes.string,
  data: PropTypes.array
};

export default MetricChart
