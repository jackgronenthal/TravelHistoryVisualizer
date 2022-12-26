//
//  dispatcher.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation

class Dispatcher {
    
    private var reduce = Reducer.reduce
    private var logNum = 0
    
    /// Details the error designation for a payload exception.
    /// - `invalidTypes`: The passed types are invalid
    /// - `insufficientCoverage`: An action does not have its payload types enumerated within the `verifyPayload` function.
    enum PayloadError: Error { case invalidTypes(recieved:Any, expected:[Any]), insufficientCoverage(coverless:Action) }

    
    /// Mechanism to verify that the `action` has appropriate `payload`. Returns `true` on success; `false` otherwise.
    /// - Throws: An error on when invalid payload types are identified.
    private func verifyPayload(_ action:Action, _ payload:Any?) throws -> Bool? {
        
        var expectedTypes:[Any] = []
        var typesValid:Bool = false
        switch action {
        case .SetLocationSearchServiceQuery:
            expectedTypes = [String.self]
            typesValid = verify(string: payload)
            break
        case .SubmitLocationSearchServiceQuery:
            expectedTypes = [Bool.self]
            typesValid = verify(bool: payload)
            break
        case .Paginate:
            expectedTypes = [String.self]
            typesValid = verify(string: (payload as? ContentView.Tab)?.rawValue)
            break
        case .SetNavigationViewToolBar:
            typesValid = true;
            // FIXME
        default:
            throw PayloadError.insufficientCoverage(coverless: action)
        }
        if(typesValid) { return true }
        throw PayloadError.invalidTypes(recieved: type(of: payload), expected: expectedTypes)
        
    }
    
    func dispatch(action:Action) {
        dispatch(action: action, payload: nil)
    }
    
    func dispatch(action:Action, reducer:Reducers) {
        dispatch(action: action, payload: nil, reducer: reducer)
    }
    
    func dispatch(action:Action, payload:Any?, reducer:Reducers) {
        let isValid = verifyPayloadTypes(action, payload)
        if !isValid { return }
        var details = ActionDetails(using: action, with:payload)
        details.set(reducer: reducer)
        dispatchWithLogging(details)
    }
    
    /// Determines on which store an _action_ should be executed.
    func dispatch(action:Action, payload:Any?) {
        let isValid = verifyPayloadTypes(action, payload)
        if !isValid { return }
        let details = setReducer(action, payload)
        dispatchWithLogging(details)
    }
    
    private func verifyPayloadTypes(_ action:Action, _ payload:Payload) -> Bool {
        do {
            guard let payloadIsValid = try verifyPayload(action, payload) else { return false }
            return payloadIsValid
        }
        catch { print(error); return false }
    }
    
    private func setReducer(_ action:Action, _ payload:Payload) -> ActionDetails {
        var details = ActionDetails(using: action, with:payload)
        switch action {
        
        // LocationSearchService
        case .SubmitLocationSearchServiceQuery: fallthrough
        case .SetLocationSearchServiceQuery: details.set(reducer: .LocationSearchService); break;
        
        // Utils
        case .SetNavigationViewToolBar: fallthrough
        case .Paginate: details.set(reducer: .Utils); break;
            
        }
        
        return details
    }
    
    private func dispatchWithLogging(_ details:ActionDetails) {
        print("\n==== Dispatch [\(self.logNum)] ====")
        print("     Action: \(details.action)")
        print("     Payload: \(String(describing: details.payload))")
        print("     Reducer: \(String(describing: details.reducer))")
        do {
            try reduce(details)
            print("     Status: Success => \(details.action), \(String(describing: details.payload))")
        }
        catch {
            print("     Status: Error")
            print(error)
        }
        self.logNum += 1
    }
    
    // --MARK: Verifiers
    /// Verifies if inputted `payload` is of type `String`.
    private func verify(string payload:Any?) -> Bool { guard let _ = payload as? String else { return false }; return true }
    /// Verifies if inputted `payload` is of type `Bool`.
    private func verify(bool payload:Any?) -> Bool { guard let _ = payload as? Bool else { return false }; return true }
    
    private func verify<T>(type targetType:T.Type, against payload:Any?) -> Bool {
        return payload is T
        print(type(of: targetType) == type(of: payload as? T))
        guard let _ = payload as? T else {
            return false
        };
        return true
    }
}
