//
//  lesson3App.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

@main
struct lesson3App: App {
    var body: some Scene {
        WindowGroup {
            
            // Usually API response will be sent into this view
            // TODO: Privileges should be a login to give access
            ProductListView(products: Product.demoProducts, isAdmin: false, userlvl: UserLevel.admin)
        }
    }
}
