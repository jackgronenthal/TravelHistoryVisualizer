//
//  LocalLocationSearchServiceViewModel.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation
import Combine
import MapKit
import SwiftUI

final class LocalLocationSearchServiceViewModel: Store, ObservableObject {
    private var cancellable: AnyCancellable?
    private var service:LocalSearchService;
    
    @Published private var cityText = String()
    @Published private var poiText = String()
    @Published var iataCode = String()
    @Published var viewData = [LocalSearchViewData]()
    @Published var destinationData = [DestinationViewData]()
    
    private let toolbar = Button(action: { print("clicked") }) { Image(systemName: "plus") }
    
    init() {
        service = LocalSearchService(in: LocalLocationSearchServiceTestData.localLocationSearchServiceTestData[.NewYork]!)
                
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.viewData = mapItems.map({ LocalSearchViewData(mapItem: $0) })
        }
    }
    
    // Service Invokers
    private func searchIATACode() { service.searchIATACode(queryString: self.iataCode) }
    
    /// Sets the content within the NavigationView toolbar that is specific to the LocalLocationSearchService page.
    private func setNavigationViewToolBar() {
        gs.dispatchWithPayloadAndReducer(.SetNavigationViewToolBar, toolbar, .Utils)
    }
    
    func reduce(_ details: ActionDetails) {
        switch(details.action) {
        case .SubmitLocationSearchServiceQuery: searchIATACode()
        case .SetNavigationViewToolBar: setNavigationViewToolBar()
        default: print("No action enumerated in LocationService")
        }
        return
    }
}

struct LocalLocationSearchServiceTestData {
    enum LocalLocationSearchServiceTestLocations {
        case NewYork
    }
    
    public static var localLocationSearchServiceTestData: [LocalLocationSearchServiceTestLocations:CLLocationCoordinate2D] = [
        .NewYork: of(lat: 40.730610, lon: -73.935242)
    ]
    
    private static func of(lat:CLLocationDegrees, lon:CLLocationDegrees) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
