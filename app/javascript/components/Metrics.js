import React from "react"
import PropTypes from "prop-types"
import { MetricChart } from "./MetricChart.js"
import { MetricNavigation } from "./MetricNavigation.js"

class Metrics extends React.Component {
  render () {
    return (
      <div className="container pt-5">
        <div className="row">
          <h1>Reports</h1>
        </div>
        <div className="row pt-5">
          <div className="col-md-2">
            <MetricNavigation categories={this.props.categories} />
          </div>
          <div className="col-md-10">
            <MetricChart name={this.props.category} data={this.props.data} />
            <hr />
          </div>
        </div>
      </div>
    );
  }
}

Metrics.propTypes = {
  categories: PropTypes.array,
  category: PropTypes.string,
  data: PropTypes.array
};
export default Metrics
