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
                ShoppingChartView()
                    .badge(shoppingCart.count)
                    .tabItem {
                        Label("Handlekurv", systemImage: "tray.and.arrow.down.fill")
                    }
                
                // Tab 3
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "tray.and.arrow.down.fill")
                    }
            }
        }
    }
}
