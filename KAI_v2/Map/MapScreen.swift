//
//  MapScreen.swift
//  kaist
//
//  Created by Airat K on 2/7/19.
//  Copyright © 2019 Airat K. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapScreen: AUIMapViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Здания КАИ"
        
        self.centerMapViewToMainLocation()
        
        self.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: UniversityBuildingAnnotation.reuseID)
        self.mapView.addAnnotations(self.getUniversityBuildings().map { UniversityBuildingAnnotation(
            title: $0["title"] as? String, subtitle: $0["address"] as? String,
            coordinate: CLLocationCoordinate2D(latitude: $0["latitude"] as! Double, longitude: $0["longitude"] as! Double)
        )})
        
        if CLLocationManager.locationServicesEnabled() {
            self.checkLocationAuthorization()
        }
    }
    
    
    private func getUniversityBuildings() -> [[String: Any]] {
        var format = PropertyListSerialization.PropertyListFormat.xml
        
        let pathToUniversityBuildingsData = Bundle.main.path(forResource: "UniversityBuildings", ofType: "plist")!
        let universityBuildingsData = FileManager.default.contents(atPath: pathToUniversityBuildingsData)!
        
        return try! PropertyListSerialization.propertyList(from: universityBuildingsData, options: .mutableContainersAndLeaves, format: &format) as! [[String: Any]]
    }
    
    private func centerMapViewToMainLocation() {
        let embankmentOfKazanCity = CLLocationCoordinate2D(latitude: 55.8031624, longitude: 49.1152275)
        let region = MKCoordinateRegion(center: embankmentOfKazanCity, latitudinalMeters: 12_000, longitudinalMeters: 12_000)
        
        self.mapView.setRegion(region, animated: true)
    }
    
}

extension MapScreen {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.checkLocationAuthorization()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        let buildingAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: UniversityBuildingAnnotation.reuseID, for: annotation) as! MKMarkerAnnotationView
        
        buildingAnnotationView.clusteringIdentifier = UniversityBuildingAnnotation.clusteringID
        
        return buildingAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard !view.annotation!.isKind(of: MKUserLocation.self) else { return }
        
        guard !view.annotation!.isKind(of: MKClusterAnnotation.self) else {
            let zoomCoefficient = 2.5
            
            let region = MKCoordinateRegion(center: view.annotation!.coordinate, span: MKCoordinateSpan(
                latitudeDelta: mapView.region.span.latitudeDelta/zoomCoefficient,
                longitudeDelta: mapView.region.span.longitudeDelta/zoomCoefficient
            ))
            
            mapView.setRegion(region, animated: true)
            mapView.deselectAnnotation(view.annotation, animated: true)
            
            return
        }
        
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: view.annotation!.coordinate))
        
        request.transportType = .walking
        
        MKDirections(request: request).calculate { (response, error) in
            guard let route = response?.routes.first, error == nil else { return }
            
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            mapView.addOverlay(route.polyline)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        mapView.removeOverlays(mapView.overlays)
    }
    
}
