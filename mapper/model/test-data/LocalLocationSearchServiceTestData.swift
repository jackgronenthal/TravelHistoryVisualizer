//
//  LocalLocationSearchServiceTestData.swift
//  mapperTests
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation
import CoreLocation
import MapKit

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





