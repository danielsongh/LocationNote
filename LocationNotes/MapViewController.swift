import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var annotationData = [NoteAnnotation]()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func add(noteAnnotation: NoteAnnotation) {
        annotationData.append(noteAnnotation)
        mapView.addAnnotation(noteAnnotation)
        mapView?.add(MKCircle(center: noteAnnotation.coordinate, radius: noteAnnotation.radius))
    }
    
    // Get region of the geofence
    func getCircularRegion(noteAnnotation: NoteAnnotation) -> CLCircularRegion {
        let region = CLCircularRegion(center: noteAnnotation.coordinate, radius: noteAnnotation.radius, identifier: noteAnnotation.identifier)
        region.notifyOnEntry = (noteAnnotation.eventType == .onEntry)
        region.notifyOnExit = !region.notifyOnEntry
        
        return region
    }
    
    @IBAction func goToCurrentLocation(_ sender: Any) {
        guard let coordinate = mapView.userLocation.location?.coordinate else {
            return
        }
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "noteAnnotationID"
        if annotation is NoteAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                let removeButton = UIButton(type: .custom)
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                annotationView?.leftCalloutAccessoryView = removeButton
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .authorizedAlways)
    }
}


