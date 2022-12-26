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

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                AddDestinationButtonView()
            }
            .onAppear {
                gs.dispatch(.Paginate, ContentView.Tab.destinations)
            }
            .navigationTitle("Unnamed Travel")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { Button(action: { gs.dispatch(.ToggleDestinationModal, false) }) {
                Text("**Done**")
            } }
        }
    }
}

struct LocalLocationSearchServiceView_Previews: PreviewProvider {
    static var previews: some View {
        LocalLocationSearchServiceView()
    }
}
