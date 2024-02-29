//
//  ViewController.swift
//  StudentOnlineApplication
//
//  Created by THIS on 27.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet weak var passwordMatchError: UILabel!
    @IBOutlet weak var txtTelefoni: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMbiemri: UITextField!
    @IBOutlet weak var txtEmri: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func createUser(emri: String, mbiemri: String, password: String, telefoni: String, email: String,role: Int16){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            showAlert(message: "Unable to fetch app delegate")
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let newUser = Useri(context: managedContext)
        newUser.name = emri
        newUser.surname = mbiemri
        newUser.password = password
        newUser.phone = telefoni
        newUser.email = email
        newUser.role = role
        
        do {
            try managedContext.save()
            print("Regjistrimi u krye me sukses")
        } catch {
            showAlert(message: "Something went wrong. Try again!")
        }
    }


    @IBAction func submitForm(_ sender: UIButton) {
      guard let name = txtEmri.text, !name.isEmpty,
                let surname = txtMbiemri.text, !surname.isEmpty,
                let password = txtPassword.text, !password.isEmpty,
                let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty,
                let email = txtEmail.text, !email.isEmpty,
                let nrTelefonit = txtTelefoni.text, !nrTelefonit.isEmpty else {
                  showAlert(message: "Shtyp te gjitha te dhenat")
                  return
          }
        guard password == confirmPassword else {
            passwordMatchError.text = "Passwords do not match"
            passwordMatchError.isHidden = false
            return
        }
         
        createUser(emri: name, mbiemri: surname, password: password, telefoni: nrTelefonit, email: email, role: 1)
        resetFields()
        
          showAlertWithCompletion(message: "Llogaria u krija") {
                    // Navigate to the login view
                if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    self.navigationController?.pushViewController(loginViewController, animated: true)
            }

    }
    }
    
      func showAlert(message: String) {
          let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(okAction)
          present(alert, animated: true, completion: nil)
      }
    func showAlertWithCompletion(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
        func resetFields(){
        txtTelefoni.text = ""
        txtEmri.text = ""
        txtEmail.text = ""
        txtMbiemri.text = ""
        txtPassword.text = ""
        
    }
}

