//
//  ViewController.swift
//  StudentOnlineApplication
//
//  Created by THIS on 27.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        
          showAlertWithCompletion(message: "Llogaria u krija") {
                    // Navigate to the login view
                    self.navigationController?.popViewController(animated: true)
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
}
