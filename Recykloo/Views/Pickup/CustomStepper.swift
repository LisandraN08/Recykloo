//
//  CustomStepper.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 20/07/24.
//

import SwiftUI

import SwiftUI

struct CustomStepper: View {
    @Binding var digitData: Double

    var body: some View {
        HStack(spacing: 15) {
            Button {
                if digitData > 0 {
                    digitData -= 0.5
                }
            } label: {
                Image(systemName: "minus.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(Color("Ijo"))
            }
            Text("\(digitData, specifier: "%.1f") kg")
                .font(.system(size: 14, weight: .medium))
            Button {
                digitData += 0.5
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(Color("Ijo"))
            }
        }
        .padding(8)
        .background(Color("Ijo").opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}
