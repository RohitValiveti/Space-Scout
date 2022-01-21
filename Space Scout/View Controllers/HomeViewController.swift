//
//  HomeViewController.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/18/22.
//

import UIKit
import Firebase
//import FirebaseFirestoreSwift

class HomeViewController: UIViewController {
    var appearance = UINavigationBarAppearance()
    
    var tableView = UITableView()
    var reuseCellID = "TableView Cell"
    
    var scouts = [Scout]()
    
    
    let userUID: String!
    var barButton = UIBarButtonItem()
    
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
        scouts = fetchDummyData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: reuseCellID)
        
        
       
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        setUpConstraints()
//        getScouts()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setUpNavBar() {
        title = "Feed"
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance =  navigationController?.navigationBar.standardAppearance
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        barButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapButton))
        barButton.tintColor = .systemMint
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func didTapButton() {
        let newScoutAlert = UIAlertController(title: "New Scout", message: "Enter your Scout!", preferredStyle: .alert)
        
        
        newScoutAlert.addTextField { (textField:UITextField) in
                textField.placeholder = "Enter your message"
            }
        
        newScoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add message and uid to database and update feed
        newScoutAlert.addAction(UIAlertAction(title: "Publish", style: .default, handler: { action in
            NetworkManager.publishNewScout(uid: self.userUID, msg: newScoutAlert.textFields!.first!.text!)
            self.scouts += [Scout(uid: self.userUID, msg: newScoutAlert.textFields!.first!.text!)]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
        
        self.present(newScoutAlert, animated: true, completion: nil)
        
    }
    
    func fetchDummyData() -> [Scout] {
        let s1 = Scout(uid: "KgI9tcVinsZHL1r6UakA4hx9Si72", msg: "Rohit Test Msg")
        let s2 = Scout(uid: "N3IM1gWwEYaf2ZccxuWsPU50vBv1", msg: "Tatum Test Message")
        let s3 = Scout(uid: "Q55uLVhyPDQUT6mpzFGXvIkQLdv2", msg: "Brown Test Message")

        return [s1, s2, s3]
    }
    
//    func getScouts(){
//        let db = Firestore.firestore()
//        db.collection("scouts").addSnapshotListener { snapshot, error in
//            guard let documents = snapshot?.documents else {
//                print("No documents")
//                return
//            }
//            
//            self.scouts = documents.compactMap({ queryDocumentSnapshot in
//                self.scouts += try! [(queryDocumentSnapshot.data(as: Scout.self) ?? nil)!]
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//                return try? queryDocumentSnapshot.data(as: Scout.self)
//            })
//            
//            
////            self.scouts = documents.compactMap({ (queryDocumentSnapshot) -> Scout? in
////                return try? queryDocumentSnapshot.data(as: Scout.self)
////            })
//            
//        }
//    }
    



}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scouts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellID, for: indexPath) as! FeedTableViewCell
        cell.configure(scouts[indexPath.row])
        return cell
        
    }
    
    /// Delegate Methods

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //    }
}
