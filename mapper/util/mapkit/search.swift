//
//  search.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation
import Combine
import MapKit

final class LocalSearchService {
    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
    private let center:CLLocationCoordinate2D
    private let radius:CLLocationDistance
    
    init(in center:CLLocationCoordinate2D, radius:CLLocationDistance = 350_000) {
        self.center = center
        self.radius = radius
    }
    
    public func searchCities(queryString:String) {}
    public func searchPointOfInterests(queryString:String) {}
    public func searchIATACode(queryString:String) {
        request(queryString: queryString)
    }
    
    private func request(resultType:MKLocalSearch.ResultType = .pointOfInterest, queryString:String) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = queryString
        request.pointOfInterestFilter = MKPointOfInterestFilter.init(including: [.airport])
        request.resultTypes = resultType
        request.region = MKCoordinateRegion(center: center, latitudinalMeters: radius, longitudinalMeters: radius)
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self](response, _) in
            guard let response = response else { return }
            self?.localSearchPublisher.send(response.mapItems)
        }
    }
}

struct LocalSearchViewData: Identifiable, Hashable {
    var id = UUID()
    var title:String
    var subtitle:String
    
    init(mapItem:MKMapItem) {
        self.title = mapItem.name ?? String()
        self.subtitle = mapItem.placemark.title ?? String()
    }
}
