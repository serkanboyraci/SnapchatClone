//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Ali serkan Boyracı  on 5.12.2022.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseCore



class FeedVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let fireStoreDatabase = Firestore.firestore() // to use another func, firstly define this constant
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUserInfo()
    }
    func getUserInfo() {
        // to take documents from UserInfo // no need to use addsnapShotListener(check everytime changings), enough to take data only one time. use getdocuments
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            // first we need to use whereField
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil { // snapshot must be Full
                    for document in snapshot!.documents {// you can look at InstaCloneApp Project
                        if let username = document.get("username") as? String { //After taking data to use we need Singleton sturcture.
                            UserSingleton.sharedUserInfo.email =  Auth.auth().currentUser!.email! // Using Singleton to take data, becuse when opened Feed VC, we take data
                            UserSingleton.sharedUserInfo.email = username // after Feed VC we can use it Upload,Settings and SnapVC.
                        }
                            
                    }
                }
            }
        }
    }
    
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
}
