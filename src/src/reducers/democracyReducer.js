import initialStoreState from '../store/initialStoreState.js'
import Immutable from 'immutable';
import {ELECTION_RESULTS_RETRIEVED} from '../constants/constants.js';

export default function web3Reducer(state = initialStoreState.democracy, action) {
    switch (action.type) {
        case ELECTION_RESULTS_RETRIEVED:
            return {
                ...state,
                propositions: new Immutable.List(action.payload[0]),
                counts: new Immutable.List(action.payload[1])
            };
        default:
            return state;
    }
}