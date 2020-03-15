//
//  MapView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 17.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> MapScreen {
        return MapScreen()
    }
    
    func updateUIViewController(_ uiViewController: MapScreen, context: Context) {
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}
