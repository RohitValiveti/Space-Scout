//
//  Scout.swift
//  Space Scout
//
//  Created by Rohit Valiveti on 1/20/22.
//

import Foundation
import UIKit

protocol DocumentSerializable{
    init?(dictionary: [String: Any])
}

struct Scout: Codable {
    var uid: String
    var msg: String
    
    var dictionary:[String:Any]{
        return[
            "msg": msg,
            "uid": uid
        ]
    }
}

extension Scout: DocumentSerializable{
    init?(dictionary: [String: Any]){
        guard let msg = dictionary["msg"] as? String,
              let uid = dictionary["uid"] as? String else {return nil}
        self.init(uid: uid, msg: msg)
    }
}
