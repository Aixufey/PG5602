//
//  ProductDTView.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

struct ProductDTView: View {
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Text(product.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 40, leading: 40, bottom: 0, trailing: 0))
                Spacer() // Push the title to the left
            } // HStack Title
            Image("productImage")
                .resizable()
            //.scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
            
            
            Text(product.description)
                .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            
            Spacer()
            Text("Før \(product.price + Int.random(in: 10...400)) kr")
                .strikethrough()
                .padding(.top)
            Text("Nå \(product.price) kr")
                .padding(.top)
            
            Button {
                // TODO: buy product
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 100)
                    .foregroundColor(.orange)
            
                    Text("Kjøp")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                
            }

        }
    }
}

struct ProductDTView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDTView(product: .init(name: "Nike SB", description: "White shoes", price: 1500, images: []))
    }
}
