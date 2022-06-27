//
//  ContentView.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 26/06/2022.
//

import SwiftUI

struct FleetView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject var stateManager:StateManager
    @ObservedObject var viewModel = ViewModel()
    
    var subview: some View {
        Group {
            if viewModel.vehicles.count > 0 {
                List(viewModel.dottVehicles) { vehicle in
                    VehicleRow(vehicle: vehicle)
                        .onTapGesture {
                            assignmentCore.removeDataObserver()
                            viewModel.selectedVehicle = vehicle
                            stateManager.shouldShowVehicleDetails = true
                            
                        }
                }
                .listStyle(.plain)
                .background(.clear)
                .padding(.bottom, safeAreaInsets.bottom)
            } else {
                VStack {
                    Text("Loading data... 🛴")
                    ProgressView()
                        .padding()
                    Text(viewModel.errorText)
                }
                .padding()
            }
        }
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            HStack {
                Spacer()
                Image("brand/shapes/yellowArc")
                    .padding()
                    .scaleEffect(1.3)
            }
            .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Fleet overview")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding()
                .padding(.top, 100)
                .padding(.bottom, 30)
                subview
            }
            VStack {
                Spacer()
                FilterButton(isFitlering: viewModel.isFiltering) {
                    assignmentCore.removeDataObserver()
                    stateManager.shouldShowFilters = true
                }
                .padding(.bottom, 16)
            }
        }
        .sheet(isPresented: $stateManager.shouldShowFilters) {
            assignmentCore.set(dataObserver: viewModel)
        } content: {
            FiltersView()
        }
        .sheet(isPresented: $stateManager.shouldShowVehicleDetails) {
            assignmentCore.set(dataObserver: viewModel)
        } content: {
            VehicleDetailsView(viewModel.selectedVehicle!)
        }

    }
}

extension DottVehicle:Identifiable {
    public var id:String {
        return identificationCode
    }
}


extension FleetView {
    class ViewModel:ObservableObject, DataSyncObserver, FileringObserver {
        
        @Published var vehicles = [Vehicle]()
        @Published var filters = Set<ColorTag>()
        @Published var errors = [Error]()
        
        var selectedVehicle:Vehicle? = nil
        
        
        var dottVehicles:[DottVehicle] {
            return vehicles as? [DottVehicle] ?? [DottVehicle]()
        }
        
        var isFiltering:Bool {
            return ColorTag.allCases.count > filters.count
        }
        
        var errorText:String {
            guard let error = errors.last else {return ""}
            var text = "Something went wrong fetching data:\n\n\(error.localizedDescription)\n\nlet's try again"
            if errors.count > 0 {
                text += ", attempts n°\(errors.count)"
            }
            text += "..."
            return text
        }
        
        
        init() {
            assignmentCore.set(dataObserver: self)
            assignmentCore.set(filteringObserver: self)
        }
        
        //MARK: - DataSyncObserver
        
        func didUpdate(_ vehicles: [Vehicle]) {
            self.vehicles = vehicles
        }
        
        func didFailUpdateData(_ error: Error) {
            self.errors.append(error)
        }
        
        
        //MARK: - FilteringObserver
        
        func didUpdate(_ filters: Set<ColorTag>) {
            self.filters = filters
        }
        
    }
}



struct FleetView_Previews: PreviewProvider {
    static var previews: some View {
        FleetView()
    }
}
