//
//  MapViewController.swift
//  FindMyVaccine
//
//  Created by Julian Columbres on 4/23/21.
//
import SwiftUI
import UIKit
import MapKit
import SwiftyJSON
import Foundation
import CoreLocation


class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager!
    
    var venues = [Venue]()
    
    func fetchData()
    {
        do {
            if let file = URL(string: "https://www.vaccinespotter.org/api/v0/states/CA.json") {
                let data = try Data(contentsOf: file)
                let json = try JSON(data: data)
                if let venueJSONs = json["features"].array {
                    for venueJSON in venueJSONs {
                        if let venue = Venue.from(json: venueJSON) {
                            if venue.appointmentsAvailable {
                                self.venues.append(venue)
                                print(venue.title)
                            }
                        }
                    }
                    print(self.venues.count)
                }
            } else {
               print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        
        //let initialLocation = CLLocation(latitude: 37.3352, longitude: -121.8811)
//        zoomMapOn(location: initialLocation)
        mapView.delegate = self
        fetchData()
        mapView.addAnnotations(venues)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: false)
        }
    }
    

    private let regionRadius: CLLocationDistance = 1000 // 1km
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
}

extension MapViewController : MKMapViewDelegate
{
    func mapView( _ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? Venue {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
}
