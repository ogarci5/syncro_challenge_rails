import React from "react"
import PropTypes from "prop-types"
import { Nav, NavItem, NavLink } from 'reactstrap';

export class MetricNavigation extends React.Component {
  render () {
    return (
      <div>
        <p>Categories</p>
        <hr />
        <Nav vertical>
          {this.props.categories.map(category => (
            <NavItem>
              <NavLink href={'/?category=' + category}>{category}</NavLink>
            </NavItem>
          ))}
        </Nav>
      </div>
    );
  }
}

MetricNavigation.propTypes = {
  categories: PropTypes.array
};

export default MetricNavigation
