//
//  ShoppingChartView.swift
//  lesson3
//
//  Created by Jack Xia on 18/09/2023.
//

import SwiftUI

struct ShoppingChartView: View {
    
    var shoppingCart: Binding<[Product]>
    @State var totalSum: Int = 0
    
    init(shoppingCart: Binding<[Product]>) {
        self.shoppingCart = shoppingCart
    }
    
    func onAppear() {
        totalSum = 0
        for product in shoppingCart {
            totalSum += product.wrappedValue.price
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(shoppingCart) { product in
                        
                        HStack {
                            Text("\(product.wrappedValue.name)  \(product.wrappedValue.description)")
                            Spacer()
                            Text("\(product.wrappedValue.price) kr")
                        }
                    }
                    HStack {
                        if (shoppingCart.isEmpty) {
                            Text("Shopping cart is empty!")
                                .foregroundColor(.red)
                        } else {
                            Text("Total sum:")
                            Spacer()
                            Text("\(totalSum)")
                        }
                    }
                    .bold()
                    .foregroundColor(.blue)
                }
                .navigationTitle("Handlekurv")
            }
        }
        .onAppear {
            onAppear()
        }
        
    }
}

struct ShoppingChartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingChartView(shoppingCart: .constant(
            [
                Product(name: "Sokker", description: "Blå", price: 99, images: [])
            ]))
    }
}
