//
//  DestinationDataView.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation
import MapKit

struct DestinationViewData: Identifiable, Hashable {
    var id = UUID()
    var iata:String
    var title:String
    var subtitle:String
    
    init(mapItem:MKMapItem) {
        self.iata = mapItem.name ?? String()
        self.title = mapItem.name ?? String()
        self.subtitle = mapItem.placemark.title ?? String()
    }
}
