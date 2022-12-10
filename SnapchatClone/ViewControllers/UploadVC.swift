//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Ali serkan Boyracı  on 5.12.2022.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseCore

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate { // to add picker add delegates  

    @IBOutlet var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func choosePicture() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func uploadClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media") // to put our image files folder
        
        
        // try to take UIImageView and change it to data
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg") //to take medaifolder as a uuid.jpg format
            
            imageReference.putData(data, metadata: nil) { (metada, error) in
                if error != nil {
                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error")
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            let fireStore = Firestore.firestore() // to reach Firestore
                            
                            let snapDictionary = ["imageUrl": imageUrl!, "snapOwner": UserSingleton.sharedUserInfo.username, "date":FieldValue.serverTimestamp()]
                            as [String:Any]
                            //we need url. username(takingfrom singleton, date
                            
                            fireStore.collection("Snaps").addDocument(data: snapDictionary) { (error) in // to save firestore
                                if error != nil {
                                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error")
                                } else {
                                    self.tabBarController?.selectedIndex = 0
                                    self.uploadImageView.image = UIImage(named: "select.png")
                                }
                            }
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
