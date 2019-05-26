//
//  SecondViewController.swift
//  TravelGoals
//
//  Created by Manoj Bandara on 25/5/19.
//  Copyright © 2019 Manoj Bandara. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var tripArray = [Trip]()
    var selectedIndex: Int?
    
    @IBOutlet weak var tripsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tripArray = readJson()

        tripsTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tripsTable.reloadData()
    }

    @IBAction func addTrip(_ sender: Any) {
        performSegue(withIdentifier: "addTrip", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tripArray[indexPath.row].name
        cell.detailTextLabel?.text = tripArray[indexPath.row].country + " - " + tripArray[indexPath.row].startDate
        let imageName:String = "country_\(indexPath.row+1)"
        print("Image : \(imageName)")
        cell.imageView?.image = UIImage(named: imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        //print("\(tripArray[indexPath.row].fname) \(tripArray[indexPath.row].lname)")
        performSegue(withIdentifier: "tripsToTripDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "tripsToTripDetails") {
            let detailViewController = segue.destination as! ViewControllerTripDetails
            detailViewController.arrayIndex = selectedIndex
            detailViewController.trip = tripArray[selectedIndex!]
        }
    }
    
}

