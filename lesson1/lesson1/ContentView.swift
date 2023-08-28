//
//  ContentView.swift
//  lesson1
//
//  Created by Jack Xia on 28/08/2023.
//

import SwiftUI

struct ContentView: View {
    // Struct of a View that returns mixed View modifiers
    var body: some View {
        // ZStack === z-index
        // return is implicit
        ZStack {
            Color(.systemTeal)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("Hello Xcode")
                        .font(.largeTitle)
                        .bold()
                        .padding(.  all)
                }
                .border(.black)
                
                Spacer()
                
                // Image will look at Assets folder
                ScrollView(.horizontal) {
                    HStack {
                        // how to access subfolder?
                        MyImageView(pic: "stream")
                        MyImageView(pic: "java")
                        MyImageView(pic: "linux")
                        MyImageView(pic: "java")
                        MyImageView(pic: "bash")
                        MyImageView(pic: "android")
                        MyImageView(pic: "c")
                        MyImageView(pic: "react")
                        MyImageView(pic: "ts")
                    }
                }
                .border(.black)
                
                Spacer()
                
                HStack {
                    VStack(content: {
                        MyTextView(message: "x")
                        MyTextView(message: "x")
                        MyTextView(message: "x")
                    })
                    Spacer()
                    VStack(content: {
                        Color(.red)
                        Color(.green)
                        Color(.blue)
                    })
                    .frame(width: 100, height: 50)
                    Spacer()
                    VStack(content: {
                        MyTextView(message: "o")
                        MyTextView(message: "o")
                        MyTextView(message: "o")
                    })
                }
                
                VStack(content: {
                    MyTextView(message: "SwiftUI")
                })
            
            }
        }
        
    }
    
}



// Refactored structs( struct is similar to constructor )
struct MyTextView: View {
    var message: String
    
    var body: some View {
        
        Text(message)
            .font(.title)
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
    }
}
struct MyImageView: View {
    var pic: String
    var body: some View {
        Image(pic)
            .resizable().aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 200, alignment: .center)
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}


