//
//  ViewControllerAddTrip.swift
//  TravelGoals
//
//  Created by Manoj Bandara on 25/5/19.
//  Copyright © 2019 Manoj Bandara. All rights reserved.
//

import UIKit
import CountryList


class ViewControllerAddTrip: UIViewController, CountryListDelegate {

    var countryList = CountryList()
    @IBOutlet weak var textCountry: UITextField!
    

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var lblErrorName: UILabel!
    @IBOutlet weak var lblErrorCountry: UILabel!
    @IBOutlet weak var lblErrorStartDate: UILabel!
    
    @IBOutlet weak var lblErrorDescription: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    
    var datePicker : UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblError.isHidden = true
        lblErrorName.isHidden = true
        lblErrorCountry.isHidden = true
        lblErrorStartDate.isHidden = true
        lblErrorDescription.isHidden = true

        countryList.delegate = self
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(ViewControllerAddTrip.startDateValueChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
        let datePicker2 = UIDatePicker()
        datePicker2.datePickerMode = UIDatePickerMode.date
        datePicker2.addTarget(self, action: #selector(ViewControllerAddTrip.endDateValueChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
        txtStartDate.inputView = datePicker
        txtEndDate.inputView = datePicker2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func endDateValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtEndDate.text = dateFormatter.string(from: datePicker.date)
        checkDate(startDate: txtStartDate.text!, endDate: txtEndDate.text!)
    }
  
    @objc func startDateValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtStartDate.text = dateFormatter.string(from: datePicker.date)
        checkDate(startDate: txtStartDate.text!, endDate: txtEndDate.text!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func selectedCountry(country: Country) {
        //print(country.name)
        textCountry.text = country.name!
        
    }
    
    @IBAction func textCountryTap(_ sender: Any) {
        print("textfield tap")
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    func checkDate(startDate: String, endDate:String) {
        //print("Inside check date validation")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let start = dateFormatter.date(from: startDate) {
            if let end = dateFormatter.date(from: endDate) {
                //print("inside date checker")
                if(start > end) {
                    //print("inside validation fail")
                    lblError.text = "End date has to be after the start date"
                    lblError.isHidden = false
                }
                else {
                    lblError.isHidden = true
                }
            }
        }
    }
    
    @IBAction func btnAddTripSave(_ sender: Any) {
        let name  = txtName.text
        let country = textCountry.text
        let startDate = txtStartDate.text
        let endDate = txtEndDate.text
        let description = txtDescription.text
        
        if(name?.isEmpty == true) {
            lblErrorName.text = "Please enter a name"
            lblErrorName.isHidden = false
        } else {
            lblErrorName.isHidden = true
            
            if(country?.isEmpty == true) {
                lblErrorCountry.text = "Please select a country"
                lblErrorCountry.isHidden = false
            } else {
                lblErrorCountry.isHidden = true
                
                if(startDate?.isEmpty == true) {
                    lblErrorStartDate.text = "Please select start Date"
                    lblErrorStartDate.isHidden = false
                } else {
                    lblErrorStartDate.isHidden = true
                    
                    if(endDate?.isEmpty == true) {
                        lblError.text = "Please select end Date"
                        lblError.isHidden = false
                    } else {
                        lblError.isHidden = true
                        
                        if(description?.isEmpty == true) {
                            lblErrorDescription.text = "Please enter a description"
                            lblErrorDescription.isHidden = false
                        } else {
                            lblErrorDescription.isHidden = true
                        
                            print("Validation passed")
                            let addTripResult = addTrip(pname: name!, pcountry: country!, pstartDate: startDate!, pendDate: endDate!, pdescription: description!)
                            if(addTripResult==true) {
                                let alertController = UIAlertController(title: "Successful", message:
                                    "Trip sucessfully added!", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                                performSegue(withIdentifier: "addTripToTrips", sender: self)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                        }
                    }
                    
                }
            }
            
        }
//            let alertController = UIAlertController(title: "Invalid Input", message:
//                "Cannot keep first name field empty!", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//            self.present(alertController, animated: true, completion: nil)
            
        
    }
    


}
