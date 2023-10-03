//
//  lesson3App.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI
import KeychainSwift

@main
struct lesson3App: App {
    
    
    @State var shoppingCart = [Product]()
    @State var usernameStillExist: Bool = false
    
    let fileName: String = "data.json"
    
    // Read from disk
    func onAppear() {
        let fileManager = FileManager.default
        do {
            let fileURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(fileName)
            
            let data = try Data.init(contentsOf: fileURL)
            let decoder = JSONDecoder()
            // decoding a Product array
            let product = try decoder.decode([Product].self, from: data)
            
            self.shoppingCart = product
            
            print("---")
            print(product)
            print("---")
            
            
            // Swift way declaring dictionaries key:string :  value:any
            var _: [String : Any]
            var _: Dictionary<String, Any>
        } catch let error {
            print(error)
        }
        
    }
    
    // Save to disk
    func shoppingCartOnAppear() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(shoppingCart)
            // FM to handle creation of file
            let fileManager = FileManager.default
            print("--++--")
            // Retrieve path to document
            print(URL.documentsDirectory)
            print("--++--")
            
            
            
            let fileURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(fileName)
            
            try data.write(to: fileURL)
            
            //            // Full path
            //            let path = "\(fileURL)data.json"
            //            // Create file
            //            let createdFile = fm.createFile(atPath: path, contents: data)
            //            // Check if file exist
            //            let fileExist = fm.fileExists(atPath: path)
            //
        } catch let error {
            print(error)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            
            // This is like NavigationStack
            TabView {
                // Usually API response will be sent into this view
                // TODO: Privileges should be a login to give access
                // Tab 1
                ProductListView(products: Product.demoProducts, isAdmin: false, userlvl: UserLevel.admin, shoppingCart: $shoppingCart, usernameStillExist: $usernameStillExist)
                    .tabItem {
                        Label("Produkter", systemImage: "tray.and.arrow.down.fill")
                    }
                    .onAppear {
                        
                        print("ProductScreen isFocused")
                        if UserDefaults().object(forKey: AppStorageKeys.username.rawValue) != nil {
                            usernameStillExist = true
                        } else {
                            usernameStillExist = false
                        }
                        print("usernameStillExist: \(usernameStillExist)")
                    }
                // Tab 2
                ShoppingChartView(shoppingCart: $shoppingCart)
                    .badge(shoppingCart.count)
                    .tabItem {
                        Label("Handlekurv", systemImage: "tray.and.arrow.down.fill")
                    }
                    .onAppear {
                        shoppingCartOnAppear()
                    }
                
                
                
                // Tab 3
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "tray.and.arrow.down.fill")
                    }
            }
            .onAppear {
                onAppear()
            }
            
        }
    }
}
