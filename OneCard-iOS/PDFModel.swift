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
    func generatePDF() -> Data? {
        let pdfMetaData = [
            kCGPDFContextCreator: "Your App",
            kCGPDFContextAuthor: "\(K.Info.firstName) \(K.Info.lastName)"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            let titleFont = UIFont.systemFont(ofSize: 36.0, weight: .bold)
            let textFont = UIFont.systemFont(ofSize: 24.0, weight: .regular)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: textFont,
                .foregroundColor: UIColor.black
            ]
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: titleFont,
                .foregroundColor: UIColor.black
            ]
            
            let title = "\(K.Info.firstName) \(K.Info.lastName)"
            title.draw(at: CGPoint(x: 40, y: 40), withAttributes: titleAttributes)
            
            let phoneNumber = "Phone: \(K.Info.phoneNumber)"
            phoneNumber.draw(at: CGPoint(x: 40, y: 90), withAttributes: attributes)
            
            let email = "Email: \(K.Info.emailAddress)"
            email.draw(at: CGPoint(x: 40, y: 120), withAttributes: attributes)
        }
        
        return data
    }
    
    func uploadPDF(data: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let pdfRef = storageRef.child("contact_info.pdf")
        
        let uploadTask = pdfRef.putData(data, metadata: nil) { metadata, error in
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
