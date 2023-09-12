//
//  UpdateProductView.swift
//  lesson3
//
//  Created by Jack Xia on 12/09/2023.
//

import SwiftUI

struct UpdateProductView: View {
    
    // Since we created this as separated view we need to handle some events
    // We are sending in two closures of type func as arguments
    var minusButtonTapped: () -> Void
    var plusButtonTapped: () -> ()
    
    // In Swift we have to initialize fields with default values
    init(minusButtonTapped:@escaping () -> (), plusButtonTapped:@escaping () -> Void) {
        self.minusButtonTapped = minusButtonTapped
        self.plusButtonTapped = plusButtonTapped
    }
    
    // @State var demoText: String = ""
    
    
    
    
    var body: some View {
        
        HStack {
            
            ZStack {
                Circle()
                Text("-")
                    .foregroundColor(.white)
            }.onTapGesture {
                // tapped -btn
                // demoText = "Tapped -"
                minusButtonTapped()
            }
            
            ZStack {
                Circle()
                Text("+")
                    .foregroundColor(.white)
            }.onTapGesture {
                // demoText = "Tapped +"
                // tapped +btn
                plusButtonTapped()
            }
            
        }.font(.largeTitle)
    }
}



struct UpdateProductView_Previews: PreviewProvider {
    static var previews: some View {
        // In preview we can compile the View signature - how to call this with 2 func
        UpdateProductView(minusButtonTapped: {
            return ()
        }, plusButtonTapped: {
            return ()
        })
    }
}
