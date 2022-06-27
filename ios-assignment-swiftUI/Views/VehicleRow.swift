//
//  VehicleRow.swift
//  ios-assignment-swiftUI
//
//  Created by Hugo Bosc-Ducros on 26/06/2022.
//

import SwiftUI

struct VehicleRow: View {
    
    var vehicle:Vehicle
    
    var body: some View {
        HStack {
            Text(vehicle.identificationCode)
                .fontWeight(.medium)
                .padding(8)
            Spacer()
            vehicle.colorTag.image
                .padding(8)
        }
    }
}

struct VehicleRow_Previews: PreviewProvider {
    static var previews: some View {
        let vehicle = DottVehicle(qrURL: "fdfzez", color: "BlueRed", identificationCode: "K11-L4M")
        VehicleRow(vehicle: vehicle)
    }
}
