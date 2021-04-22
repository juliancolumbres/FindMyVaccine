//
//  VaccineViewController.swift
//  FindMyVaccine
//
//  Created by Tran Duc Quang on 4/16/21.
//

import UIKit

class VaccineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
<<<<<<< Updated upstream

=======
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
        
        cell.providerName?.text = "Provider Name"
        cell.appoinment?.text = "Appointment status"
        return cell
    }
>>>>>>> Stashed changes
}
