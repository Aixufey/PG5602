//
//  CardView.swift
//  exe3
//
//  Created by Jack Xia on 06/09/2023.
//

import SwiftUI

struct CardView: View {
    var tag = ""
    var img = ""
    var fName = ""
    var lName = ""
    var desc = ""
    
    
    
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ZStack {
                    Image(img)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.gray, lineWidth: 2))
                    Text(tag)
                        .font(.system(size: 85))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .offset(x: 0, y: -95)
                }
                
                HStack {
                    Text(String(fName).capitalized)
                    Text(String(lName).capitalized)
                }.font(.system(size: 28))
                Text(desc).italic()
            }
            
            Spacer()
            
        }.frame(width: 250, height: 800)
            .cornerRadius(20)
            .shadow(radius: 20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(tag: "⚠️",img: "coder", fName: "Test", lName: "test", desc: "desc")
    }
}
