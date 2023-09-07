//
//  MapView.swift
//  Landmarks
//
//  Created by Jack Xia on 07/09/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    // State is an attribute to establish a source of truth for data to be available in other views. SWIFTUI will automatically update views with this dependency.
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        // $ binding is like autowire in Spring Boot Beans
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
