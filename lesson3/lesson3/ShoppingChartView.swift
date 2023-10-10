//
//  ShoppingChartView.swift
//  lesson3
//
//  Created by Jack Xia on 18/09/2023.
//

import SwiftUI

struct ShoppingChartView: View {
    
//    let apiClient = APIClient.demo
    let apiClient = APIClient.error(.stolenCard)
    @State var isShowingError: Bool = false
    @State var shownError: APIClientError? {
        willSet {
            if let _ = newValue {
                isShowingError = true
            } else {
                isShowingError = false
            }
        }
        didSet {
            
        }
    }
    
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
    
    func didTapPurchase() {
        // Calling API client and send the request
        Task {
            do {
                //print("Purchased clicked")
                print(shoppingCart.wrappedValue)
                try await apiClient.purchaseProducts(shoppingCart.wrappedValue)
                
                shoppingCart.wrappedValue = []
                print(shoppingCart.wrappedValue)
            } catch let error {
                print("The error is: \(error)")
                shownError = error as? APIClientError
                isShowingError = true // Show Sheet
            }
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
                
                // Purchase button
                Button {
                    didTapPurchase()
                } label: {
                    Spacer()
                    Text("Kjøp \(shoppingCart.count) produkter")
                    Spacer()
                }
                .buttonStyle(.bordered)
                .padding()
                .tint(.green)
            } // VStack
            .sheet(isPresented: $isShowingError) {
                //Text("Noe feil skjedde!")
                switch shownError {
                case .stolenCard:
                    WebpageView(url: URL.init(string: "https://www.politiet.no/tjenester/anmelde/")!)
                case .insufficientFunds:
                    Text("Du har ikke nok penger på kortet")
                case .statusCode(var statusCode):
                    Text("Prøv igjen, kontakt administrasjonen")
                case .failed(underlying: var error):
                    Text("Prøv igjen, kontakt administrasjonen")
                default:
                    Text("Prøv igjen, kontakt administrasjonen")
                }
            }
        } // Navigation
        .onAppear {
            onAppear()
        }
        
    } // body
}

struct ShoppingChartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingChartView(shoppingCart: .constant(
            [
                Product(name: "Sokker", description: "Blå", price: 99, images: [])
            ]))
    }
}
