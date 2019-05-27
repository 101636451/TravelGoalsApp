//
//  ViewControllerAddPlan.swift
//  TravelGoals
//
//  Created by Manoj Bandara on 26/5/19.
//  Copyright © 2019 Manoj Bandara. All rights reserved.
//

import UIKit

class ViewControllerAddPlan: UIViewController {

    
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtDate: UITextField!
    
    @IBOutlet weak var txtTime: UITextField!
    
    @IBOutlet weak var txtDescription: UITextField!
    
    @IBOutlet weak var lblErrorName: UILabel!
    @IBOutlet weak var lblErrorDate: UILabel!
    @IBOutlet weak var lblErrorTime: UILabel!
    @IBOutlet weak var lblErrorDesc: UILabel!
    
    var datePicker : UIDatePicker?
    
    var startDate : String?
    var endDate : String?
    var tripIndexValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblErrorDate.isHidden = true
        lblErrorName.isHidden = true
        lblErrorDesc.isHidden = true
        lblErrorTime.isHidden = true
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(ViewControllerAddPlan.dateValueChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
        txtDate.inputView = datePicker
        // Do any additional setup after loading the view.
    }
    
    @objc func dateValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtDate.text = dateFormatter.string(from: datePicker.date)
        checkDate(plandate: txtDate.text!, startDate: startDate!, endDate: endDate!)
    }
    
    func checkDate(plandate: String, startDate: String, endDate: String)-> Bool {
        //print("Inside check date validation")
        var result : Bool = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
       
        if let planDate = dateFormatter.date(from: plandate) {
            if let start = dateFormatter.date(from: startDate) {
                if let end = dateFormatter.date(from: endDate) {
                    if(planDate < start) {
                        lblErrorDate.text = "date has to be between trip dates"
                        lblErrorDate.isHidden = false
                    } else {
                        if(planDate > end) {
                            lblErrorDate.text = "date has to be between trip dates"
                            lblErrorDate.isHidden = false
                        } else {
                            result = true
                            lblErrorDate.isHidden = true
                            print("Successful")
                        }
                    }
                    
                }
                
            }
            
        }
        return result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backToTripDetailsFromAddPlan") {
            let detailViewController = segue.destination as! ViewControllerTripDetails
            detailViewController.arrayIndex = tripIndexValue
            //detailViewController.trip = tripArray[selectedIndex!]
        }
    }
    
    @IBAction func btnSavePlan(_ sender: Any) {
        
        let planName = txtName.text
        let planDate = txtDate.text
        let planTime = txtTime.text
        let planDesc = txtDescription.text
        
        if(planName?.isEmpty == true) {
            lblErrorName.text = "Please enter plan name"
            lblErrorName.isHidden = false
        } else {
            lblErrorName.isHidden = true
            
            if(planDate?.isEmpty == true) {
                lblErrorDate.text = "Please enter plan name"
                lblErrorDate.isHidden = false
            } else {
                lblErrorDate.isHidden = true
                
                if(checkDate(plandate: txtDate.text!, startDate: startDate!, endDate: endDate!) == false) {
                    lblErrorDate.text = "date has to be between trip dates"
                    lblErrorDate.isHidden = false
                } else {
                    lblErrorDate.isHidden = true
                    
                    if(planTime?.isEmpty == true) {
                        lblErrorTime.text = "Please enter plan Time"
                        lblErrorTime.isHidden = false
                    } else {
                        lblErrorTime.isHidden = true
                        
                        if(planDesc?.isEmpty == true) {
                            lblErrorDesc.text = "Please enter plan Time"
                            lblErrorDesc.isHidden = false
                        } else {
                            lblErrorDesc.isHidden = true
                            
                            let addPlanResult = addPlam(pname: planName!, pDate: planDate!, pTime: planTime!, pdescription: planDesc!, tripIndex: tripIndexValue!)
                            if(addPlanResult==true) {
                                let alertController = UIAlertController(title: "Successful", message:
                                    "Plan sucessfully added!", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                                performSegue(withIdentifier: "backToTripDetailsFromAddPlan", sender: self)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                            
                        }
                    }
                }
            }
        }
    
    
    }
    
    
    
    
    //    @IBAction func btnSave(_ sender: Any) {
    //
    //        let planName = name.text
    //        let planDate = date.text
    //        let planTime = time.text
    //        let plandesc = desc.text
    //
    //        if(planName?.isEmpty == true) {
    //            lblErrorName.text = "Please enter a name"
    //            lblErrorName.isHidden = false
    //        }
    //
    //
    //    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
