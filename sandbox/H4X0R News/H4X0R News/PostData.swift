//
//  PostData.swift
//  H4X0R News
//
//  Created by Jack Xia on 18/09/2023.
//

import Foundation


// Entity model from Hacker News API
// Protocol: Type is Decodeable in order to let JSONDecoder() to parse
struct Results: Decodable {
    let hits: [Post]
}

// Protocol: Decodable && Identifiable
struct Post: Decodable, Identifiable {
    // Identifiable need word 'id' but data 'objectID' is a unique identifier from API
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
