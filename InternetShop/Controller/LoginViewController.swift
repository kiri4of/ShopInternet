//
//  ViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 20.04.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    private let welcomeLabelHelper: UIView = {
       let view = UIView()
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let welcomelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        label.backgroundColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
        label.textColor = .white
        label.text = "Welcome"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 20
        
//        label.layer.borderWidth = 1.0
//        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    private let loginTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter login..."
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 0.1
        field.layer.borderColor = UIColor.black.cgColor
        field.keyboardType = .emailAddress
        field.autocorrectionType = .no
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addImageToTextField(UIImage(systemName: "person")!)
        return field
    }()
    private let passTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter password..."
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 0.1
        field.layer.borderColor = UIColor.black.cgColor
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addImageToTextField(UIImage(systemName:"lock")!)
        return field
    }()
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let passLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let enterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "key"), for: .normal)
        button.setImage(UIImage(systemName: "key.fill"), for: .highlighted)
        button.imageView?.tintColor = .white
        button.backgroundColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
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
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
        return imageView
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
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
       // button.backgroundColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var ref: DatabaseReference!
    
    private var viewsArray: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database(url: "https://internetshop-8e932-default-rtdb.firebaseio.com").reference(withPath: "users")
        self.title = "Welcome"
        loginTextField.delegate = self
        passTextField.delegate = self
        configurateViews()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.hideViewsAndGoNext()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.text = ""
        passTextField.text = ""
    }
    
    private func configurateViews() {
        welcomeLabelHelper.addSubview(welcomelabel)
        viewsArray = [welcomeLabelHelper,loginTextField,passTextField,loginLabel,passLabel,enterButton,userImageView,errorLabel,registerButton]
        self.view.backgroundColor = .white
        for view in viewsArray {
            self.view.addSubview(view)
        }
        configurateConstraints()
        keyboardSettings()
    }

    
    
    //MARK: - Functions
    private func configurateConstraints(){
        //WelcomeLabel
        NSLayoutConstraint.activate([
            welcomelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomelabel.widthAnchor.constraint(equalToConstant: 350),
            welcomelabel.heightAnchor.constraint(equalToConstant: 70),
            
            welcomeLabelHelper.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabelHelper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabelHelper.widthAnchor.constraint(equalToConstant: 350),
            welcomeLabelHelper.heightAnchor.constraint(equalToConstant: 70),
        ])
        //Login
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: welcomelabel.topAnchor, constant: 300),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalToConstant: 300),
            loginTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        //Pass
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: loginTextField.topAnchor, constant: 100),
            passTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTextField.widthAnchor.constraint(equalToConstant: 300),
            passTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        //LoginLabel
        NSLayoutConstraint.activate([
            loginLabel.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -5),
            loginLabel.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor, constant: 0),
            loginLabel.widthAnchor.constraint(equalToConstant: 300),
            loginLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        //PassLabel
        NSLayoutConstraint.activate([
            passLabel.bottomAnchor.constraint(equalTo: passTextField.topAnchor, constant: -5),
            passLabel.leadingAnchor.constraint(equalTo: passTextField.leadingAnchor, constant: 0),
            passLabel.widthAnchor.constraint(equalToConstant: 300),
            passLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        //UserImageView
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: welcomelabel.bottomAnchor, constant: 50),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 120),
            userImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        //EnterButton
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 70),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.widthAnchor.constraint(equalToConstant: 350),
            enterButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        //ErrorLabel
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: welcomelabel.bottomAnchor, constant: 20),
            errorLabel.centerXAnchor.constraint(equalTo: welcomelabel.centerXAnchor),
        ])
        //RegisterButton
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 50),
            registerButton.centerXAnchor.constraint(equalTo: enterButton.centerXAnchor),
        ])
    }
    
   private func keyboardSettings(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //На будущее чтобы вернуться к Логин Экрану и все вьюшки были готовы
    private func returnTheViews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            for view in self.viewsArray {
                self.view.addSubview(view)
                view.alpha = 1
            }
            self.configurateConstraints()
            
        }
    }
    
    private func displayErrorIfNeeded(_ text: String){
        errorLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut]) {
            self.errorLabel.alpha = 1
        } completion: { _ in
            self.errorLabel.alpha = 0
        }

    }
    
    private func hideViewsAndGoNext(){
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveLinear) {
            for view in self.viewsArray {
                view.alpha = 0
            }
        } completion: { flag in
            if flag {
                for view in self.viewsArray {
                    view.removeFromSuperview()
                }
                let vc = MainViewController()
                vc.animation.loading = true
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                UIView.animate(withDuration: 0.1, delay: 0) {
                    self.present(navVC, animated: false)
                }
            }
        }
        self.returnTheViews()
    }
    
    //MARK: - Objc func
    @objc func didTapEnterButton(){
        guard let email = loginTextField.text, let password = passTextField.text, email != "", password != "" else {
            displayErrorIfNeeded("Fields are empty!")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            guard error == nil else {
                self.displayErrorIfNeeded("Error occured!")
                return
            }
            
            if result != nil {
                self.hideViewsAndGoNext()
            } else {
                self.displayErrorIfNeeded("No such user!")
            }
            
        }

    }
    
    @objc func didTapRegisterButton(){
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
        //present(navVc, animated: true)
    }
    
    @objc func didShowKeyboard(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height - 150
                }
            }
    }
    
    @objc func didHideKeyboard() {
        if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
//MARK: - extensions
extension UITextField {
    func addImageToTextField(_ img: UIImage){
        let view = UIView(frame: CGRect(x:0, y:0, width: img.size.width + 5, height: img.size.height))
        let imageView = UIImageView(frame: CGRect(x:0, y:-1, width: img.size.width, height: img.size.height))
        imageView.image = img
        imageView.tintColor = .darkGray
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true    }
    
}


