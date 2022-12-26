//
//  reducers.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation

enum Reducers {
    case LocationSearchService
    case Utils
}

/* --MARK:Reducer */
class Reducer {
    
    enum ReducerError:Error {
        case noReducer(for:Action)
        case invalidActionDetails
    }
    
    static func reduce(_ action:ActionDetails?) throws {
        guard let action = action else { throw ReducerError.invalidActionDetails }
        switch action.reducer {
        case .LocationSearchService:
            gs.reduce(.LocationSearchService, with: action); break
        case .Utils:
            gs.reduce(.Utils, with: action); break
        case .none:
            throw ReducerError.noReducer(for: action.action)
        }
    }
}
