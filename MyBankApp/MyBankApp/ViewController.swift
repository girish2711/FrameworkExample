//
//  ViewController.swift
//  MyBankApp
//
//  Created by Girish Adiga  on 10/9/16.
//  Copyright © 2016 Girish Adiga . All rights reserved.
//

import UIKit
import MyMapsKit


class ViewController: UIViewController,LocatioControllerDelegate, MyMapsDelegate {

    var currentLocation :LocatioController!
    var jpmcAtmsInMap : MyMapViewController!
    
    var currLat : String!
    var currLan : String!
    
    @IBOutlet weak var atmButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentLocation = LocatioController()
        currentLocation.delegate = self
        currentLocation.reuestLocationPermission()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // To be used to show JPMC ATMs
    @IBAction func showJPMCATMS(_ sender: AnyObject) {
        
        // Initialize map view controller
        jpmcAtmsInMap = MyMapViewController.instantiate()
        jpmcAtmsInMap.mapsDelegate = self;
        jpmcAtmsInMap.currentLattitude = currLat
        jpmcAtmsInMap.currentLongitude = currLan

        if let navigation = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        {
            navigation.navigationItem.title = "Chase Atm Locator"
            navigation.navigationItem.leftBarButtonItem = navigation.navigationItem.backBarButtonItem;
            navigation.isNavigationBarHidden = false
            navigation.navigationItem.leftBarButtonItem?.title = "test"
            navigation.setNavigationBarHidden(false, animated: true)
            navigation.pushViewController(jpmcAtmsInMap, animated: true)
            OperationQueue.main.addOperation(){
                //Do UI stuff only in main thread
                self.jpmcAtmsInMap.showAnnotationsFor(type: ATMS, annotationViewType: DEFAULT)
            }
            
        } else {
            
        }
        
        
        
    }
    

    // Location controller delegates
    // Get current location
    func getCurrentCords(lat:String,long:String) -> () {
        
        currentLocation.stopUpdation()

        self.currLat = lat
        self.currLan = long
        
        self.atmButton.setTitle("JPMC ATMs", for: UIControlState.normal)
        self.atmButton.isEnabled = true;
        
    }
    
    
    // Maps Kit Delegate implementation
    // Providing application base URL
    func apiBaseURL() -> String {
        
        return BankConstants.baseAPIUrl;
    }

}

