import React from "react"
import PropTypes from "prop-types"
class Metrics extends React.Component {
  render () {
    return (
      <div>
        <h1>Metrics</h1>
        <ul>
          {this.props.metrics.map(metric => (
            <li key={metric.id}>
              {`${metric.category} = ${metric.value}`}
            </li>
          ))}
        </ul>
      </div>
    );
  }
}

Metrics.propTypes = {
  metrics: PropTypes.array
};
export default Metrics
