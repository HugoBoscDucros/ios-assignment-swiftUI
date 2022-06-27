//
//  ios_assignment_swiftUIApp.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 26/06/2022.
//

import SwiftUI

let assignmentCore = AssignmentCore()

@main
struct ios_assignment_swiftUIApp: App {
    
    var stateManager = StateManager()
    
    var body: some Scene {
        WindowGroup {
            FleetView()
                .environmentObject(stateManager)
        }
    }
}
