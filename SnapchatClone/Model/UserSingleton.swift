//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Ali serkan Boyracı  on 9.12.2022.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = "" // if you need more varible define from user and want to  carry between VC's, you must define it here.
    
    
    private init() {
        
        
    }
    
}
