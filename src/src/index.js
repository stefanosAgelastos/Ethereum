import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, IndexRoute, browserHistory } from 'react-router'
import { Provider } from 'react-redux'
import { syncHistoryWithStore } from 'react-router-redux'
import { UserIsAuthenticated, UserIsNotAuthenticated } from './util/wrappers.js'
import getWeb3 from './util/web3/getWeb3'

// Layouts
import App from './App'
import Home from './components/home/Home'
import Dashboard from './components/dashboard/Dashboard'
import SignUp from './components/signup/SignUp'
import Profile from './components/profile/Profile'

// Redux Store
import store from './store'

// Initialize react-router-redux.
const history = syncHistoryWithStore(browserHistory, store);

// Initialize web3 and set in Redux.
getWeb3
.then(results => {
  console.log('Web3 initialized!');
})
.catch(() => {
  console.log('Error in web3 initialization.');
});

ReactDOM.render((
        <Provider store={store}>
            <Router history={history}>
                <Route path="/" component={App}>
                    <IndexRoute component={Home}/>
                    <Route path="dashboard" component={UserIsAuthenticated(Dashboard)}/>
                    <Route path="signup" component={UserIsNotAuthenticated(SignUp)}/>
                    <Route path="profile" component={UserIsAuthenticated(Profile)}/>
                </Route>
            </Router>
        </Provider>
    ),
    document.getElementById('root')
);