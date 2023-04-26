import SwiftUI
import MessageUI
import FirebaseDynamicLinks

struct QRCodeView: View {
    @Binding var qrCodeURL: String

    private let pdfModel = PDFModel()

    var body: some View {
        ZStack {
            GradientBackground()
            VStack(spacing: 20) {
                Text(K.Labels.qrLabel)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .kerning(2)

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
                            qrCodeURL = "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)"
                        }
                    }
                case .failure(let error):
                    print("Error uploading PDF: \(error.localizedDescription)")
                }
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
