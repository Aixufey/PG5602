//
//  CircleImage.swift
//  Landmarks
//
//  Created by Jack Xia on 07/09/2023.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image(_: "turtlerock")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
