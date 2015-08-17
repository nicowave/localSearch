//
//  RouteViewController.swift
//  localSearch
//
//  Created by Nicolas Roldos on 4/8/15.
//  Copyright (c) 2015 Nicolas Roldos. All rights reserved.
//



import UIKit
import MapKit


class RouteViewController: UIViewController, MKMapViewDelegate {
    
    var destination: MKMapItem?
    
    @IBOutlet weak var routeView: MKMapView!

    
    
    //overrride functions:
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        routeView.showsUserLocation = true
        routeView.delegate = self
        self.getDirections()
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }


    

    
    func getDirections() {
        
        let request = MKDirectionsRequest()
        request.setSource(MKMapItem.mapItemForCurrentLocation())
        request.setDestination(destination!)
        request.requestsAlternateRoutes = false
        //first route is usually the swiftest
        
        let directions  = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler (   {
            
            (response: MKDirectionsResponse!, error: NSError!) in
            
            if error != nil {
                
                println("Error in getting directions")
                
            } else {
                
                self.showRoute(response)
                
                                        }
                                        //end of if - else error/noError cases
                                            } )
                                            //end of completion handler
                                                }
                                                //marks end of getDirections function
    
    
    
    
    
    func showRoute(response: MKDirectionsResponse) {
        
        for route in response.routes as! [MKRoute]! {
            
            routeView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
            
            for step in route.steps {
                
                let userLocation = routeView.userLocation
                let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 1000, 1000)
                routeView.setRegion(region, animated: true)
            }
        }
    }
    
    
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!      {
            
        let renderer = MKPolygonRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.greenColor()
        renderer.lineWidth = 5.5
        return renderer
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
