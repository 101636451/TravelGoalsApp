//
//  ViewControllerMyTrips.swift
//  TravelGoals
//
//  Created by Manoj Bandara on 27/5/19.
//  Copyright © 2019 Manoj Bandara. All rights reserved.
//

import UIKit

class ViewControllerMyTrips: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var mytripArray = [Trip]()
    
    @IBOutlet weak var mytripsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mytripArray = readJson()
        mytripArray = mytripArray.filter {$0.isCompleted==0}
        mytripsTable.reloadData()
        mytripsTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mytripArray = readJson()
        mytripArray = mytripArray.filter {$0.isCompleted==0}
        mytripsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mytripArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "mytripCell")!
        cell.textLabel?.text = mytripArray[indexPath.row].name
        cell.detailTextLabel?.text = mytripArray[indexPath.row].country + " - " + mytripArray[indexPath.row].startDate
        let imageName:String = "country_\(indexPath.row+1)"
        print("Image : \(imageName)")
        cell.imageView?.image = UIImage(named: imageName)
        return cell
    }
    
    @IBOutlet weak var tripsSegment: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: Any) {
        switch tripsSegment.selectedSegmentIndex {
        case 0:
            mytripArray.removeAll()
            mytripArray = readJson()
            mytripArray = mytripArray.filter {$0.isCompleted==0}
            mytripsTable.reloadData()
            break
        case 1:
            mytripArray.removeAll()
            mytripArray = readJson()
            mytripArray = mytripArray.filter {$0.isCompleted==1}
            mytripsTable.reloadData()
            break
        default:
            break
        }
    
    }
    
    
}
