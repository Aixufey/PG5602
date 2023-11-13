//
//  ProductDTView.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

struct ProductDTView: View {
    
    let product: Product
    
    // Animation vars
    @State var scale: CGFloat = 1
    @State var rotationAngle: CGFloat = 0
    @State var imageOpacity: CGFloat = 1
    @State var imageBlur: CGFloat = 0
    @State var textPadding: CGFloat = 40
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Text(product.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: textPadding, leading: 40, bottom: 0, trailing: 0))
                Spacer() // Push the title to the left
            } // HStack Title
            Image("productImage")
                .resizable()
            //.scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .opacity(imageOpacity)
                .blur(radius: imageBlur)
            
            
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
                
                withAnimation {
                    scale = 1.5
                    rotationAngle = 100
                    imageOpacity = 0
                    textPadding = 400
                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    scale = 1
//                    rotationAngle = 360
//                }
                print("bought \(product.name)")
                
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
            .scaleEffect(scale)
//            .rotationEffect(Angle(degrees: rotationAngle))

        } // VStack
        .onAppear {
            withAnimation(.linear(duration: 2)) {
                imageBlur = 0
            }
        }
    }
}

struct ProductDTView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDTView(product: .init(name: "Nike SB", description: "White shoes", price: 1500, images: []))
    }
}
