//
//  FilterButton.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 27/06/2022.
//

import SwiftUI

struct FilterButton: View {
    
    var isFitlering:Bool
    var action:() -> ()
    
    
    private var text:String {
        if isFitlering {
            return "Filter active"
        } else {
            return "Filter"
        }
    }
    
    private var color:Color {
        if isFitlering {
            return Color("floatingButtonHighlightedBackground")
        } else {
            return Color("floatingButtonBackground")
        }
    }
    
    private var image:Image {
        if isFitlering {
            return Image("icon/checkmark")
        } else {
            return Image("icon/scooter")
        }
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                image
                Text(text)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            .padding(13)
            .background(color)
            .cornerRadius(25)
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(isFitlering: false) {
            //
        }
    }
}
