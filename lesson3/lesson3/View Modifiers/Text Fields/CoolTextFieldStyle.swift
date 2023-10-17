//
//  CoolTextFieldStyle.swift
//  lesson3
//
//  Created by Jack Xia on 16/10/2023.
//

import Foundation
import SwiftUI

// Returns a ViewModifier with styling - like StyleSheet in React Native
struct CoolTextFieldStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .shadow(color: .black, radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 2)
            )
        
        
    }
}

private struct CoolTextfieldStylePreview: View {
    @State var nameTxt = ""
    @State var phoneTxt = ""
    
    var body: some View {
        ZStack {
            Color.cyan
            VStack {
                TextField("Navn", text: $nameTxt)
                    .modifier(CoolTextFieldStyle())
                
                TextField("Navn", text: $phoneTxt)
                    .modifier(CoolTextFieldStyle())
                    .coolTextFieldStyle()
            }
        }
    }
}

extension View {
    func coolTextFieldStyle() -> some View {
        modifier(CoolTextFieldStyle())
    }
}

struct CoolTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        // View can't return Binding of state so we make a private struct to manipulate state of View to watch in real time
        CoolTextfieldStylePreview()
    }
}

