//
//  SateManager.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 27/06/2022.
//

import Foundation

class StateManager:ObservableObject {
    
    @Published var shouldShowVehicleDetails:Bool = false
    @Published var shouldShowFilters:Bool = false
    
}
