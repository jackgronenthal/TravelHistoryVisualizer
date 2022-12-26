//
//  UtilsViewModel.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/24/22.
//

import Foundation
import SwiftUI

final class UtilsViewModel : Store, ObservableObject {
    
    @Published var tabContent : Button<Image>? = nil
    @Published var tab:ContentView.Tab = .home
    
    private func setTab(newTab:ContentView.Tab) {
        self.tab = newTab;
        
        func setTabContent() {
            print("newTab: \(newTab)")
            switch newTab {
            case .destinations: gs.dispatchWithReducer(.SetNavigationViewToolBar, .LocationSearchService)
            case .create: fallthrough
            case .home: self.tabContent = nil
            }
        }
        
        setTabContent()
    }
    
    private func setToolBar(contents newTabContents:Button<Image>) {
        self.tabContent = newTabContents
    }
    
    func reduce(_ details: ActionDetails) {
        switch details.action {
        case .Paginate: setTab(newTab: (details.payload as! ContentView.Tab))
        case .SetNavigationViewToolBar: self.setToolBar(contents: details.payload as! Button<Image>)
        default: return
        }
    }
}
