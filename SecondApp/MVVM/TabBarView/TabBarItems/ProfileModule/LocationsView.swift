//
//  LocationsView.swift
//  SecondApp
//
//  Created by MacBook27 on 31/01/24.
//
import SwiftUI
import MapKit
import Combine
import Foundation

struct Location: Decodable, Identifiable {
    let id = UUID()
    let city: String
    let name: String
    let country: String
    let longitude: Double
    let latitude: Double
    let store_id: Int
}

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location] = []

    init() {
        loadLocations()
    }
    
    func loadLocations() {
        if let url = Bundle.main.url(forResource: "locations", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let decodedLocations = try? JSONDecoder().decode([Location].self, from: data) {
            self.locations = decodedLocations
        }
    }
}

struct LocationsView: View {
    @ObservedObject var viewModel = LocationsViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.locations) { location in
                NavigationLink(destination: MapView(location: location)) {
                    VStack(alignment: .leading) {
                        Text(location.city)
                            .fontWeight(.bold)
                        Text(location.name)
                            .padding(.top, 0)
                    }
                }
            }
            .navigationBarTitle("Starbucks Locations")
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}

struct MapView: View {
    let location: Location

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [location]) { location in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .blue)
        }
        .onAppear {
            withAnimation {
                region.center.latitude = location.latitude
                region.center.longitude = location.longitude
                region.span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            }
        }
        .navigationBarTitle("Map: \(location.name)", displayMode: .inline)
    }
}
