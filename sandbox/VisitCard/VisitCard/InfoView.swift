//
//  InfoView.swift
//  VisitCard
//
//  Created by Jack Xia on 29/08/2023.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(height: 50)
        // overlay sits top of the layer that can pack components
            .overlay(HStack {
                Image(systemName: imageName).foregroundColor(.green)
                Text(text)
                    .font(.title3)
            })
            .padding(.all)  // Margin in iOS is padding away from others
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Only for preview", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
