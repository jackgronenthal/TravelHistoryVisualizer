//
//  ContentView.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import SwiftUI

struct ContentView: View {
    
    //@State var tab = Tab.home
    @State var toolbar = Button(action: {print("touched")}) { Image(systemName: "plus.circle") }
    @ObservedObject private var s_utils = gs.utils()
    
    public enum Tab: String, CaseIterable, Identifiable {
        case destinations
        case home
        case create

        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $s_utils.tab) {
                
                LocalLocationSearchServiceView().tabItem {
                    Label(Tab.destinations.rawValue.capitalized, systemImage: "airplane")
                }.tag(Tab.destinations).onAppear { gs.dispatch(.Paginate, ContentView.Tab.destinations) }
                
                SplashView().tabItem {
                    Label(Tab.home.rawValue.capitalized, systemImage: "star.fill")
                }.tag(Tab.home).onAppear { gs.dispatch(.Paginate, ContentView.Tab.home) }
                
            }
            .font(.headline)
            .navigationTitle($s_utils.tab.wrappedValue.rawValue.capitalized)
            .toolbar { $s_utils.tabContent.wrappedValue }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
