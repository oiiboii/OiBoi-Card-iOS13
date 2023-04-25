//
//  QRCodeView.swift
//  OneCard-iOS
//
//  Created by Omer Ifrah on 4/9/23.

import SwiftUI

struct QRCodeView: View {
    // The string value to generate the QR code from.
    @Binding var qrCodeURL: String

    // The PDFModel instance
    private let pdfModel = PDFModel()
    
    // The body of the view, which defines the layout and content of the view.
    var body: some View {
        ZStack {
            // The background gradient for the view.
            GradientBackground()

            // The content of the view, which includes the label and the QR code image.
            VStack(spacing: 20) {
                // The label for the QR code.
                Text(K.Labels.qrLabel)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .kerning(2)

                // The QR code image generated from the given value.
                Image(uiImage: generateQRCode(from: qrCodeURL))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            }.onAppear {
                generateAndUpdateQRCodeURL()
            }
        }
    }
    private func generateAndUpdateQRCodeURL() {
        if let pdfData = pdfModel.generatePDF() {
            pdfModel.uploadPDF(data: pdfData) { result in
                switch result {
                case .success(let urlString):
                    qrCodeURL = urlString
                case .failure(let error):
                    print("Error uploading PDF: \(error.localizedDescription)")
                }
            }
        }
    }

    // Private method to generate a QR code image from a given string value.
    private func generateQRCode(from string: String) -> UIImage {
        // Convert the string to a Data object.
        let data = Data(string.utf8)

        // Create a Core Image context to generate the QR code image.
        let context = CIContext()

        // Create a CIFilter object with the "CIQRCodeGenerator" filter name.
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            // Set the input message of the filter to the data object.
            filter.setValue(data, forKey: "inputMessage")

            // Generate the QR code image from the filter output image.
            if let outputImage = filter.outputImage {
                if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                    // Return the QR code image as a UIImage object.
                    return UIImage(cgImage: cgImage)
                }
            }
        }

        // If the QR code image could not be generated, return a default error image.
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
