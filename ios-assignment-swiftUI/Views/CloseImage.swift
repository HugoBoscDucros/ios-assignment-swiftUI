//
//  CloseImage.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 27/06/2022.
//

import SwiftUI

struct CloseImage: View {
    var body: some View {
        Image("icon/cross")
            .padding(1)
            .background(Color("closeButtonBackground"))
            .cornerRadius(10)
    }
}

struct CloseImage_Previews: PreviewProvider {
    static var previews: some View {
        CloseImage()
    }
}
