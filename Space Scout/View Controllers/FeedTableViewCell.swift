//
//  FeedTableViewCell.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/20/22.
//

import UIKit
import Firebase

class FeedTableViewCell: UITableViewCell {
    var name = UILabel()
    var username = UILabel()
    var msg = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpElements()
        
        
        
        setUpConstraints()
    }
    
   
    func setUpElements(){
        name.textColor = .systemMint
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(name)
        
        username.textColor = .systemGray2
        username.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(username)
        
        msg.textColor = .black
        msg.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(msg)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
            
        ])
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            username.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            msg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            msg.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5)
        ])
    }
    
    func configure(_ scout: Scout){
        let db = Firestore.firestore()
        let uid = scout.uid
        
        msg.text = scout.msg
        db.collection("users").document(uid).getDocument(source: .default) { user, error in
            if error != nil{
                print("Error")
            } else {
                let data = user!.data()!
                let firstname = (data["firstname"] as! String)
                let lastname = (data["lastname"] as! String)
                let userName = (data["username"] as! String)
                
                self.name.text = "\(firstname) \(lastname)"
                self.username.text = "@\(userName)"
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
