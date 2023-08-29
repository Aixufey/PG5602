//
//  task2.swift
//  lesson2
//
//  Created by Jack Xia on 29/08/2023.
//

import Foundation
import SwiftUI

enum myConstants: String {
    case _title = "Pro Lesson 2"
    case kali1 = "bilder/kali-linux-wallpaper-v1"
    case kali2 = "bilder/kali-linux-wallpaper-v2"
    case kali3 = "bilder/kali-linux-wallpaper-v4"
    case kali4 = "bilder/kali-linux-wallpaper-v5"
    case kali5 = "bilder/kali-linux-wallpaper-v7"
}

let bgColor = UIColor.init(red: 255, green: 0, blue: 59, alpha: 0.2)


struct task2: View {
    var body: some View {
        
        // Best practice start with ZStack to define layering
        ZStack {
            // BG is at highest priority
//            Color(bgColor)
//                .ignoresSafeArea(.all)
            
            Image("rain")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1)
            
            // Vertical layer like photoshop
            VStack {
                
                // header(title: ._title)
                // inside we wrap the children in h or v stack
                // space will expand the as the stack's direction
                Spacer()
                
                VStack {
                    ScrollView(.vertical) {
                        
                        ImageAppView(name: .kali1)
                        ImageAppView(name: .kali2)
                        ImageAppView(name: .kali3)
                        ImageAppView(name: .kali4)
                        ImageAppView(name: .kali5)
                    }
                }
            } // VStack
        } // ZStack
    }
}


struct header: View {
    let title: myConstants
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.blue)
                .frame(maxHeight: 200, alignment: .top)
            VStack {
                // Text("test")
                // Spacer only works in children not stacks
                // Spacer()
                Text(title.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
        } // Zstack
        .frame(maxWidth: 350)
    }
}

struct ImageAppView: View {
    let name: myConstants
    
    public init(name: myConstants) {
        self.name = name
    }
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
                .scaledToFit()
            VStack {
                
                Image(name.rawValue)
                    .resizable()
                    .scaledToFill()
            }
        }
        
    }
}

















struct task2_Previews: PreviewProvider {
    static var previews: some View {
        task2()
            .preferredColorScheme(.dark)
    }
}
