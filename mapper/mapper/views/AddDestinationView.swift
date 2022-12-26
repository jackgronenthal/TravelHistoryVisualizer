//
//  AddDestinationSheetview.swift
//  mapper
//
//  Created by Jack Gronenthal on 12/25/22.
//

import SwiftUI

struct AddDestinationSheetview: View {
    
    var body: some View {
        VStack {
            Text("Add a destination.").foregroundColor(Color(UIColor.secondaryLabel)).frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal)
            AddDestinationButton()
            Spacer()
        }.background(Color(UIColor.secondarySystemBackground))
    }
}

struct AddDestinationSheetview_Previews: PreviewProvider {
    static var previews: some View {
        AddDestinationSheetview()
        Group {
            AddDestinationSheetview().preferredColorScheme(.dark)
        }
    }
}

struct AddDestinationButton: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            Spacer()
            Group {
                Image(systemName: "plus.circle.fill")
                Text("Add Destination")
            }
            .foregroundColor(Color(UIColor.systemBlue))
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 17).fill(getColor(colorScheme: colorScheme)))
        .padding(.horizontal)
    }
    
    private func getColor(colorScheme:ColorScheme) -> Color {
        let lightBackground = Color(red: 226/255, green: 230/255, blue: 245/255)
        let darkBackground = Color(red: 0.063, green: 0.114, blue: 0.231)
        
        return colorScheme == .light ? lightBackground : darkBackground
    }
}
