//
//  ViewControllerTripDetails.swift
//  TravelGoals
//
//  Created by Manoj Bandara on 26/5/19.
//  Copyright © 2019 Manoj Bandara. All rights reserved.
//

import UIKit

class ViewControllerTripDetails: UIViewController, UITableViewDataSource {


    @IBOutlet weak var titleAndCountry: UILabel!
    
    @IBOutlet weak var dates: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    @IBOutlet weak var plansTable: UITableView!
    
    var arrayIndex: Int?
    var trip: Trip?
    var plans = [Plan]()
    var tripsArray : [Trip]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripsArray = readJson()
        trip = tripsArray?[arrayIndex!]
        
        titleAndCountry.text = (trip?.name)! + " to " + (trip?.country)!
        dates.text = (trip?.startDate)! + " - " + (trip?.endDate)!
        descriptions.text = trip?.description
        plans = (trip?.plans)!
        
        if(trip?.isCompleted == 1) {
            markAsCompletedBtn.isEnabled = false
            addPlanbtn.isEnabled = false

            //deleteTripBtn.isEnabled = false
        }
        
        plansTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addPlansToTrip(_ sender: Any) {
        performSegue(withIdentifier: "addPlanScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addPlanScreen") {
            let addPlanViewController = segue.destination as! ViewControllerAddPlan
            addPlanViewController.startDate = trip?.startDate
            addPlanViewController.endDate = trip?.endDate
            addPlanViewController.tripIndexValue = arrayIndex
        }
    }
    
    @IBAction func editTrip(_ sender: Any) {
    }
    
    @IBAction func deleteTrip(_ sender: Any) {
        let result: Bool = deleteStudent(tripArray: tripsArray!, deleteIndex: arrayIndex!)
    
        if result == true {
            let alertController = UIAlertController(title: "Successful", message:
                "Trip deleted successfully", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            performSegue(withIdentifier: "FromTripDetailsBackToTrips", sender: self)
            self.present(alertController, animated: true, completion: nil)
            //segueBackFromDelete
            
        }
        
    }
    
    @IBOutlet weak var markAsCompletedBtn: UIButton!
    
    @IBOutlet weak var addPlanbtn: UIButton!
    @IBOutlet weak var deleteTripBtn: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = plans[indexPath.row].planName + " - " + plans[indexPath.row].planDescription
        cell.detailTextLabel?.text = plans[indexPath.row].planDate + " " + plans[indexPath.row].planTime
        return cell
    }
    
    @IBAction func marCompleted(_ sender: Any) {
        if (markTripAsCompleted(tripIndex: arrayIndex!) == true) {
            let alertController = UIAlertController(title: "Congratulations!", message:
                "for completing a trip!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            performSegue(withIdentifier: "FromTripDetailsBackToTrips", sender: self)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func reloadTable(_ sender: Any) {
    
    }
    
    
    
   

}
