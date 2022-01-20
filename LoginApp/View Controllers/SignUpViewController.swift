//
//  SignUpViewController.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/18/22.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    var stackView = UIStackView()
    
    var firstnameTxtField = UITextField()
    var lastnameTxtField = UITextField()
    var emailTxtField = UITextField()
    var pwdTextField = UITextField()
    var signUpButton = UIButton()
    var errorLabel = UILabel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpElements()

        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
 
    
        setUpConstraints()
    }
    
    
    @objc func didTapSignUp(){
        // Validate Fields
        let error: String? = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            let firstname = firstnameTxtField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastnameTxtField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTxtField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pwd = pwdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // Create User
            Auth.auth().createUser(withEmail: email, password: pwd) { (response, error) in
                
                // Check for Errors
                if error != nil{
                    // There was an error Creating user
                    self.showError("Error creating user")
                } else {
                    // User created, store first and last name in Auth database
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": firstname, "lastname": lastname, "uid": response!.user.uid]) { error in
                        if error != nil{
                            self.showError("There was an error saving user data.")
                        }
                    }
                    // Change to Home Screen
                    let tabVarVC = UITabBarController()
                    
                    let homeVC = UINavigationController(rootViewController: HomeViewController())
                    homeVC.title = "Feed"
                    let scoutVC = ScoutViewController()
                    scoutVC.title = "Scout"
                    let editPfp = UINavigationController(rootViewController: EditPfpViewController())
                    editPfp.title = "Edit Profile"
                    
                    tabVarVC.setViewControllers([homeVC,scoutVC, editPfp], animated: false)
                    
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
    
    /** Check Fields and Validate Data is Correct. If everything
     is correct, return nil, else return error message
     */
    func validateFields() -> String?{
        // Check all Fields not empty
        if firstnameTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastnameTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pwdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Fill in all fields."
        }
        
        // Check if password is valid
        let trimmedPwd = pwdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(trimmedPwd) == false{
            return "Password Must contain at least 8 characters, a special character, and a number."
        }
        
        // Check if email is in valid format
        let trimmedEmail = emailTxtField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isEmailValid(trimmedEmail) == false {
            return "Email is invalid."
        }
    
        return nil
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        // SRC: https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    private func isEmailValid(_ email: String) -> Bool{
        // SRC: https://iosdevcenters.blogspot.com/2015/12/email-phone-number-validation-in-swift.html
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let result = emailTest.evaluate(with: email)
            return result
    }
    


    func setUpElements(){
        
        /// First Name Text Field
        firstnameTxtField.placeholder = "First Name"
        firstnameTxtField.layer.addSublayer(Styler.makeBottomLine())
        firstnameTxtField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstnameTxtField)
        
        /// Last Name Text Field
        lastnameTxtField.placeholder = "Last Name"
        lastnameTxtField.layer.addSublayer(Styler.makeBottomLine())
        lastnameTxtField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastnameTxtField)
        
        
        /// Email Text Field
        emailTxtField.placeholder = "Email"
        emailTxtField.layer.addSublayer(Styler.makeBottomLine())
        emailTxtField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTxtField)
        
        
        /// Password Text Field
        pwdTextField.placeholder = "Password"
        pwdTextField.isSecureTextEntry = true
        pwdTextField.layer.addSublayer(Styler.makeBottomLine())
        pwdTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pwdTextField)
        
        
        /// Sign Up Button
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        signUpButton.setTitleColor(.systemMint, for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        /// Error Label
        errorLabel.text = "Error"
        errorLabel.textAlignment = .center
        errorLabel.textColor = .systemRed
        errorLabel.alpha = 0
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorLabel)
        
        /// Stack View
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(firstnameTxtField)
        stackView.addArrangedSubview(lastnameTxtField)
        stackView.addArrangedSubview(emailTxtField)
        stackView.addArrangedSubview(pwdTextField)
        stackView.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(errorLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
    }
    
    private func addBottomLayer(_ textfield:UITextField) {
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.systemMint.cgColor
        
        textfield.borderStyle = .none
        
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            firstnameTxtField.heightAnchor.constraint(equalToConstant: 40),
            lastnameTxtField.heightAnchor.constraint(equalToConstant: 40),
            emailTxtField.heightAnchor.constraint(equalToConstant: 40),
            pwdTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
