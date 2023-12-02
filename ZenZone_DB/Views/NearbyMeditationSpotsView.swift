//
//  NearbyMeditationSpotsView.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-26.
//

import SwiftUI
import CoreLocation

// Defining data model to match the API response format
struct Place: Codable {
    let id: String
    let name: String
    let geometry: Geometry
    
    struct Geometry: Codable {
        let location: Location
    }
    
    struct Location: Codable {
        let lat: Double
        let lng: Double
    }
}

// Defining the expected response structure
struct Response: Codable {
    let results: [Place]
}

struct NearbyMeditationSpotsView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var meditationSpots: [MeditationSpot] = []

    var body: some View {
        List(meditationSpots) { spot in
            NavigationLink(destination: MeditationSpotDetailView(spot: spot)) {
                HStack {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.green)
                    Text(spot.name)
                }
            }
        }
        .onAppear {
            locationManager.checkIfLocationServicesIsEnabled()
        }
        .onChange(of: locationManager.lastLocation) { newLocation in
            fetchNearbyMeditationSpots(location: newLocation)
        }
        .navigationTitle("Nearby Spots")
    }

    func fetchNearbyMeditationSpots(location: CLLocation?) {
        guard let location = location else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

       // Using PlaceAPI from google to find parks near user
        let apiUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=1500&type=park&key=AIzaSyAd2mxa5rXNcmkjkL16rpeByTTfBjESVYc"

        guard let url = URL(string: apiUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.meditationSpots = response.results.map { place in
                            MeditationSpot(id: UUID(), name: place.name, coordinate: CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng))
                        }
                    }
                } else {
                    print("Error: Couldn't decode response")
                }
            }
        }.resume()
    }

}

struct MeditationSpot: Identifiable {
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MeditationSpotDetailView: View {
    let spot: MeditationSpot

    var body: some View {
        Text(spot.name)
        // Details about the meditation spot
    }
}

struct NearbyMeditationSpotsView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyMeditationSpotsView()
    }
}
