//
//  lesson3App.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

@main
struct lesson3App: App {
    
    
    @State var shoppingCart = [Product]()
    
    var body: some Scene {
        WindowGroup {
            
            // This is like NavigationStack
            TabView {
                // Usually API response will be sent into this view
                // TODO: Privileges should be a login to give access
                // Tab 1
                ProductListView(products: Product.demoProducts, isAdmin: false, userlvl: UserLevel.admin, shoppingCart: $shoppingCart)
                    .tabItem {
                        Label("Produkter", systemImage: "tray.and.arrow.down.fill")
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
