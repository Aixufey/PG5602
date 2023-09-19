//
//  WebView.swift
//  H4X0R News
//
//  Created by Jack Xia on 19/09/2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    // 1. Creating a WebView
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    // 2. Then load up the View with the URL
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}


struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://www.unsplash.com")
    }
}
