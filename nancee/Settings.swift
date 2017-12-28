////
////  ProfileDashboard.swift
////  nancee
////
////  Created by Gary Sapozhnikov on 12/3/17.
////  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
////

import Foundation
import UIKit

public class NotificationsVC : UITableViewController{
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel! //renamed to currency
    @IBOutlet weak var ActualExchangeLabel: UILabel!
    @IBOutlet weak var AlertSwitch: UISwitch!
    @IBAction func SwitchAlertStatus(_ sender: UISwitch) {
        if buttonPressed == 1{
            defaults.set(AlertSwitch.isOn, forKey: "BTCAlertStatus")
        }else if buttonPressed == 2{
            defaults.set(AlertSwitch.isOn, forKey: "ETHAlertStatus")
        }else{
            defaults.set(AlertSwitch.isOn, forKey: "LTCAlertStatus")
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = "huh?"
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        if buttonPressed == 1{
            self.AlertSwitch.isOn = (defaults.object(forKey: "BTCAlertStatus") as! Bool)
        }else if buttonPressed == 2{
            self.AlertSwitch.isOn = (defaults.object(forKey: "ETHAlertStatus") as! Bool)
        }else{
            self.AlertSwitch.isOn = (defaults.object(forKey: "LTCAlertStatus") as! Bool)
            
        }
        
        //self.AlertSwitch.isOn = (defaults.object(forKey: "alertStatus") as! Bool)
        self.title = stnames[buttonPressed - 1]
       
        self.alertLabel.sizeToFit()
        self.exchangeLabel.text = (defaults.object(forKey: "currency") as! String)
        self.ActualExchangeLabel.text = (defaults.object(forKey: "exchange") as! String)
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 || indexPath.row == 3{
            rowSelected = indexPath.row
            self.performSegue(withIdentifier: "ToSettings", sender: nil)
        }
            
        
    }
}

public class SettingsVC : UITableViewController{
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if rowSelected == 2{
            self.title = "Select Currency"
        }
        else{
            self.title = "Select Exchange"
        }
    }
}






