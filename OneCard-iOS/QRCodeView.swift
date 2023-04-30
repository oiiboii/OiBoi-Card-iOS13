//
//  QRCodeView.swift
//  OneCard-iOS
//
//  Created by Omer Ifrah on 4/9/23.

import SwiftUI

struct QRCodeView: View {
    @StateObject private var viewModel = QRCodeViewModel()

    var body: some View {
        ZStack {
            GradientBackground()
            VStack(spacing: 20) {
                Text(K.Labels.qrLabel)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .kerning(2)

                Image(uiImage: generateQRCode(from: viewModel.qrCodeURL))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.5), lineWidth: 4))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
            }.onAppear {
                viewModel.generateAndUpdateQRCodeURL()
            }
        }
    }

    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        let context = CIContext()

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")

            if let outputImage = filter.outputImage {
                if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
