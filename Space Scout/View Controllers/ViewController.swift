//
//  ViewController.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/18/22.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    var stackView = UIStackView()
    var loginButton = UIButton()
    var signUpButton = UIButton()
    
    var videoPlayer: AVPlayer?
    
    var videoPlayerLayer: AVPlayerLayer?
    
    var mainLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        styleElements()
       
        
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
     
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(loginButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    func setUpVideo() {
        // Create Video Player Object
        let bundlePath = Bundle.main.path(forResource: "video", ofType: "mp4")
        
        guard bundlePath != nil else{
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: url)
                
        // Create Player
        videoPlayer = AVPlayer(playerItem: item)
        
        //Create Layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust Size and Frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add to View and Play
        videoPlayer?.playImmediately(atRate: 0.5)
    }

    @objc func didTapSignUp(){
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func didTapLogin(){
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    func styleElements(){
        /// Sign Up Button
        signUpButton.setTitleColor(.systemMint, for: .normal)
        signUpButton.setTitle("Sign Up", for: .normal)
        
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
//        signUpButton.backgroundColor = UIColor.systemMint.withAlphaComponent(0.8)
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.systemMint.cgColor
        signUpButton.layer.cornerRadius = 40
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)
        
        
        /// Login Button
        loginButton.setTitleColor(.systemMint, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
//        loginButton.backgroundColor = UIColor.systemMint.withAlphaComponent(0.8)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.systemMint.cgColor
        loginButton.layer.cornerRadius = 40
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        mainLabel.text = "Space\nScout"
        mainLabel.textAlignment = .center
        mainLabel.textColor = .systemMint
        mainLabel.font = UIFont(name: "Chalkduster", size: 60)
        mainLabel.numberOfLines = 2
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainLabel)
        
    }
    
    
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
}

