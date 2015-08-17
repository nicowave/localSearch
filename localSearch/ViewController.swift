//
//  ViewController.swift
//  localSearch
//
//  Created by Nicolas Roldos on 4/4/15.
//  Copyright (c) 2015 Nicolas Roldos. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchText: UITextField!
    
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
			mapView.showsUserLocation = true
    }
    
    
    
    
    func performSearch() {
        
        //matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler { (response: MKLocalSearchResponse!, error: NSError!)
            
            -> Void in
            
            if error != nil {
                println("Error occcured in search: \(error.localizedDescription)")
                
            } else if response.mapItems.count == 0 {
                println("No matches found")
        
            } else {
                println("Matches found")
                
                for item in response.mapItems as! [MKMapItem] {
                    
                    println("Name = \(item.name)")
                    println("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    println("Number of matching items = \(self.matchingItems.count)")
                    
                    var annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.mapView.addAnnotation(annotation)
                    
                }
                //'for' loop to iterated through search result matches contained in array 'response.mapItems'
                //...of type MKMapItem (map annotations?...)
            }
            //marks end of if else statements based on searchText input
        }
        //end of MKLocalSearch and its completion handler
    }
    //end of performSearch function...
    
    
    
    
    
    
    
    @IBAction func zoominClocation(sender: AnyObject) {
        
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 1000, 1000)
        
        mapView.setRegion(region, animated: true)
        //animated set to 'true' allows mapView to zoom to userLocation region after tapping 'Zoom' IBAction button
    }
    
    
    
    @IBAction func changeMap(sender: AnyObject) {
        
        if mapView.mapType == MKMapType.Standard {
            mapView.mapType = MKMapType.Satellite
            
        } else {
            mapView.mapType = MKMapType.Hybrid
        }
    }
    
    
    
    @IBAction func searchReturnAction(sender: AnyObject) {
        
        sender.resignFirstResponder()
        mapView.removeAnnotations(self.mapView.annotations)
        self.performSearch()
        
    }
    
    
    
    override func prepareForSegue(detailsSegue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = detailsSegue.destinationViewController as! SearchResultsTableViewController
        destination.mapItems = self.matchingItems
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

