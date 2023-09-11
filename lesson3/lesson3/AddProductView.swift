//
//  AddProductView.swift
//  lesson3
//
//  Created by Jack Xia on 11/09/2023.
//

import SwiftUI

struct AddProductView: View {
    
    
    
    // STATES: Textfield attributes
    @State var newProductName: String = ""
    @State var newProductDescription: String = ""
    @State var newProductPrice: String = ""
    
    var didAddProduct: ((Product) -> ())
    
    func addProduct() {
        
    }
    
    
    
    var body: some View {
        
        
        VStack(alignment: .trailing) {
            
            HStack {
                Text("Legg til nytt produkt")
                    .font(.title)
                    .padding(30)
                
                
                Spacer()
            } // title Hstack
            
            // binding with $ and the value will be bound to the variable
            TextField("Produktnavn", text: $newProductName)
            TextField("Beskrivelse", text: $newProductDescription)
            TextField("Pris", text: $newProductPrice)
            
            
            // Saving the state from userinput
            Button {
                // 1 user tapped button
                print("user tapped button")
                addProduct()
            } label: {
                // This Button returns a View
                VStack {
                    Text("Lagre")
                    Text("Produkt")
                }
            }
            
            
            Spacer()
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        // Closure trailing is ugly..
        // AddProductView(, didAddProduct: (Product) -> ())
        // Do this instead
        AddProductView() { product in
            
        }
        
    }
}
