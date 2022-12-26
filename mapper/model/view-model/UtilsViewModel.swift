//
//  UtilsViewModel.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation
import SwiftUI
import Combine

final class UtilsViewModel : Store, ObservableObject {
    
    @Published var tabContent : Any? = nil
    @Published var tab:ContentView.Tab = .home
    @Published var isDestinationPagePresented = false
    
    public static let toolbar = Button(action: { print(gs.dispatch(.ToggleDestinationModal, nil)) }) {
        Image(systemName: "plus")
    }

    private func setTab(newTab:ContentView.Tab) {
        self.tab = newTab;
        
        func setTabContent() {
            print("newTab: \(newTab)")
            switch newTab {
            case .destinations: tabContent = LocalLocationSearchServiceViewModel.toolbar
            case .create: fallthrough
            case .home: tabContent = UtilsViewModel.toolbar
            }
        }
        
        setTabContent()
    }
    
    private func setToolBar(contents newTabContents:Button<Image>) { self.tabContent = newTabContents }
    private func toggleDestinationModal(isPresented:Bool) { isDestinationPagePresented = isPresented }
    
    func reduce(_ details: ActionDetails) {
        switch details.action {
        case .Paginate: setTab(newTab: (details.payload as! ContentView.Tab))
        case .SetNavigationViewToolBar: self.setToolBar(contents: details.payload as! Button<Image>)
        case .ToggleDestinationModal: self.toggleDestinationModal(isPresented: details.payload as! Bool)
        default: return
        }
    }
}
