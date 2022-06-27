//
//  FiltersView.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 27/06/2022.
//

import SwiftUI

extension ColorTag:Identifiable {
    
    public var id:String {
        return rawValue
    }
    
    var description:String {
        switch self {
        case .blueRed: return "Blue / Red"
        case .redGreen: return "Red / Green"
        case .pinkYellow: return "Pink / Yellow"
        case .yellowBlue: return "Yellow / Blue"
        case .unknown: return "Unknown"
        }
    }
}

struct FiltersView: View {
    
    @EnvironmentObject var stateManager:StateManager
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing:25) {
                Text("Filters")
                    .font(.title)
                    .bold()
                Toggle(ColorTag.redGreen.description, isOn: $viewModel.redGreenIsOn)
                Toggle(ColorTag.blueRed.description, isOn: $viewModel.blueRedIsOn)
                Toggle(ColorTag.pinkYellow.description, isOn: $viewModel.pinkYellowIsOn)
                Toggle(ColorTag.yellowBlue.description, isOn: $viewModel.yellowBlueIsOn)
                Spacer()
                Button {
                    viewModel.updateFilters()
                    stateManager.shouldShowFilters = false
                } label: {
                    Text("Apply fliter")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity, maxHeight: 50)
                        .background(Color("constructiveButtonBackground"))
                        .cornerRadius(10)
                }
            }
            .padding()
            VStack {
                HStack {
                    Spacer()
                    Button {
                        stateManager.shouldShowFilters = false
                    } label: {
                        CloseImage()
                    }
                }
                Spacer()
            }
            .padding()
        }
        
    }
    
}


extension FiltersView {
    class ViewModel:ObservableObject {
        
        @Published var blueRedIsOn:Bool = false
        @Published var redGreenIsOn:Bool = false
        @Published var pinkYellowIsOn:Bool = false
        @Published var yellowBlueIsOn:Bool = false
        
        init() {
            synchroniseOnOff(assignmentCore.vehicleService.filteringColorTags)
        }
        
        private func synchroniseOnOff(_ filters:Set<ColorTag>) {
            blueRedIsOn = filters.contains(.blueRed)
            redGreenIsOn = filters.contains(.redGreen)
            pinkYellowIsOn = filters.contains(.pinkYellow)
            yellowBlueIsOn = filters.contains(.yellowBlue)
        }
        
        private func getFilterSet() -> Set<ColorTag> {
            var tags = Set<ColorTag>()
            tags.update(with: .unknown)
            if blueRedIsOn {
                tags.update(with: .blueRed)
            }
            if redGreenIsOn {
                tags.update(with: .redGreen)
            }
            if pinkYellowIsOn {
                tags.update(with: .pinkYellow)
            }
            if yellowBlueIsOn {
                tags.update(with: .yellowBlue)
            }
            return tags
        }
        
        func updateFilters() {
            let filters = getFilterSet()
            assignmentCore.vehicleService.update(filteringColorTags: filters)
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}
