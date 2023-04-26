//
//  PDFModel.swift
//  OneCard-iOS
//
//  Created by Omer Ifrah on 4/25/23.
//

import Foundation
import PDFKit
import FirebaseStorage

struct PDFModel {
    //MARK: - pdf generator
    func generatePDF() -> Data? {
        let pdfMetaData = [
            kCGPDFContextCreator: "Your App",
            kCGPDFContextAuthor: "\(K.Info.firstName) \(K.Info.lastName)"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let pageSize = CGSize(width: 612, height: 792)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            drawPDFElements(context: context.cgContext, pageSize: pageSize)
        }
        
        return data
    }
    //MARK: - draw elements
    func drawPDFElements(context: CGContext, pageSize: CGSize) {
        let titleFont = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        let textFont = UIFont.systemFont(ofSize: 24.0, weight: .regular)
        let buttonFont = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .foregroundColor: UIColor.white
        ]
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: UIColor.white
        ]

        
        let pageRect = CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)
        let gradientColors = [UIColor.blue.cgColor, UIColor.systemBlue.cgColor]
        
        // Draw the gradient background
        drawGradientBackground(context: context, rect: pageRect, colors: gradientColors, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: pageRect.width, y: pageRect.height))
        
        // Draw the rest of the content
        let title = "\(K.Info.firstName) \(K.Info.lastName)"
        title.draw(at: CGPoint(x: pageSize.width * 0.5 - title.size(withAttributes: titleAttributes).width * 0.5, y: pageSize.height * 0.25), withAttributes: titleAttributes)
        
        let roleTitle = K.Info.roleTitle
        roleTitle.draw(at: CGPoint(x: pageSize.width * 0.5 - roleTitle.size(withAttributes: attributes).width * 0.5, y: pageSize.height * 0.35), withAttributes: attributes)
        
        let dividerRect = CGRect(x: pageSize.width * 0.25, y: pageSize.height * 0.45, width: pageSize.width * 0.5, height: 1)
        drawDivider(context: context, rect: dividerRect, color: UIColor.white)
        
        let phoneNumber = "Phone: \(K.Info.phoneNumber)"
        phoneNumber.draw(at: CGPoint(x: pageSize.width * 0.5 - phoneNumber.size(withAttributes: attributes).width * 0.5, y: pageSize.height * 0.55), withAttributes: attributes)
        
        let email = "Email: \(K.Info.emailAddress)"
        email.draw(at: CGPoint(x: pageSize.width * 0.5 - email.size(withAttributes: attributes).width *
                               0.5, y: pageSize.height * 0.65), withAttributes: attributes)
        
        
        // Draw the picture
        let image = UIImage(named: K.Info.photoName)
        let imageSize = CGSize(width: 100, height: 100)
        let imageRect = CGRect(x: (pageSize.width - imageSize.width) / 2, y: (pageSize.height * 0.1), width: imageSize.width, height: imageSize.height)
        drawCircularImage(context: context, image: image!, rect: imageRect, fillColor: UIColor.clear, strokeColor: UIColor.white.withAlphaComponent(0.5), lineWidth: 4)
    }
    
    // Function to draw gradient background
    func drawGradientBackground(context: CGContext, rect: CGRect, colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)!
        context.saveGState()
        context.addRect(rect)
        context.clip()
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        context.restoreGState()
    }
    
    // Function to draw divider
    func drawDivider(context: CGContext, rect: CGRect, color: UIColor) {
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(rect.height)
        context.move(to: CGPoint(x: rect.minX, y: rect.midY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        context.strokePath()
    }
    
    // Function to draw circle
    func drawCircularImage(context: CGContext, image: UIImage, rect: CGRect, fillColor: UIColor, strokeColor: UIColor, lineWidth: CGFloat) {
        let circlePath = UIBezierPath(ovalIn: rect)
        circlePath.addClip()
        image.draw(in: rect)

        // Stroke around the picture
        circlePath.lineWidth = 4
        UIColor.white.setStroke()
        circlePath.stroke()
    }
    
    func uploadPDF(data: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let pdfRef = storageRef.child("contact_info.pdf")
        
        let _ = pdfRef.putData(data, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
            } else {
                pdfRef.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url.absoluteString))
                    } else {
                        completion(.failure(NSError(domain: "Download URL Error", code: -1, userInfo: nil)))
                    }
                }
            }
        }
    }
}

