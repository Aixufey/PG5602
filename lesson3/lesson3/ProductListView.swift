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

enum MyError : Error {
    case runTimeError(String)
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
            let product = Product(name: newProductName, description: newProductDescription, price: productPrice, images: [])
            
            products.append(product)
        } else {
            print("Parse format error _\(newProductPrice)_")
        }
    }
    
    
    func onAppear() {
        
        //getWithClosures()
        
        // Modern way - Concurrency multithreading
        Task {
            var urlRequest = URLRequest.init(url: URL.init(string:"https://raw.githubusercontent.com/BeiningBogen/PG5602/master/products.json")!)
            urlRequest.httpMethod = "GET"
            do {
                // URLSession returning (data, response) as a Tuple
                let (data, response) = await try
                URLSession.shared.data(for: urlRequest)
                
                // guard is a Premise in case we dont get ANY statusCode at all
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200
                else {
                    // Throw error
                    throw MyError.runTimeError("NO STATUS CODE FROM RESPONSE!!")
                }
                
                let stringResponse = String.init(data: data, encoding: .utf8)
                print(stringResponse)
                
                
                let products = try JSONDecoder().decode([Product].self, from: data)
                
                print(products)
                
                print(statusCode)
                DispatchQueue.main.async {
                    
                    self.products = products
                }
                
            } catch let error {
                
            }
        } // Task
    }
    
    // HTTP request test with closures
    func getWithClosures() {
        var urlRequest = URLRequest(url: URL.init(string:"https://raw.githubusercontent.com/BeiningBogen/PG5602/master/products.json")!)
        urlRequest.httpMethod = "GET"
        
        let httptask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse?.statusCode)
            
            if let data = data {
                let stringResponse = String.init(data: data, encoding: .utf8)
                
                do {
                    let products = try
                    JSONDecoder().decode([Product].self, from: data)
                    
                    // product is a state that is rendering on main view, in iOS only Thread 1 can render
                    // View and UI, dispatch this to main thread to render / update
                    DispatchQueue.main.async {
                        self.products = products
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                print(products)
            
            } else {
                print("No data received")
            }
        }
        httptask.resume()
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
                                    // Since ID is UUID and randomly generated everytime App starts
                                    // We cant delete the persistent data, so predicate on name instead.
                                    if product.name == predicateProduct.name && hasRemoved == false {
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
                        let newProduct = Product.init(name: "Sokker", description: "small, yellow", price: 99, images: [])
                        let newProduct2 = Product.init(name: "test", description: "test", price: 100, images: [])
                        
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
                
            }// Sheet
            
        } // navStack
        .onAppear {
            onAppear()
        }
        
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
