//
//  NetworkManager.swift
//  Space Scout
//
//  Created by Rohit Valiveti on 1/20/22.
//

import Foundation
import Firebase
import FirebaseAuth

class NetworkManager {
    
   // Load all data into an array of Scout Objects
//    static func getAllScouts() -> [Scout]? {
//        let db = Firestore.firestore()
//        db.collection("scouts").getDocuments { querySnapshot, error in
//            if let error = error {
//                    print("Error getting documents: \(error)")
//            } else {
//                for document in querySnapshot!.documents {
//
//
//                }
//                let arr = querySnapshot!.documents
//            }
//            return nil
//        }
    

        
    
    static func publishNewScout(uid: String, msg: String) {
        let db = Firestore.firestore()
        db.collection("scouts").addDocument(data: ["msg": msg,"uid": uid])
    }
    
}
