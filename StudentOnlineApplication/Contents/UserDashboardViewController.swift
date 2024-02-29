//
//  UserDashboardViewController.swift
//  StudentOnlineApplication
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit
import CoreData

class UserDashboardViewController: UIViewController {

    @IBOutlet weak var LogOutBtn: UIButton!
    @IBOutlet weak var aplikoButton: UIButton!
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
        aplikoButton.layer.cornerRadius = 10
        LogOutBtn.layer.cornerRadius = 10        // Do any additional setup after loading the view.
    }
    func createApplication(emri: String, mbiemri: String, emriPrindit: String, nrPersonal: String, komuna: String,gjinia: String, suksesi: Double, fakulteti: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            showAlert(message: "Unable to fetch app delegate")
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let newUser = Aplikimi(context: managedContext)
        newUser.name = emri
        newUser.surname = mbiemri
        newUser.parentname = emriPrindit
        newUser.city = komuna
        newUser.gender = gjinia
        newUser.grade = suksesi
        newUser.faculty = fakulteti
        newUser.id = nrPersonal
      
        
        do {
            try managedContext.save()
            showAlert(message: "Aplikimi u krye me sukses")
        } catch {
            showAlert(message: "Something went wrong. Try again!")
        }
    }
    

    @IBAction func logOutBtn(_ sender: Any) {
        if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                       self.navigationController?.pushViewController(loginViewController, animated: true)
               }
    }
    @IBAction func aplikoForm(_ sender: UIButton) {
       guard let emri = txtEmri.text, !emri.isEmpty,
             let emriPrindit = txtEmriPrindit.text, !emriPrindit.isEmpty,
             let mbiemri = txtMbiemri.text, !mbiemri.isEmpty,
             let id = txtID.text, !id.isEmpty,
             let komuna = txtKomuna.text, !komuna.isEmpty, // Comma added here
             let gjinia = txtGjinia.text, !gjinia.isEmpty,
             let suksesiString = txtSuksesi.text, !suksesiString.isEmpty,
             let suksesi = Double(suksesiString),
             let fakulteti = txtFakulteti.text, !fakulteti.isEmpty else {
           showAlert(message: "Shtyp te dhenat")
           return
       }
        createApplication(emri: emri, mbiemri: mbiemri, emriPrindit: emriPrindit, nrPersonal: id, komuna: komuna,gjinia: gjinia, suksesi: suksesi, fakulteti: fakulteti)
        resetFields()

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
    func resetFields(){
        txtFakulteti.text = ""
        txtEmri.text = ""
        txtEmriPrindit.text = ""
        txtMbiemri.text = ""
        txtSuksesi.text = ""
        txtID.text = ""
        txtGjinia.text = ""
        txtKomuna.text = ""
        
    }
    

}
