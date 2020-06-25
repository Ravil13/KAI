//
//  MapView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 17.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI
import MapKit

struct UniversityBuilding: Decodable, Identifiable {
    
    var id: String {
        address
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    let title: String
    let address: String
    let latitude: Double
    let longitude: Double
}

@available(iOS 14.0, *)
struct MapView: View {
    
    static private let kazanCoordinate = CLLocationCoordinate2D(latitude: 55.8031624,
                                                              longitude: 49.1152275)
    
    static private let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @State private var region = MKCoordinateRegion(center: kazanCoordinate,
                                                   span: span)
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: buildings) { building -> MapMarker in
            MapMarker(coordinate: building.coordinate, tint: color)
        }
    }
    
    private var buildings: [UniversityBuilding] = {
        guard let url = Bundle.main.url(forResource: "UniversityBuildings", withExtension: "plist") else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        
        let decoder = PropertyListDecoder()
        guard let buildings = try? decoder.decode([UniversityBuilding].self, from: data) else { return [] }
        return buildings
    }()
    
    var color: Color {
        let r = Int.random(in: 0...6)
        switch r {
        case 0: return .red
        case 1: return .orange
        case 2: return .yellow
        case 3: return .green
        case 4: return .blue
        case 5: return .pink
        case 6: return .purple
        default:
            return .black
        }
    }
}
