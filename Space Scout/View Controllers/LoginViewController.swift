//
//  LoginViewController.swift
//  Space Scout
//
//  Created by Rohit Valiveti on 1/18/22.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var stackView = UIStackView()
    var emailTxtField = UITextField()
    var pwdTextField = UITextField()
    var loginButton = UIButton()
    var errorLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpElements()
      
        loginButton.addTarget(self, action: #selector(didTaplogin), for: .touchUpInside)

        
        setUpConstraints()
    }
    
    @objc func didTaplogin(){
        // Validate Text Fields
        let error: String? = validateFields()
        
        if error != nil {
            showError(error!)
        } else{
            let email = emailTxtField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = pwdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Sign in User
            Auth.auth().signIn(withEmail: email, password: password) { response, error in
                
                if error != nil{
                    // Error signing in
                    self.showError(error!.localizedDescription)
                    
                } else{
                    let uid = response!.user.uid
                    // Change to Home Screen, passing in user's uid
                    let tabVarVC = UITabBarController()
                    
                    let homeVC = UINavigationController(rootViewController: HomeViewController(userUID: uid))
                    homeVC.title = "Feed"
                    let editPfp = UINavigationController(rootViewController: EditPfpViewController(userUID: uid))
                    editPfp.title = "Edit Profile"
                    
                    tabVarVC.setViewControllers([homeVC, editPfp], animated: false)
                    
                    tabVarVC.modalPresentationStyle = .fullScreen
                    self.present(tabVarVC, animated: true)
                    
//                    self.view.window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
//                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
    func showError(_ msg: String){
        errorLabel.text = msg
        errorLabel.alpha = 1
    }
    
    func validateFields() -> String?{
        if  emailTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pwdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Fill in all fields."
        }
        return nil
    }
    
    
    
    func setUpElements(){
        /// Email Text Field
        emailTxtField.placeholder = "Email"
        emailTxtField.layer.addSublayer(Styler.makeBottomLine())
        emailTxtField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTxtField)
        
        /// Password Text Field
        pwdTextField.placeholder = "Password"
        pwdTextField.layer.addSublayer(Styler.makeBottomLine())
        pwdTextField.isSecureTextEntry = true
        pwdTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pwdTextField)
        
        /// Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.setTitleColor(.systemMint, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        /// Error Label
        errorLabel.text = "Error"
        errorLabel.textAlignment = .center
        errorLabel.textColor = .systemRed
        errorLabel.alpha = 0
        errorLabel.numberOfLines = 3
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorLabel)
        
        /// Stack View
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(emailTxtField)
        stackView.addArrangedSubview(pwdTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(errorLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            emailTxtField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            pwdTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor)
        ])
    }
}
