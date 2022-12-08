//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Ali serkan Boyracı  on 5.12.2022.
//

import UIKit

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
    }
    
}
