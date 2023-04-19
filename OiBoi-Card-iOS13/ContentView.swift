import SwiftUI

struct GradientBackground: View {
    var body: some View {
        let colors = [Color(UIColor.systemTeal),
                      Color(UIColor.systemBlue),
                      Color(UIColor.systemIndigo)]
        
        let gradient = LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
        
        return gradient
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    @State private var scale: CGFloat = 1.0

     var body: some View {
         ZStack {
             GradientBackground()
             
             VStack(spacing: 20) {
                 Image("profile_photo")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 150)
                     .clipShape(Circle())
                     .overlay(Circle()
                         .stroke(Color.white.opacity(0.5), lineWidth: 4)
                     ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
                     .scaleEffect(scale)
                     .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: scale)
                     .onAppear {
                         scale = 1.1
                     }
                
                Text("Omer Ifrah")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .kerning(2)
                
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                
                Text("Creating beautiful and functional iOS apps.")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Divider()
                    .background(Color.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                
                ContactInfoView(label: "Phone", value: "+1 (631) 946-9190")
                ContactInfoView(label: "Email", value: "oi38@cornell.edu")
                
                HStack(spacing: 30) {
                    SocialMediaButton(iconName: "logo-twitter", url: "https://twitter.com/username")
                    SocialMediaButton(iconName: "logo-linkedin", url: "https://www.linkedin.com/in/username")
                    SocialMediaButton(iconName: "logo-github", url: "https://github.com/username")
                }.padding(.top, 20)
                
                QRCodeView(value: "https://www.example.com/JohnDoe")
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)
            }
            .padding(.top, 100)
            .padding(.horizontal, 20)
            .scaledToFit()
        }
    }
}

struct ContactInfoView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .fontWeight(.medium)
            
            ZStack{
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 40)
                Text(value)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .fontWeight(.regular)
            }
        }
    }
}

struct QRCodeView: View {
    let value: String
    
    var body: some View {
        Image(uiImage: generateQRCode(from: value))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
    }
    private func generateQRCode(from string: String) -> UIImage {
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
struct SocialMediaButton: View {
    let iconName: String
    let url: String
    
    var body: some View {
        Button(action: {
            if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }) {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
