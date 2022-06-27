//
//  ColorTag+Extension.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 26/06/2022.
//

import Foundation
import SwiftUI

extension ColorTag {
    var image:Image? {
        switch self {
        case .redGreen: return Image("icon/redGreenScooter")
        case .blueRed: return Image("icon/blueRedScooter")
        case .pinkYellow: return Image("icon/pinkYellowScooter")
        case .yellowBlue: return Image("icon/yellowBlueScooter")
        case .unknown: return nil
        }
    }
}
