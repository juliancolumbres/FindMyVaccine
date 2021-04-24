//
//  Venue.swift
//  FindMyVaccine
//
//  Created by Julian Columbres on 4/23/21.
//
import AddressBook
import SwiftyJSON
import SwiftUI
import UIKit
import MapKit
import SwiftyJSON
import Foundation
import CoreLocation

class Venue: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    let appointmentsAvailable: BooleanLiteralType
    let combinedAddress: String?
    

    
    init (title: String, locationName: String?, coordinate: CLLocationCoordinate2D, appointmentsAvailable: BooleanLiteralType, combinedAddress: String?)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.appointmentsAvailable = appointmentsAvailable
        self.combinedAddress = combinedAddress
        
        
        super.init()
        
    }
    
    var subtitle: String? {
        return locationName
    }
    
   
    

    class func from(json: JSON) -> Venue?
    {
        var title: String
        if let unwrappedTitle = json["properties"]["name"].string {
            title = unwrappedTitle
        } else {
            title = ""
        }

        let locationName = json["properties"]["address"].string
        let coordinates = json["geometry"]["coordinates"].array
    
        let appointmentsAvailable = json["properties"]["appointments_available"].boolValue
        let long = coordinates![0].doubleValue
        let lat = coordinates![1].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude:lat, longitude: long)
        
        let city = json["properties"]["city"].string
        let zipcode = json["properties"]["postal_code"].string
        let combinedAddress = "\(locationName ?? "" ), \(city ?? ""), \(zipcode ?? "")"
  
       
        
        return Venue(title: title, locationName: locationName, coordinate: coordinate, appointmentsAvailable: appointmentsAvailable, combinedAddress: combinedAddress)
    }
}
