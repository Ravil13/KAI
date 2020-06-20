import UIKit
import MapKit


class UniversityBuildingAnnotation: NSObject, MKAnnotation {
    
    public static let reuseID = "UniversityBuildingAnnotation"
    public static let clusteringID = "UniversityBuildingsCluster"
    
    public var title: String?
    public var subtitle: String?
    public var coordinate: CLLocationCoordinate2D
    
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
