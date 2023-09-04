//
//  ContentView.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    // Instantiate object of type Product
    let products = [
        Product.init(name: "Bukse", description: "Grå", price: 500),
        Product.init(name: "T-skjorte", description: "Blå", price: 400),
        Product.init(name: "Sko", description: "Hvit", price: 1090)
    ]
    
    
    var body: some View {
        
        NavigationStack {
            List{
                // \.self is required if using a List to generate items
                // ForEach(products, id:  \.self){product in
                ForEach(products) { product in
                    
                    // Navigate to items
                    NavigationLink {
                        ProductDTView(product: product)
                        
                        // label is expecting view builder so we refactored the code as method
                    } label: {
                        ListItemView(product: product)
                        
                    } // label
                    
                } // foreach
            } // list
        } // navStack
    } // body
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



// ListItemView
struct ListItemView : View {
    // Field
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Text("\(product.name)")
            Text(product.description)
                .foregroundColor(.gray)
        }
        .padding()
        .foregroundColor(.brown)
    }
}
