//
//  UserDashboardViewController.swift
//  StudentOnlineApplication
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit

class UserDashboardViewController: UIViewController {

    @IBOutlet weak var txtFakulteti: UITextField!
    @IBOutlet weak var txtSuksesi: UITextField!
    @IBOutlet weak var txtGjinia: UITextField!
    @IBOutlet weak var txtKomuna: UITextField!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtMbiemri: UITextField!
    @IBOutlet weak var txtEmriPrindit: UITextField!
    @IBOutlet weak var txtEmri: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func aplikoForm(_ sender: UIButton) {
       guard let emri = txtEmri.text, !emri.isEmpty,
             let emriPrindit = txtEmriPrindit.text, !emriPrindit.isEmpty,
             let mbiemri = txtMbiemri.text, !mbiemri.isEmpty,
             let id = txtID.text, !id.isEmpty,
             let komuna = txtKomuna.text, !komuna.isEmpty, // Comma added here
             let gjinia = txtGjinia.text, !gjinia.isEmpty,
             let suksesi = txtSuksesi.text, !suksesi.isEmpty,
             let fakulteti = txtFakulteti.text, !fakulteti.isEmpty else {
           showAlert(message: "Shtyp te dhenat")
           return
       }

    }
    func showAlert(message: String) {
        // Check if the current view controller is already presenting something
        if let presentedViewController = self.presentedViewController {
            // Dismiss the currently presented view controller
            presentedViewController.dismiss(animated: false) {
                // Present the alert from the current view controller
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            // If no view controller is currently being presented, directly present the alert
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
