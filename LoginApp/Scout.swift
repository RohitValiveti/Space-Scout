//
//  Scout.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/20/22.
//

import Foundation
import UIKit


class Scout {
    var username: String
    var name: String
    var msg: String
    
    init(username: String, name: String, msg: String){
        self.username = "@\(username)"
        self.name = name
        self.msg = msg
    }
        
    
}
