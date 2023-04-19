//
//  ContentView.swift
//  OiBoi-Card-iOS13
//
//  Created by Omer Ifrah on 4/9/23.
//
import SwiftUI
import ContactsUI
import SwiftUI
import ContactsUI

struct ContentView: View {
    // State property to track the scale of the profile image.
    @State private var scale: CGFloat = 1.0
    
    // State object for the contact information.
    @StateObject private var contactViewModel = ContactViewModel()
    
    var body: some View {
        // Main navigation view.
        NavigationView {
            // Background gradient for the view.
            ZStack {
                GradientBackground()
                
                // Main content of the view.
                VStack(spacing: 20) {
                    // Profile image.
                    Image(K.Info.photoName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.white.opacity(0.5), lineWidth: 4)
                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
                        .scaleEffect(scale)
                        .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true), value: scale)
                        .onAppear {
                            scale = 1.05
                        }
                    
                    // Name label.
                    Text("\(K.Info.firstName) \(K.Info.lastName)")
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .kerning(2)
                    
                    // Role title label.
                    Text(K.Info.roleTitle)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    
                    // Divider line.
                    Divider()
                        .background(Color.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                    
                    // Phone number contact info.
                    ContactInfoView(label: "Phone", value: K.Info.phoneNumber, symbol: K.Logos.phone)
                    
                    // Email address contact info.
                    ContactInfoView(label: "Email", value: K.Info.emailAddress, symbol: K.Logos.email)
                    
                    // QR code link.
                    NavigationLink(destination: QRCodeView(value: K.Links.website)) {
                        Image(systemName: K.Logos.qr)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }.padding(.top, 20)
                    
                    // Add to contacts button.
                    NavigationLink(destination: AddContactView(contact: contactViewModel.contact)) {
                        Text("Add to Contacts")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                    .buttonStyle(CapsuleButtonStyle())
                    .padding(.top, 20)
                }
                .padding(.top, 100)
                .padding(.horizontal, 20)
                .scaledToFit()
            }
            .navigationBarHidden(true)
        }
    }
}

//MARK: - Gradient Background
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

// MARK: - CapsuleButtonStyle
struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 40)
            .padding(.vertical, 12)
            .background(Capsule().fill(Color.white.opacity(0.2)))
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

//MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
