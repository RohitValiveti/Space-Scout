//
//  Scout.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/20/22.
//

import Foundation
import UIKit

struct ScoutResponse: Codable{
    var data: [Scout]
}

struct Scout: Codable {
//    var firstname: String
//    var lastname: String
//    var username: String
//    var msg: String
    
    var uid: String
    var msg: String
}
