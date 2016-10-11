//
//  LocationDetailsViewController.swift
//  MyMapsKit
//
//  Created by Girish Adiga  on 10/10/16.
//  Copyright © 2016 Girish Adiga . All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var facilityType: UILabel!
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var address: UILabel!
    

    
    
    func updateLocation(currentfacility:MapLocations)
    {
        self.address.text = currentfacility.address
        self.name.text = currentfacility.locationName
        self.Distance.text = currentfacility.distance
        self.facilityType.text = currentfacility.facilitytype
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
