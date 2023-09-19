//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Jack Xia on 18/09/2023.
//

import Foundation

// Protocol: ObservableObject - Essentially broadcasting to other Views
class NetworkManager: ObservableObject {
    
    // Protocol: Published will be broadcasted, so other can listen to it.
    @Published var posts = [Post]()
    
    // Function to fetch from an API
    func fetchData() {
        // If url ?
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            // URLSession is a network config for down/up data
            let session = URLSession(configuration: .default)
            
            // Creating a task with given url, then a trailing closure to handle http request
            // Then we have to start the task below.
            let task = session.dataTask(with: url) { data, response, error in
                
                // if success
                if error == nil {
                    
                    // JSON parser instance
                    let decoder = JSONDecoder()
                    
                    // if data assign it to a variable
                    if let safeData = data {
                        
                        // decode is throwable, so wrap in a try block
                        do {
                            // Refering with .self to specify this type that is an array
                            let results = try decoder.decode(Results.self, from: safeData)
                            
                            // Concurrency: Because post is being broadcasted it has to be on the main thread
                            DispatchQueue.main.async {
                                // Assign it to posts
                                self.posts = results.hits
                            }
                            
                        } catch {
                            print(error)
                        }
                    } // if data
                } // if no error
            } // task
            // Start the task
            task.resume()
        }
    }
}
