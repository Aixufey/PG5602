//
//  CoolStyle.swift
//  lesson3
//
//  Created by Jack Xia on 16/10/2023.
//

import Foundation
import SwiftUI

// Returns a ViewModifier with styling - like StyleSheet in React Native
struct CoolStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipped()
            .cornerRadius(25)
            .shadow(color: .black, radius: 20)
    }
}


struct CoolStyle_Previews: PreviewProvider {
    static var previews: some View {
        Image("productImage")
            .resizable()
            .modifier(CoolStyle())
    }
}
