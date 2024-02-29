//
//  AdminDashboardViewController.swift
//  StudentOnlineApplication
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit
import CoreData

class AdminDashboardViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var LogOutBtn: UIButton!
    @IBOutlet weak var NameDisplayLbl: UILabel!
    @IBOutlet weak var AdminTable: UITableView!
    
    var items: [Aplikimi] = []
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
       override func viewDidLoad() {
        navigationItem.hidesBackButton = true
           super.viewDidLoad()
        LogOutBtn.layer.cornerRadius = 10
        AdminTable.backgroundColor = UIColor.lightGray
            loginSuccess()
           
           // Fetch data when view loads
          items = fetchData(context: context)
           
           // Set tableView data source
           AdminTable.dataSource = self
       }
    
    @IBAction func LogOut(_ sender: Any) {
        if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    func loginSuccess() {
        // Retrieve email from UserDefaults
        if let email = UserDefaults.standard.string(forKey: "Email") {
            // Fetch admin's data from the database based on the email
            if let adminData = fetchAdminData(email: email) {
                // Set the loggedInAdmin property
               
                
                // Display the name and surname of the admin
                if let name = adminData.name, let surname = adminData.surname {
                    NameDisplayLbl.text = "Welcome \(name) \(surname)"
                }
            }
        }
    }
  

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return items.count
       }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           let item = items[indexPath.row]
           
           // Safely unwrap optionals and concatenate non-nil values
           var displayText = ""
           if let name = item.name, let surname = item.surname {
               displayText += "\(name) \(surname) "
           }
           if let parentname = item.parentname {
               displayText += "\(parentname) "
           }
           if let city = item.city {
               displayText += "\(city) "
           }
           if let gender = item.gender {
               displayText += "\(gender) "
           }
           displayText += "\(item.grade) "
           if let faculty = item.faculty {
               displayText += "\(faculty)"
           }
           
           cell.textLabel?.text = displayText
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
                  
           return cell
       }
    func tableView(_ tableView: UITableView, editingStyleRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from the data source
            let itemToRemove = items[indexPath.row]
            context.delete(itemToRemove)
            
            // Save the context
            do {
                try context.save()
                // Remove the item from the items array
                items.remove(at: indexPath.row)
                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting item: \(error)")
            }
        }
    }
   


}
func fetchData(context: NSManagedObjectContext) -> [Aplikimi] {
    let fetchRequest: NSFetchRequest<Aplikimi> = Aplikimi.fetchRequest()
    do {
        let items = try context.fetch(fetchRequest)
        return items
    } catch {
        print("Error fetching data: \(error)")
        return []
    }
}
func fetchAdminData(email: String) -> Useri? {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Useri> = Useri.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "email == %@", email)
    
    do {
        let admins = try context.fetch(fetchRequest)
        return admins.first // Assuming there's only one admin with the given email
    } catch {
        print("Error fetching admin data: \(error)")
        return nil
    }
}
