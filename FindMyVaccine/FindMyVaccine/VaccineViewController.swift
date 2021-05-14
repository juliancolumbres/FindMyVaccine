//
//  VaccineViewController.swift
//  FindMyVaccine
//
//  Created by Tran Duc Quang on 4/16/21.
//

import UIKit
import MapKit
import SwiftyJSON
import Foundation



class VaccineViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var numberOfLocations = 10
    var venues = [Venue]()
    
    func fetchData()
    {
        do {
            if let file = URL(string: "https://www.vaccinespotter.org/api/v0/states/CA.json") {
                let data = try Data(contentsOf: file)
                let json = try JSON(data: data)
                if let venueJSONs = json["features"].array {
                    for venueJSON in venueJSONs {
                        if let venue = Venue.from(json: venueJSON) {
                            let comparedLong = venue.coordinate.longitude - getCoordinates.long
                            let comparedLat = venue.coordinate.latitude - getCoordinates.lat
                            
                            if comparedLong <= 0.1 && comparedLat <= 0.1 && venue.appointmentsAvailable == true  {
                                self.venues.append(venue)
                            }
                        }
                    }
                    //print(self.venues.count)
                    //print("long \(getCoordinates.long)")
                }
            } else {
               print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        fetchData()
        
        // if there's not enough data to load
        if venues.count < 10 {
            numberOfLocations = venues.count
        }
        
/*
        searchBar.placeholder = "Search vaccine centers"
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        
        // dismiss keyboard
        tableView.keyboardDismissMode = .interactive
 */
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let venue = venues[indexPath.row]
        
        // pass selected venue to WebViewController
        
        let webViewController = segue.destination as! WebViewController
        
        webViewController.websiteUrl = venue.websiteUrl
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // changed from 20 to 30
        return numberOfLocations
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        // to load more places if at end of list
        if (indexPath.row + 1 == numberOfLocations && venues.count > numberOfLocations) {
            
            if (venues.count >= numberOfLocations + 10 ) {
                numberOfLocations = numberOfLocations + 10
            } else {
                numberOfLocations = venues.count
            }
            self.viewDidAppear(true)
        }
  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
        
        let venue = venues[indexPath.row]
        
        cell.providerName?.text = venue.title
        //cell.appoinment?.text = String(venues[0].appointmentsAvailable)
        if venue.appointmentsAvailable == true {
            cell.appoinment?.text = "Appoinment Available"
        }
        else{
            cell.appoinment?.text = "Appoinment Unavailable"
        }
            cell.location?.text = venue.combinedAddress
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
    }
}
