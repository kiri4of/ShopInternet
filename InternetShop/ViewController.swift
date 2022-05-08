//
//  ViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 20.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let welcomelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        label.text = "Welcome"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let SignIn: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        label.backgroundColor = .red
        label.textColor = .white
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 0.8
        label.layer.borderColor = UIColor.black.cgColor
        label.text = "Welcome"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let loginTextField: UITextField = {
       let field = UITextField()
        field.placeholder = "Enter login..."
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 0.1
        field.layer.borderColor = UIColor.black.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addImageToTextField(UIImage(systemName: "person")!)
        return field
    }()
    let passTextField: UITextField = {
       let field = UITextField()
        field.placeholder = "Enter password..."
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 0.1
        field.layer.borderColor = UIColor.black.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addImageToTextField(UIImage(systemName:"lock")!)
        return field
    }()
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let passLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let enterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "key"), for: .normal)
        button.setImage(UIImage(systemName: "key.fill"), for: .highlighted)
        button.imageView?.tintColor = UIColor(red: 35/255, green: 34/255, blue: 51/255, alpha: 1.0)
        button.backgroundColor = UIColor(red: 138/255, green: 130/255, blue: 180/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemPink
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        self.view.backgroundColor = .white
        self.view.addSubview(welcomelabel)
        self.view.addSubview(loginTextField)
        self.view.addSubview(passTextField)
        self.view.addSubview(loginLabel)
        self.view.addSubview(passLabel)
        self.view.addSubview(enterButton)
        self.view.addSubview(userImageView)
        configurateConstraints()
    }

    func configurateConstraints(){
        //WelcomeLabel
        NSLayoutConstraint.activate([
            welcomelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomelabel.widthAnchor.constraint(equalToConstant: 350),
            welcomelabel.heightAnchor.constraint(equalToConstant: 70)
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
            enterButton.widthAnchor.constraint(equalToConstant: 270),
            enterButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
extension UITextField {
    func addImageToTextField(_ img: UIImage){
        let view = UIView(frame: CGRect(x:0, y:0, width: img.size.width + 5, height: img.size.height))
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width: img.size.width, height: img.size.height))
        imageView.image = img
        imageView.tintColor = .systemPink
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always
    }
}
