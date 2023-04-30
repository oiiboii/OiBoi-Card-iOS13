//
//  ContactInfoView.swift
//  OneCard-iOS
//
//  Created by Omer Ifrah on 4/26/23.
//
import SwiftUI

struct ContactInfoView: View {
    let label: String
    let value: String
    let symbol: String

    var body: some View {
        VStack {
            Button(action: {
                UIPasteboard.general.string = value
            }) {
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 40)
                    HStack(spacing: 20) {
                        Image(systemName: symbol)
                            .foregroundColor(.white)

                        Text(value)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                    }
                }
            }
        }
    }
}
