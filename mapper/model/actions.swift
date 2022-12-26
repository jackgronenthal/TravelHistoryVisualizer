//
//  actions.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation

enum Action {
    // Location Search
    case SubmitLocationSearchServiceQuery
    case SetLocationSearchServiceQuery
    case SetNavigationViewToolBar
    case ToggleDestinationModal
    case ToggleAddDestinationSheet
    
    // App Utils
    case Paginate
}

struct ActionDetails {
    var reducer:Reducers?
    var action:Action
    var payload:Payload
    
    init(reduceWith reducer:Reducers, using action:Action, _ payload:Payload){
        self.reducer = reducer
        self.action = action
        self.payload = payload
    }
    
    init(using action:Action, with payload:Payload){
        self.reducer = nil
        self.action = action
        self.payload = payload
    }
    
    mutating func set(reducer:Reducers) { self.reducer = reducer }
}
