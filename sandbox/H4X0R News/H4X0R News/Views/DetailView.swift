//
//  DetailView.swift
//  H4X0R News
//
//  Created by Jack Xia on 18/09/2023.
//

import SwiftUI

// DetailView get passed in an URL
struct DetailView: View {
    let url: String?
    
    var body: some View {
        // Then creating a WebView and pass in the URL we get
        WebView(urlString: url)
        
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.unsplash.com")
    }
}


