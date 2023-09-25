//
//  ContentView.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI
import KeychainSwift

// Privileges
enum UserLevel {
    case user
    case admin
    case employee
}



struct ProductListView: View {
    let userlvl: UserLevel
    let isAdmin: Bool
    let usernameStillExist: Binding<Bool>
    
    // Initialize an array of type Product
    init(products: [Product], isAdmin: Bool, userlvl: UserLevel, shoppingCart: Binding<[Product]>, usernameStillExist: Binding<Bool>) {
        self.products = products
        self.isAdmin = isAdmin
        self.userlvl = userlvl
        self.isPresentingAddProductView = false
        self.shoppingCart = shoppingCart
        self.usernameStillExist = usernameStillExist
    }
    
    // Type binding declaration
    var shoppingCart: Binding<[Product]>
    
    // Field needs to be self instantiated
    // @State is annotation for wiring to update the status for mutating objects
    // @@State is a short hand for
    //@Published
    //@ObservedObject
    @State var products: [Product]
    
    
    // self init as false
    @State var isPresentingAddProductView: Bool
    
    
    // STATES: Textfield attributes
    @State var newProductName: String = ""
    @State var newProductDescription: String = ""
    @State var newProductPrice: String = ""
    
    
    func addProduct() {
        print("User still tapped btn")
        
        // parse int for price if doable
        if let productPrice = Int(newProductPrice) {
            let product = Product(name: newProductName, description: newProductDescription, price: productPrice)
            
            products.append(product)
        } else {
            print("Parse format error _\(newProductPrice)_")
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                // \.self is required if using a List to generate items
                // ForEach(products, id:  \.self){product in
                ForEach(products) { product in
                    
                    // Navigate to item
                    HStack {
                        NavigationLink {
                            ProductDTView(product: product)
                            
                            // label is expecting view builder so we refactored the code as method
                        } label: {
                            ListItemView(product: product)
                            
                        } // Navigationlink Label
                        
                        Spacer()
                        
                        // Admin shall not shop so hide the btn if Admin is true
                        if isAdmin == false {
                            UpdateProductView(minusButtonTapped: {
                                var hasRemoved = false
                                shoppingCart.wrappedValue.removeAll { predicateProduct in
                                    if product.id == predicateProduct.id && hasRemoved == false {
                                        hasRemoved = true
                                        return true
                                    }
                                    return false
                                }
                                print(shoppingCart)
                                
                            }, plusButtonTapped: {
                                // Getting bindings value need a wrapping
                                shoppingCart.wrappedValue.append(product)
                                print(shoppingCart)
                                
                            })
                            .padding()
                            .frame(width: 140)
                        } else { // isAdmin scope
                            
                        }
                        
                        
                    } // HStack
                    
                } // foreach
                
                if isAdmin {
                    Button("Legg til produkt") {
                        let newProduct = Product.init(name: "Sokker", description: "small, yellow", price: 99)
                        let newProduct2 = Product.init(name: "test", description: "test", price: 100)
                        
                        products.append(newProduct)
                        products.append(newProduct2)
                        
                        
                        
                        isPresentingAddProductView = true
                    } // button
                } else {
                    
                    // Feedback to display if the user is logged in.
                    if usernameStillExist.wrappedValue == true {
                        if let username = UserDefaults().object(forKey: AppStorageKeys.username.rawValue) as? String {
                            
                            Text("Logged in \(username)")
                        }
                    } else {
                        Text("Logged out")
                    }
//                    if KeychainSwift().get(AppStorageKeys.password.rawValue) != nil, let username = UserDefaults().object(forKey: AppStorageKeys.username.rawValue) as? String {
//
//                        Text("Du er en vanlig bruker, logget inn \(username).")
//                    } else {
//                        Text("Du er en vanlig bruker, ikke logget inn")
//
//                    }
                    
                    
                } // ifelse
            } // ScrollView
            .sheet(isPresented: $isPresentingAddProductView) {
                
                // Swift dislike adding mutiple sheets stacked together so we refactored
                // the Add product into a new View....
                // Initializing the view with a Struct signature that is a function INIT
                AddProductView() { product in
                    print(product)
                    
                    // Appending to Array
                    products.append(product)
                    // Closing the Sheet after append
                    isPresentingAddProductView = false
                }
                
                //                Refactored into a new View as AddProductView()
                //                VStack(alignment: .trailing) {
                //
                //                    HStack {
                //                        Text("Legg til nytt produkt")
                //                            .font(.title)
                //                            .padding(30)
                //
                //
                //                        Spacer()
                //                    } // title Hstack
                //
                //                    // binding with $ and the value will be bound to the variable
                //                    TextField("Produktnavn", text: $newProductName)
                //                    TextField("Beskrivelse", text: $newProductDescription)
                //                    TextField("Pris", text: $newProductPrice)
                //
                //
                //                    // Saving the state from userinput
                //                    Button {
                //                        // 1 user tapped button
                //                        print("user tapped button")
                //                        addProduct()
                //                    } label: {
                //                        // This Button returns a View
                //                        VStack {
                //                            Text("Lagre")
                //                            Text("Produkt")
                //                        }
                //                    }
                //
                //
                //                    Spacer()
                //                }
                
            }// Sheet
            
            
        } // navStack
    } // body
}


// Preview has admin access to show Button logic
struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(products: Product.demoProducts, isAdmin: false, userlvl: UserLevel.admin, shoppingCart: .constant([]), usernameStillExist: .constant(true))
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
