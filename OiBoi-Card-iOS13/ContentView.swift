import SwiftUI

struct GradientBackground: View {
    var body: some View {
        let colors = [Color(UIColor(red: 0.97, green: 0.15, blue: 0.52, alpha: 1.00)),
                      Color(UIColor(red: 0.45, green: 0.04, blue: 0.72, alpha: 1.00)),
                      Color(UIColor(red: 0.23, green: 0.05, blue: 0.64, alpha: 1.00)),
                      Color(UIColor(red: 0.26, green: 0.38, blue: 0.93, alpha: 1.00)),
                      Color(UIColor(red: 0.30, green: 0.79, blue: 0.94, alpha: 1.00))
                     ]
        
        let gradient = LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
        
        return gradient
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    var body: some View {
        let systemGray = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.00)
        //        let fontColor = UIColor(red: 0.50, green: 0.55, blue: 0.55, alpha: 1.00)
        let darkSystem = UIColor(red: 0.18, green: 0.20, blue: 0.21, alpha: 1.00)
        let darkPurple = Color(UIColor(red: 0.23, green: 0.05, blue: 0.64, alpha: 1.00))
        ZStack {
            GradientBackground()

                ZStack {
                    // Background View
                    Color(systemGray)
                        .cornerRadius(30)
                        .frame(height: UIScreen.main.bounds.height / 2 + 150)
                        .offset(y: UIScreen.main.bounds.height / 4 - 75)
                        .opacity(0.8)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -4)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        
                        Image("oiboi_photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                            .clipShape(Circle())
                            .overlay(Circle()
                                .stroke(Color(red: 1 , green: 1, blue: 1)
                                    .opacity(0.5), lineWidth: 1)
                            ).shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                        
                        
                        Text("Omer Ifrah")
                            .font(.system(size: 40))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(darkSystem))
                            .textCase(.uppercase)
                            .opacity(0.85)
                            .kerning(5)
                        
                        Text("iOS Developer\n")
                            .foregroundColor(Color(darkSystem))
                            .font(.system(size: 20))
                            .opacity(0.85)
                        Divider()
                            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
                        ZStack{
                            Capsule()
                                .fill(Color(systemGray))
                                .frame(height: 45.0)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                            Text(verbatim: "+1 (631) 946 9190")
                                .foregroundColor(Color(darkSystem))
                                .font(.system(size: 18))
                                .fontWeight(.regular)
                        }
                        ZStack{
                            Capsule()
                                .fill(Color(systemGray))
                                .frame(height: 45.0)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                            Text(verbatim: "oi38@cornell.edu")
                                .foregroundColor(Color(darkSystem))
                                .font(.system(size: 18))
                                .fontWeight(.regular)

                        }
                    }
                    .padding().scaledToFit()
                }
            }
            
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
