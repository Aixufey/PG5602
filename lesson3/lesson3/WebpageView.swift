//
//  WebpageView.swift
//  lesson3
//
//  Created by Jack Xia on 10/10/2023.
//

import SwiftUI
import SafariServices

struct WebpageView: View, UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let safari = SFSafariViewController(url: url)
        //safari.configuration()
        return safari
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
    
    
}

struct WebpageView_Previews: PreviewProvider {
    static var previews: some View {
        WebpageView(url: URL.init(string: "https://politiet.no")!)
    }
}
