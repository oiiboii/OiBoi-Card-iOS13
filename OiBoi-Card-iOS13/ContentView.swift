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
    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 20) {
                Image("oiboi_photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.white.opacity(0.5), lineWidth: 4)
                    ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
                
                Text("Omer Ifrah")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .kerning(2)
                
                Text("Product Engineer")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                
                Divider()
                    .background(Color.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                
                ContactInfoView(label: "Phone", value: "+1 (631) 946 9190")
                ContactInfoView(label: "Email", value: "oi38@cornell.edu")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
