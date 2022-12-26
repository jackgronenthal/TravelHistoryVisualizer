//
//  SearchBarView.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/25/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @ObservedObject var s_localLocationSearchService = gs.locationSearchService();
    var header:String;
    
    var body: some View {
        VStack {
            if self.header.count > 0 {
                HStack {
                    Text("**\(header)**")
                    Spacer()
                }
            }
            HStack {
                Group {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 5)
                    TextField("Search Country, City, Airport Code...", text: $s_localLocationSearchService.iataCode)
                }.foregroundColor(Color(UIColor.secondaryLabel))
            }
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color(UIColor.systemFill)))
            
        }.padding(.horizontal)
    }
}



struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(header: "Destination")
    }
}
