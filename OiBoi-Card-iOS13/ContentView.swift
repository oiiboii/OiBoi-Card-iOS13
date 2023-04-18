//
//  ContentView.swift
//  OiBoi-Card-iOS13
//
//  Created by Omer Ifrah on 4/7/23.
//

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
        let fontColor = UIColor(red: 0.50, green: 0.55, blue: 0.55, alpha: 1.00)
        

         ZStack{
             GradientBackground()
             ZStack {
                 // Background View
                 Color(systemGray)
                     .cornerRadius(30)
                     .frame(height: UIScreen.main.bounds.height / 2 + 150)
                     .offset(y: UIScreen.main.bounds.height / 4 - 25)

                 VStack {
                     Image("oiboi_photo")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 200)
                         .clipShape(Circle())
                         .overlay(Circle()
                             .stroke(Color(red: 1 , green: 1, blue: 1), lineWidth: 5))
                     
                     Text("Omer Ifrah")
                         .font(Font.custom("Carter One", size: 50))
                         .foregroundColor(Color(fontColor))

                     Text("iOS Developer")
                         .foregroundColor(Color(fontColor))
                         .bold()
                         .font(.system(size: 20  ))
                     Divider()
                     Capsule()
                         .fill( .white)
                         .frame(height: 45.0)
                     
                 }
                 .padding()
             }
         }
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }
