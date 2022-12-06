//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Ali serkan Boyracı  on 4.12.2022.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth


class SignInVC: UIViewController {

    @IBOutlet var emailText: UITextField!
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        if passwordText.text != "" && emailText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (result, error) in // to select email and password.
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "Error", message: "Email/Password?")
            
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" && emailText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (auth, error) in // to create user in Firebase
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    let firestore = Firestore.firestore() // creating
                    
                    let userDictionary = ["email": self.emailText.text!, "username":self.usernameText.text!] as! [String : Any] //we choose what we eill take
                    firestore.collection("UserInfo").addDocument(data: userDictionary) { (error) in // created collection
                        if error != nil {
                            //
                        }
                    }
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            self.makeAlert(title: "Error", message: "Username/Password/Email???")
            
            
            
        }
        
        
    }
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

