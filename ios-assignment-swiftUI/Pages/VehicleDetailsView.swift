//
//  VehicleDetailsView.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 27/06/2022.
//

import SwiftUI

struct VehicleDetailsView: View {
    
    @EnvironmentObject var stateManager:StateManager
    @ObservedObject var viewModel:ViewModel
    
    init(_ vehicle:Vehicle) {
        self.viewModel = ViewModel(vehicle)
    }
    
    var detailView:some View {
        Group {
            if let uiImage = viewModel.qrImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(viewModel.vehicle.identificationCode)
                    .font(.title)
                    .bold()
                    .padding()
                GeometryReader { proxy in
                    detailView
                        .frame(width: proxy.size.width, height: proxy.size.width)
                }
                Spacer()
                
            }
            .padding()
            VStack {
                HStack {
                    Spacer()
                    Button {
                        stateManager.shouldShowVehicleDetails = false
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

extension VehicleDetailsView {
    
    class ViewModel:ObservableObject {
        
        var vehicle:Vehicle
        @Published var qrImage:UIImage?
        
        
        //MARK: - init
        
        init(_ vehicle:Vehicle) {
            self.vehicle = vehicle
            //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.downloadQRCodeImage()
            //}
        }
        
        //MARK: - Utils
        
        private func downloadQRCodeImage() {
            guard let url = URL(string: vehicle.qrURL),
            let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.qrImage = image
            }
        }
        
    }
}

struct VehicleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let vehicle = DottVehicle(qrURL: "fejdkzzdo", color: "BlueRed", identificationCode: "KMN-PO6")
        VehicleDetailsView(vehicle)
    }
}
