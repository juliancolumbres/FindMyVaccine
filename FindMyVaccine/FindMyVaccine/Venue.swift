//
//  Venue.swift
//  FindMyVaccine
//
//  Created by Julian Columbres on 4/23/21.
//

import MapKit
import AddressBook
import SwiftyJSON

class Venue: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    let appointmentsAvailable: BooleanLiteralType
    
    init (title: String, locationName: String?, coordinate: CLLocationCoordinate2D, appointmentsAvailable: BooleanLiteralType)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.appointmentsAvailable = appointmentsAvailable
        
        super.init()
        
    }
    
    var subtitle: String? {
        return locationName
    }

    class func from(json: JSON) -> Venue?
    {
        var title: String
        if let unwrappedTitle = json["properties"]["provider"].string {
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
        return Venue(title: title, locationName: locationName, coordinate: coordinate, appointmentsAvailable: appointmentsAvailable)
    }
}
