//
//  MyMapViewController.swift
//  MyMapsKit
//
//  Created by Girish Adiga  on 10/9/16.
//  Copyright © 2016 Girish Adiga . All rights reserved.
//

import UIKit
import MapKit


public protocol MyMapsDelegate {
    func apiBaseURL() -> String
};

// Public Maps kit function to be used for showing different places in the map
public class MyMapViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView : MKMapView!
    //! maps delegate
    public var mapsDelegate : MyMapsDelegate!
    //! Current lattitude
    public var currentLattitude : String!
    //! Current logitude
    public var currentLongitude : String!
    
    var myAnnotations:[MapLocations]!
    
    
    //! Use instatiate method get class instance.
    public static func instantiate() -> MyMapViewController
    {
        let frameworkBundle = Bundle(identifier: "com.photon.nw.MyMapsKit")
        
        return UIStoryboard(name: "MyMaps", bundle: frameworkBundle).instantiateViewController(withIdentifier: "BaseMapViewController") as! MyMapViewController
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        // Do any additional setup after loading the view.
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Add all annotations as per image requested
    func addAnootaions(obj:[MapLocations],annotationImage:AnnotationViewType)
    {
        // Annotationviewtype is symbolic here. Can be used to change type of the image
        for x in obj
        {
            let anot = x
            mapView.addAnnotation(anot)
        }
        self.mapView.delegate = self
    }
    
    //! Map kit will draw annotations based on Location type and specified image for annotation
    public func showAnnotationsFor(type:LocationTypes, annotationViewType:AnnotationViewType) {
        
        if ((currentLattitude != nil) && (currentLongitude != nil))  {
            switch type {
                // To be used for JPMC ATMs
            case ATMS:
                typealias locations = [MapLocations]
                
                _ = BankUtils.getNearbyFacitiy(lat: currentLattitude, long: currentLongitude, baseUrl: self.mapsDelegate.apiBaseURL()) { (data: [MapLocations]) in
                 self.addAnootaions(obj:data,annotationImage:annotationViewType)
                 let corrd = CLLocationCoordinate2D(latitude: Double(self.currentLattitude)!, longitude: Double(self.currentLongitude)!)
                 self.myAnnotations = data
                 let region = MKCoordinateRegion(center:corrd , span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta:0.025))
                 self.mapView.setRegion(region, animated: true)
                 }
                
                break
                // Other cases may be for branch, checque dropping locations etc
            default: break
            }
        } else {
            print("ERROR: Cannot function without current location. Set currentLattitude and currentLogitude")
        }
    }
    
    
    // Show annotation information view
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view : MKPinAnnotationView
        guard let annotation = annotation as? MapLocations else {return nil}
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier!) as? MKPinAnnotationView {
            view = dequeuedView
        }else { //make a new view
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
        }
        view.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
        view.canShowCallout = true
        return view
    }
    
    // Show details view on click of annotation information view
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print((view.annotation as! MapLocations).identifier!)
        let frameworkBundle = Bundle(identifier: "com.photon.nw.MyMapsKit")
        let tableView = LocationDetailsViewController(nibName: "LocationDetailsViewController", bundle: frameworkBundle)
         //print(tableView.address.text)
         if let navigation = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
         {
             navigation.navigationItem.title = "Chase Atm Locator"
             navigation.navigationItem.leftBarButtonItem = navigation.navigationItem.backBarButtonItem;
             navigation.isNavigationBarHidden = false
             navigation.navigationItem.leftBarButtonItem?.title = "test"
             //navigation.navigationBar.backgroundColor = UIColor.red
             navigation.setNavigationBarHidden(false, animated: true)
             
             
             
             navigation.pushViewController(tableView, animated: true)
             let currentfacility = view.annotation as! MapLocations
             let x = tableView.view
             tableView.updateLocation(currentfacility: currentfacility)
         
         
         }
    }
    
    
 @IBAction func completedWithMaps(_ sender: AnyObject) {
    self.dismiss(animated: true) { 
        print("");
    }
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
