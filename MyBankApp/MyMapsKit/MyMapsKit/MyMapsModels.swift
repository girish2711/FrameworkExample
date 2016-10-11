//
//  MyMapsModels.swift
//  MyMapsKit
//
//  Created by Girish Adiga  on 10/9/16.
//  Copyright © 2016 Girish Adiga . All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
class MapLocations: NSObject,MKAnnotation {
    
    // Generic model for representing a location in map
    var state:String
    var loctype:String
    var address:String
    var city:String
    var zip:String
    var locationName:String
    var lat:String
    var long:String
    var facilitytype:String?
    var distance:String?
    // can be used to specify what image required dynamically based on facility type
    var annotationImage:String?
    var coordinate:CLLocationCoordinate2D{
        get {
            return CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        }
    }
    
    var title: String? { get{return locationName} }
    
    var identifier: String? { get{return locationName} }
    
    init(state:String,address:String,city:String,zip:String,name:String,lat:String,long:String,loctype:String) {
        
        self.state = state
        self.address = address
        self.city = city
        self.zip = zip
        self.locationName = name
        self.lat = lat
        self.long = long
        self.loctype = loctype
        
        super.init()
        
    }
    
    convenience init(data:Dictionary<String, AnyObject>) {
        self.init(state:data["state"] as! String,address:data["address"] as! String,city:data["city"] as! String,zip:data["zip"] as! String,name:data["name"] as! String,lat: data["lat"] as! String, long:data["lng"] as! String,loctype:data["locType"] as! String)
        self.distance = data["distance"] as? String
        self.facilitytype = data["locType"] as? String
    }
    
    
}
