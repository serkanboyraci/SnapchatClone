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
import SDWebImage



class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let fireStoreDatabase = Firestore.firestore() // to use another func, firstly define this constant
    var snapArray = [Snap]()
    var chosenSnap : Snap?
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        getSnapsFromFirebase()
        
        getUserInfo()
    }
    
    func getSnapsFromFirebase() {
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in // to every changeging needs update -> addsnapshot
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "ERROR!")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.snapArray.removeAll(keepingCapacity: true) // to erase befaore for loop
                    for document in snapshot!.documents { // to take data from firebase
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        // taking current date  and saving date calculate the difference.
                                        if difference >= 24 {
                                            //Delete
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete { (error) in
                                                // to show user a messaagekkkkk
                                                
                                            }
                                            
                                        } else {
                                            let snap = Snap(username: username, imageurlArray: imageUrlArray, date: date.dateValue(), timeDifference: 24 - difference )//to take date. use like this
                                            self.snapArray.append(snap)
                                            
                                        }
                                        
                                        // timeleft --> snapVC
                                        //self.timeLeft = 24 - difference
                                        
                                    
                                    }
                                   
                                }
                            }
                        }
                        
                        
                        
                    }
                    self.tableView.reloadData()
                }
            }
            
        }
        
        
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
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email! // Using Singleton to take data, becuse when opened Feed VC, we take data
                            UserSingleton.sharedUserInfo.username = username // after Feed VC we can use it Upload,Settings and SnapVC.
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count //changed with snaparray count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedUserNameLabel.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageurlArray[0]))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destinationVC = segue.destination as! SnapVC
            destinationVC.selectedSnap = chosenSnap
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
}
