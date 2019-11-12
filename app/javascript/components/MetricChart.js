import React from "react"
import PropTypes from "prop-types"
import { PieChart, Pie, Cell } from 'recharts';

const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042'];

export class MetricChart extends React.Component {
  render () {
    return (
      <div>
        <h3 className="text-center">{this.props.category}</h3>
        <PieChart width={500} height={500}>
          <Pie
            data={this.props.data}
            dataKey="value"
            nameKey="name"
            cx="50%"
            cy="50%"
            outerRadius={100}
            fill="#8884d8"
            label={({
                      cx,
                      cy,
                      midAngle,
                      innerRadius,
                      outerRadius,
                      value,
                      index
                    }) => {
              const RADIAN = Math.PI / 180;
              const radius = 25 + innerRadius + (outerRadius - innerRadius);
              const x = cx + radius * Math.cos(-midAngle * RADIAN);
              const y = cy + radius * Math.sin(-midAngle * RADIAN);

              return (
                <text
                  x={x}
                  y={y}
                  fill={COLORS[index % COLORS.length]}
                  textAnchor={x > cx ? "start" : "end"}
                  dominantBaseline="central"
                >
                  {this.props.data[index].name} ({value})
                </text>
              );
            }}
            labelLine={false}
          >
            {
              this.props.data.map((entry, index) => <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />)
            }
          </Pie>
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
