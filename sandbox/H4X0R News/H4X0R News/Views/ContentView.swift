//
//  ContentView.swift
//  H4X0R News
//
//  Created by Jack Xia on 18/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    // Listen to the published broadcast
    @ObservedObject var networkManager = NetworkManager()
    
    
    var body: some View {
        NavigationView {
            // Closure: Under the hood
            // List(posts, rowContent: { post in }
            //
            // )
            // Since rowContent is a closure in the end ... trailing we can write it outside
            List(networkManager.posts) { post in
                // For each post in closure, returns a View
                HStack {
                    Text(String(post.points))
                    Text(post.title)
                }
                
            }
            .navigationTitle("H4X0R NEWS")
        }
        // All View has onAppear that is a closure
        .onAppear(perform: self.networkManager.fetchData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Unique ID for every post object that will be used in a Collection
struct PostObj: Identifiable {
    let id: String
    let title: String
}

let posts = [
    PostObj(id: "1", title: "Hello"),
    PostObj(id: "2", title: "Bonjour"),
    PostObj(id: "3", title: "Hola"),
]
