//
//  ProductDTView.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

struct ProductDTView: View {
    
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.name)
            Text(product.description)
        }
    }
}

struct ProductDTView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDTView(product: .init(name: "This is a test", description: "Only visible for this view", price: 500))
    }
}
