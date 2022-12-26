//
//  LocalLocationSearchServiceView.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation

import SwiftUI

struct LocalLocationSearchServiceView: View {
    
    @ObservedObject private var s_locationSearchService = gs.locationSearchService()
    @ObservedObject private var s_utils = gs.utils()

    private var toolbar : some View {
        toolbar {
            Button("Add") {}
        }
    }
    
    var body: some View {
        VStack {
            AddDestinationSheetview()
//            List(self.$s_locationSearchService.destinationData.indices, id: \.self) { index in
//                Text(self.s_locationSearchService.destinationData[index].title)
//            }
        }
            
        //        VStack(alignment: .leading) {
//            TextField("Enter Location", text: self.$s_locationSearchService.iataCode)
//                .onSubmit {
//                    gs.dispatch(.SubmitLocationSearchServiceQuery, true)
//                }
//            Divider()
//            Text("Results").font(.title)
//            List {
//                ForEach(self.$s_locationSearchService.viewData.indices, id: \.self) { index in
//                    VStack(alignment: .leading) {
//                        Text(self.s_locationSearchService.viewData[index].title)
//                    }
//                }
//            }
//        }
//        .padding(.horizontal)
//        .padding(.top)
    }
}

struct LocalLocationSearchServiceView_Previews: PreviewProvider {
//    @State static var tab : ContentView.Tab = .destinations
    static var previews: some View {
        ContentView()
    }
}
