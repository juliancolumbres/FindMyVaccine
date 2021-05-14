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

struct getCoordinates{
    static var lat = 0.0
    static var long = 0.0
}

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    static var coordinatesTest : CLLocationCoordinate2D?
    
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
                            let comparedLong = abs(venue.coordinate.longitude - getCoordinates.long)
                            let comparedLat = abs(venue.coordinate.latitude - getCoordinates.lat)
                            
                            if comparedLong <= 0.1 && comparedLat <= 0.1 && venue.appointmentsAvailable == true  {
                                self.venues.append(venue)
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
        
    }
    
    // when user changes setting to deny / allow location access
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        print("loc enabled at status? \(CLLocationManager.authorizationStatus() == .authorizedWhenInUse)")
        
        // when user doesn't allow access to location
        if CLLocationManager.authorizationStatus() == .denied { // check if app is allowed to access location
            print("loc denied, app will choose coords for user")
            // set coordinates to LA coords
            getCoordinates.lat = 34.0522
            getCoordinates.long = -118.2437
            
            // get and display data
            fetchData()
            print("fetched data for LA")
            mapView.addAnnotations(venues)
            
            // zoom in on map
            let zoomHere = CLLocationCoordinate2D(latitude: getCoordinates.lat, longitude: getCoordinates.long) // location to zoom in on
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: zoomHere, span: span)
            mapView.setRegion(region, animated: false)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("loc enabled at update? \(CLLocationManager.authorizationStatus() == .authorizedWhenInUse)")

        if let location = locations.first {
            // zoom in to location on map
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: false)
        }
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        //print(locValue)
        
        // saving user location & getting nearby vaccine center data
        if CLLocationManager.locationServicesEnabled() {
            print("loc enabled, getting lat & long")
            getCoordinates.lat = locValue.latitude
            getCoordinates.long = locValue.longitude
            fetchData()
            print("fetched data")
            mapView.addAnnotations(venues)
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
            view.pinTintColor = UIColor.systemTeal
            return view
        }
        return nil
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! Venue
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
}
