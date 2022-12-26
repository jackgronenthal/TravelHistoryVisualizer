//
//  model.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation

protocol Store {
    func reduce(_ details:ActionDetails)
}

class GlobalStore : ObservableObject {
    
    @Published private var s_locationSearchService:LocalLocationSearchServiceViewModel = LocalLocationSearchServiceViewModel()
    @Published private var s_utils:UtilsViewModel = UtilsViewModel()
    
    private static let dispatcher = Dispatcher()
    
    var dispatch:(_ action:Action, _ payload:Any?) -> () = dispatcher.dispatch
    var dispatchWithReducer:(_ action:Action, _ reducer:Reducers) -> () = dispatcher.dispatch
    var dispatchWithPayloadAndReducer:(_ action:Action, _ payload:Any?, _ reducer:Reducers) -> () = dispatcher.dispatch
    func reduce(_ store:Reducers, with action:ActionDetails) {
        switch store {
        case .LocationSearchService: self.s_locationSearchService.reduce(action); break;
        case .Utils: self.s_utils.reduce(action); break;
        }
    }
    
    func locationSearchService() -> LocalLocationSearchServiceViewModel {
        return self.s_locationSearchService
    }
    
    func utils() -> UtilsViewModel { return self.s_utils }
}

var gs = GlobalStore()
