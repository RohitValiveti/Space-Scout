//
//  EditPfpViewController.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/20/22.
//

import UIKit
import Firebase
import FirebaseAuth

class EditPfpViewController: UIViewController {
    var appearance = UINavigationBarAppearance()
    
    var firstnameTxtField = UITextField()
    var lastnameTxtField = UITextField()
    var usernameTxtField = UITextField()
   
    var saveButton = UIButton()
    
    let userUID: String!
    let db = Firestore.firestore()
    
    init(userUID: String){
        self.userUID = userUID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
        
        setUpElements()
        
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        
        setUpConstraints()
    }
    
    @objc func didTapSave(){
        if !firstnameTxtField.hasText || !lastnameTxtField.hasText || !usernameTxtField.hasText {
            let alert = UIAlertController(title: "ERROR", message: "Please Fill in All Fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Return", style: .cancel, handler: { action in
                self.setUpTextFields()
            }))
            present(alert, animated: true)
        } else {
            db.collection("users").document(userUID).setData([
                "firstname": firstnameTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                "lastname": lastnameTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                "username": usernameTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            ])
            let alert = UIAlertController(title: "Success!", message: "Profile Updated", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in }))
            present(alert, animated: true)
        }
    }
    
    func setUpTextFields(){
        db.collection("users").document(userUID).getDocument(source: .default) { user, error in
            if error != nil{
                print("Error")
            } else {
                let data = user!.data()!
                self.firstnameTxtField.text = (data["firstname"] as! String)
                self.lastnameTxtField.text = (data["lastname"] as! String)
                self.usernameTxtField.text = (data["username"] as! String)
            }
        }
    }
    
    func setUpElements(){
        setUpTextFields()
        
        firstnameTxtField.layer.addSublayer(Styler.makeBottomLine())
        firstnameTxtField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstnameTxtField)
        
        lastnameTxtField.layer.addSublayer(Styler.makeBottomLine())
        lastnameTxtField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastnameTxtField)
        
        usernameTxtField.layer.addSublayer(Styler.makeBottomLine())
        usernameTxtField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTxtField)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 30)
        saveButton.setTitleColor(.systemMint, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
    }
    
    func setUpConstraints(){
        let padding = CGFloat(40)
        NSLayoutConstraint.activate([
            firstnameTxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            firstnameTxtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            firstnameTxtField.heightAnchor.constraint(equalToConstant: padding),
            firstnameTxtField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            lastnameTxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            lastnameTxtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            lastnameTxtField.heightAnchor.constraint(equalToConstant: padding),
            lastnameTxtField.topAnchor.constraint(equalTo: firstnameTxtField.bottomAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            usernameTxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTxtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTxtField.heightAnchor.constraint(equalToConstant: padding),
            usernameTxtField.topAnchor.constraint(equalTo: lastnameTxtField.bottomAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
    
    func setUpNavBar() {
        title = "Edit Profile"
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance =  navigationController?.navigationBar.standardAppearance
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}
