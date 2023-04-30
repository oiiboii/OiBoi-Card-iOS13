//
//  QRCodeViewModel.swift
//  OneCard-iOS
//
//  Created by Omer Ifrah on 4/26/23.
//

// QRCodeViewModel.swift

import SwiftUI
import FirebaseDynamicLinks

class QRCodeViewModel: ObservableObject {
    @Published var qrCodeURL: String = ""
    private let pdfModel = PDFModel()

    func generateAndUpdateQRCodeURL() {
        if let pdfData = pdfModel.generatePDF() {
            pdfModel.uploadPDF(data: pdfData) { result in
                switch result {
                case .success(let urlString):
                    let components = DynamicLinkComponents(link: URL(string: urlString)!, domainURIPrefix: "https://oiboi.page.link")
                    let options = DynamicLinkComponentsOptions()
                    options.pathLength = .short
                    components!.options = options
                    
                    components!.shorten { (shortURL, warnings, error) in
                        if let error = error {
                            print("Error shortening URL: \(error.localizedDescription)")
                        } else if let shortURLString = shortURL?.absoluteString {
                            let email = K.Info.emailAddress
                            let subject = "It was nice meeting you today \(K.Info.firstName)!"
                            let body = "Hi \(K.Info.firstName),\nGreat meeting you today. I appreciate the app you built to streamline our communication \nPlease follow up with your resume! P.S. Thanks for providing a link to download a PDF with your personal info: \(shortURLString)"
                            let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            self.qrCodeURL = "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)"
                        }
                    }
                case .failure(let error):
                    print("Error uploading PDF: \(error.localizedDescription)")
                }
            }
        }
    }
}
