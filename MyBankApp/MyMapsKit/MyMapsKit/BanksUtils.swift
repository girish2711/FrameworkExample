//
//  BanksUtils.swift
//  MyMapsKit
//
//  Created by Girish Adiga  on 10/9/16.
//  Copyright © 2016 Girish Adiga . All rights reserved.
//

import Foundation
// Utility clss for web services
class BankUtils {
    typealias locations = [MapLocations]
    class func getNearbyFacitiy(lat:String,long:String,baseUrl: String, closure:@escaping (_ obj:[MapLocations])->()) -> ([MapLocations]) {
        
        var Locations:[MapLocations] = []
        let urlWithLatLong = "\(baseUrl)lat=\(lat)&lng=\(long)"
        
        
        let requestURL: NSURL = NSURL(string: urlWithLatLong)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            // REST API result check.
            if (statusCode == 200) {
                
                do{
                    
                    let JSON = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    
                    let json = (JSON as?  NSDictionary)
                    let locations = json?["locations"] as! NSArray
                    for location in locations
                    {
                        Locations.append(MapLocations(data: location as! Dictionary<String, AnyObject>))
                    }
                    
                    closure(Locations)

                    
                }catch {
                    // Not able to parse JSON ?
                    print("Error: Garbge response \(error)")
                }
                
            } else {
                // Should be handled with right error response to upper layer
                print("Error: Service failure to find nearby bank facilities")
            }
        }
        
        // Start task
        task.resume()
        
        return Locations
        
    }
    
}
