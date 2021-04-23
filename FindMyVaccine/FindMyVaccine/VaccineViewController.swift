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

class VaccineViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

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
                            if venue.appointmentsAvailable {
                                self.venues.append(venue)
                            }
                        }
                    }
                    print(self.venues.count)
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
        fetchData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
        
        cell.providerName?.text = venues[0].title
        cell.appoinment?.text = "available"
        cell.location?.text = venues[0].combinedAddress
        return cell
    }
}
