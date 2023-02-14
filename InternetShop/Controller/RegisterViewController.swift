//
//  RegisterViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 07.02.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
   private let registerLabelHelper: UIView = {
      let view = UIView()
       view.layer.shadowOffset = CGSize(width: 0, height: 5)
       view.layer.shadowOpacity = 0.2
       view.layer.shadowRadius = 5
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()
   
    private let registerLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
       label.backgroundColor = UIColor(red: 0/255, green: 102/255, blue: 102/255, alpha: 1.0)
       label.textColor = .white
       label.text = "Registration"
       label.textAlignment = .center
       label.clipsToBounds = true
       label.translatesAutoresizingMaskIntoConstraints = false
       label.layer.cornerRadius = 20
       return label
   }()
    
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter email..."
        field.backgroundColor = .systemGray6
        field.keyboardType = .emailAddress
        field.autocorrectionType = .no
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 0.1
        field.layer.borderColor = UIColor.black.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addImageToTextField(UIImage(systemName: "person")!)
        return field
    }()
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter password..."
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 0.1
        field.layer.borderColor = UIColor.black.cgColor
        field.isSecureTextEntry = false
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addImageToTextField(UIImage(systemName:"lock")!)
        return field
    }()
    private let repeatPasswordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter password..."
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 0.1
        field.layer.borderColor = UIColor.black.cgColor
        field.isSecureTextEntry = false
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addImageToTextField(UIImage(systemName:"lock")!)
        return field
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "key"), for: .normal)
        button.setImage(UIImage(systemName: "key.fill"), for: .highlighted)
        button.imageView?.tintColor = .white
        button.backgroundColor = UIColor(red: 0/255, green: 102/255, blue: 102/255, alpha: 1.0)
        //layer
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 20
//        button.layer.borderWidth = 0.5
//        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.alpha = 0
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewsArray = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view = UIScrollView(frame: self.view.bounds)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        let viewsArray = [stackView,registerLabel,registerLabelHelper,enterButton,errorLabel]
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(repeatPasswordTextField)
        for view in viewsArray {
            self.view.addSubview(view)
        }
        view.backgroundColor = .white
        configurateConstraints()
        keyboardSettings()
    }
    
    func keyboardSettings(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func configurateConstraints(){
        
        NSLayoutConstraint.activate([
            registerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerLabel.widthAnchor.constraint(equalToConstant: 350),
            registerLabel.heightAnchor.constraint(equalToConstant: 70),
            
            registerLabelHelper.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            registerLabelHelper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerLabelHelper.widthAnchor.constraint(equalToConstant: 350),
            registerLabelHelper.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        //StackView
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        //TextFields
        NSLayoutConstraint.activate([
            //email
            emailTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            emailTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            //password
            passwordTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            passwordTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            //repeatPassword
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        //EnterButton
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 70),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.widthAnchor.constraint(equalToConstant: 350),
            enterButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        //ErrorLabel
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 20),
            errorLabel.centerXAnchor.constraint(equalTo: registerLabel.centerXAnchor),
        ])
    }
    
    private func displayErrorIfNeeded(_ text: String){
        errorLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut]) {
            self.errorLabel.alpha = 1
        } completion: { _ in
            self.errorLabel.alpha = 0
        }

    }
    
    @objc func didShowKeyboard(notification: Notification) {
//        guard let userInfo = notification.userInfo else {return}
//
//        let keyBoardFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//
//        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.height + keyBoardFrameSize.height)
//
//        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardFrameSize.height, right: 0)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height - 150
                }
            }
        
    }
    
    @objc func didHideKeyboard() {
//        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.height)
        if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func didTapEnterButton(){
        
        guard let email = emailTextField.text, passwordTextField.text == repeatPasswordTextField.text, let password = repeatPasswordTextField.text, email != "", password != "" else {
            self.displayErrorIfNeeded("Fields are empty!")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                self.displayErrorIfNeeded("Error occured!")
                return
            }
            
            if result != nil {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.displayErrorIfNeeded("User is not created!")
            }
            
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
