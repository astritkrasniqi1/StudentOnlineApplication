//
//  LoginViewController.swift
//  StudentOnlineApplication
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var wrongPassword: UILabel!
    @IBOutlet weak var wrongEmail: UILabel!
    @IBOutlet weak var txtPhoto: UIImageView!
    @IBOutlet weak var notRegistre: UILabel!
    @IBOutlet weak var forgotPassword: UILabel!
    @IBOutlet weak var typePassword: UITextField!
    @IBOutlet weak var VazhdoBtn: UIButton!
    @IBOutlet weak var txtPassword: UILabel!
    @IBOutlet weak var typeEmail: UITextField!
    @IBOutlet weak var txtEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        VazhdoBtn.layer.cornerRadius = 10
        view.backgroundColor = UIColor.lightGray
        
        
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func submitForm(_ sender: UIButton) {
        
        
        let emailText = typeEmail.text ?? ""
        let pwText = typePassword.text ?? ""
        if emailText.isEmpty && pwText.isEmpty{
            showAlert(message: "Mbushni te gjitha fushat")
            wrongEmail.isHidden = true
            wrongPassword.isHidden = true
        }
        else if emailText.isEmpty && !pwText.isEmpty{
            wrongEmail.text = "Ju lutem plotesoni nr. personal"
            wrongEmail.isHidden = false
            wrongPassword.isHidden = true
            wrongEmail.sizeToFit()
            wrongEmail.textColor = UIColor(red: 235/255, green: 64/255, blue: 52/255, alpha: 1)
            return
        }
        else if !emailText.isEmpty && pwText.isEmpty{
            wrongPassword.text = "Ju lutem plotesoni fjalekalimin"
            wrongEmail.isHidden = true
            wrongPassword.isHidden = false
            wrongPassword.sizeToFit()
            wrongPassword.textColor = UIColor(red: 235/255, green: 64/255, blue: 52/255, alpha: 1)
            return
        }
        
            
             if isValidLogin(typeEmail: emailText, typePassword: pwText) {
                    // Credentials are correct, navigate to the dashboard
                    UserDefaults.standard.set(emailText, forKey: "Email")
            let role = getUserRole(email: emailText)
            switch role {
            case 0:
                // Admin dashboard
                if let adminDashboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminDashboardView") as? AdminDashboardViewController {
                navigationController?.pushViewController(adminDashboard, animated: true)}
            case 1:
                // User dashboard
                if let userDashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDashboardViewController") as? UserDashboardViewController {
                    navigationController?.pushViewController(userDashboardVC, animated: true)}
            default:
                // Handle other cases if needed
                print("Invalid role")
            }
                }else {
                    // Credentials are incorrect, show alert
                    showAlert(message: "Kredencialet Jane gabim")
                }
                
    }
        
        
    
   func isValidLogin(typeEmail: String, typePassword: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return false
            }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Useri> = Useri.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@",typeEmail, typePassword)
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            if let users = result as? [NSManagedObject], !users.isEmpty{
                return true
            }
        }catch{
            print("Error fetching user data: \(error.localizedDescription)")
        }
        return false
    }
    

    
 
    @IBAction func signupForm(_ sender: UIButton) {
    }
    
    func showAlert(message: String) {
          let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(okAction)
          present(alert, animated: true, completion: nil)
      }
    func getUserRole(email: String) -> Int? {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Useri> = Useri.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                return Int(user.role) // Assuming role is stored as an integer attribute
            }
        } catch {
            print("Error fetching user data: \(error)")
        }
        
        return nil // Return nil if user not found or error occurred
    }
 
    

}


