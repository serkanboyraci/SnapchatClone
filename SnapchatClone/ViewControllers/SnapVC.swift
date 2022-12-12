//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Ali serkan Boyracı  on 5.12.2022.
//

import UIKit

class SnapVC: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    
    var selectedSnap : Snap?
    var selectedTime : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let time = selectedTime {
            timeLabel.text = "Time Left: \(time) Hours"
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
