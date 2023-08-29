//
//  ContentView.swift
//  lesson2
//
//  Created by Jack Xia on 29/08/2023.
//

import SwiftUI


// enum for types
enum SystemImage: String {
    case pencil
    case globe
    case pencilTip = "pencil.tip"
}

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color("farge")
                .ignoresSafeArea()
            
            ScrollView(.horizontal) {
                HStack {
                    Image("coffee2")
                        .resizable()
                        .imageScale(.large)
                        .scaledToFit()
                        .frame(width: 200)
                        .cornerRadius(25)
                    Image("coffee")
                        .resizable()
                        .imageScale(.large)
                        .scaledToFit()
                        .frame(width: 200)
                        .cornerRadius(25)
                    Image("coffee3")
                        .resizable()
                        .imageScale(.large)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 150)
                        .cornerRadius(25)
                    CustomView(msg: "test", pic: "coffee", image: .pencilTip)
                }
            }
            
            
            VStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .scaledToFit()
                        .padding(100)
                        .foregroundColor(.blue)
                    
                    HStack {
                        Image(systemName: "pencil")
                            .imageScale(.large)
                            .foregroundColor(.white)
                        Text("Barista")
                    }
                }
                
                
                Text("test")
                    .foregroundColor(Color.red)
                
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .scaledToFit()
                        .padding(100)
                        .foregroundColor(.mint)
                    
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                        Text("Hello, world!")
                    }
                }
                
                
                
            }
            .foregroundColor(.black)
            .padding()
            
        }
    }
}







// struct with enum as parameter
struct CustomView : View {
    let msg: String
    let pic: String
    let image: SystemImage
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .scaledToFit()
                .padding(100)
                .foregroundColor(.blue)
            
            HStack {
                Image(pic)
                Text(msg)
                Image(systemName: image.rawValue)
            }
            
        }
    }
}

struct MyCustomView: View {
    let title: String
    init(title: String) {
        self.title = title
    }
    var body: some View {
        Text(title)
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
