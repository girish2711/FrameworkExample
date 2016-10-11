//
//  LocationController.swift
//  MyBankApp
//
//  Created by Girish Adiga  on 10/9/16.
//  Copyright © 2016 Girish Adiga . All rights reserved.
//

import Foundation
import CoreLocation


protocol LocatioControllerDelegate {
    func getCurrentCords(lat:String,long:String) -> ()
}

class LocatioController:NSObject,CLLocationManagerDelegate
{
    let manager:CLLocationManager
    var delegate:LocatioControllerDelegate!
    
    override init() {
        manager = CLLocationManager()
        manager.distanceFilter = 50
        manager.desiredAccuracy = 50
        super.init()
    }
    
    func reuestLocationPermission()
    {
        manager.delegate = self
//        manager.requestAlwaysAuthorization()
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways,.authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case  .restricted,.denied:break
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let lat = String(describing: location.coordinate.latitude)
        let long = String(describing: location.coordinate.longitude)
        print(location.horizontalAccuracy)
        print(location.verticalAccuracy)
        delegate.getCurrentCords(lat: lat, long: long)
        
    }
    
    func stopUpdation()
    {
        manager.stopUpdatingLocation()
    }
}
