//
//  ContentView.swift
//  VisitCard
//
//  Created by Jack Xia on 29/08/2023.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        ZStack {
            
            // https://www.uicolor.io/
            Color(red: 0.51, green: 0.58, blue: 0.65, opacity: 1.00)
                .ignoresSafeArea(.all)
            
            // Add Font + target Membership
            // Click Project name -> Targets -> Info -> Custom iOS Target Properties -> "Fonts provided by application"
            // Add Font name
            VStack {
                Image("notion")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.black,
                                        lineWidth: 5)
                    )
                
                Text("Sparrow at seas")
                    .font(Font.custom("QwitcherGrypen-Regular", size: 60))
                    .bold()
                    .foregroundColor(.black)
                
                Text("iOS Developer")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                
                Divider()
                
                InfoView(text: "+44 123 456 789", imageName: "phone.fill")
                InfoView(text: "writeme@gmail.com", imageName: "paperplane.fill")
                
            }
        }
    }
}

























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
