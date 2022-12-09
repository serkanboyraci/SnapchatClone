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
    var username = ""
    
    
    private init() {
        
        
    }
    
}
