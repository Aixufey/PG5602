//
//  AddProductView.swift
//  lesson3
//
//  Created by Jack Xia on 11/09/2023.
//

import SwiftUI

struct AddProductView: View {
    var didAddProduct: ((Product) -> ())
    
    // Struct signature that is a function
    init(didAddProduct: @escaping (Product) -> Void) {
        self.didAddProduct = didAddProduct
    }
    
    
    // STATES: Textfield attributes
    @State var newProductName: String = ""
    @State var newProductDescription: String = ""
    @State var newProductPrice: String = ""
    
    @State var isShowingErrorAlert = false
    
    func addProduct() {
        // if with bool check oneliner
        if let productPrice = Int(newProductPrice) {
            let product = Product(name: newProductName, description: newProductDescription, price: productPrice)
            didAddProduct(product)
            
        } else {
            isShowingErrorAlert = true
        }
        return ()
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
            // This Button struct takes two function closure, an event and returning a View
            Button() {
                // Closure 1 - some type of event
                // 1 user tapped button
                print("user tapped button")
                addProduct()
                return () // same as Void
            } label: { // label is the second half of the func that returns a custom View
                // Closure 2 - returning a View
                VStack {
                    Text("Lagre")
                    Text("Produkt")
                }
            }
            
            
            Spacer()
        }.alert("Det skjedde noe feil", isPresented: $isShowingErrorAlert) {
            Text("Dette var action closure")
        } message: {
            Text("Dette var message closure")
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
