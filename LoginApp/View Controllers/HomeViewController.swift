//
//  HomeViewController.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/18/22.
//

import UIKit

class HomeViewController: UIViewController {
    var appearance = UINavigationBarAppearance()
    
    var tableView = UITableView()
    var reuseCellID = "TableView Cell"
    
    var data:[Scout]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
        data = fetchDummyData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: reuseCellID)
        
       
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        setUpConstraints()
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
    }
    
    func fetchDummyData() -> [Scout]{
        let s1 = Scout(username: "kevindurant35", name: "Kevin Durant", msg: "I See the Moon")
        let s2 = Scout(username: "lebronjames23", name: "Lebron James", msg: "I can see the stars!")
        let s3 = Scout(username: "stephcurry30", name: "Steph Curry", msg: "Look at the sky right Now!")
        
        return [s1, s2, s3]
    }


}

extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellID, for: indexPath) as! FeedTableViewCell
        cell.configure(data[indexPath.row])
        return cell
        
    }
    
    
}
