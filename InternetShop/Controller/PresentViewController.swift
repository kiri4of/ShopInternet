//
//  PresentViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 11.07.2022.
//

import UIKit
import Firebase

class PresentViewController: UIViewController {
    
    var menuItem: Menu?
    
   weak var delegate: presentVCDelegate? //всегда weak чтобы не было цикла сильных ссылок (Тг MiamiBeach есть такой вопрос)
    
    let buttonAdd: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("В корзину", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
     let imageView: UIImageView = {
       let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.backgroundColor = .clear
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
     let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .light)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
   
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .light)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(didTapMinusButton), for: .touchUpInside)
        
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
       
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView =  UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var image = UIImage()
    var ref: DatabaseReference!
    var user: User!
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else {return}
        user = currentUser
        ref = Database.database(url: "https://internetshop-8e932-default-rtdb.firebaseio.com").reference(withPath: "users").child(user.uid).child("cart")
        
        viewConfigurate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ref.observe(.value) { snapshot in
            
            for item in snapshot.children {
                let _menuItem = Menu(snapshot: item as! DataSnapshot)
                if _menuItem.name == self.menuItem?.name {
                    self.count = _menuItem.count ?? 1
                    self.countLabel.text = String(describing: self.count)
                    if self.count == 1 {
                        self.minusButton.isUserInteractionEnabled = false
                        self.minusButton.backgroundColor = .lightGray
                    }
                }
            }
            self.setPriceForMenu()
        }
    }
    
 //  public var completion: ((Menu?) -> Void)?
    
    func viewConfigurate(){
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(buttonAdd)
        self.view.addSubview(priceLabel)
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(plusButton)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(minusButton)
        //substitute the data
        guard let imageURL = menuItem?.imageURL else {return}
        guard let labelName = menuItem?.name  else {return}
        imageView.image = image
        nameLabel.text = labelName
        //constraints
        configurateConstraints()
    }
    
    func configurateConstraints(){
    
        NSLayoutConstraint.activate([
        //imageView
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 250),
        //nameLabel
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            //button
            buttonAdd.widthAnchor.constraint(equalToConstant: 150),
            buttonAdd.heightAnchor.constraint(equalToConstant: 50),
            buttonAdd.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            //priceLabel
            priceLabel.bottomAnchor.constraint(equalTo: buttonAdd.topAnchor, constant: -50),
            priceLabel.centerXAnchor.constraint(equalTo: buttonAdd.centerXAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 150),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            //stackView
            stackView.centerXAnchor.constraint(equalTo: priceLabel.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            //stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -105),
            stackView.heightAnchor.constraint(equalToConstant: 33)
        
        ])
    }
    
    func observeAndUpdateCount() {
        ref.observe(.value) { snapshot in
            
            for item in snapshot.children {
                let _menuItem = Menu(snapshot: item as! DataSnapshot)
                if _menuItem.name == self.menuItem?.name {
                    _menuItem.ref?.updateChildValues(["count": self.count])
                }
            }
        }
    }
    
    func setPriceForMenu(){
        var price = 0.00
        
        if menuItem?.name == "Burger" {
            price = 34.75
        } else if menuItem?.name == "Cola" {
            price = 24.75
        }
        else if menuItem?.name == "Salat" {
            price = 22.75
        }
        if stackView.isHidden {
            priceLabel.text = "\(price) czk"
        } else {
            priceLabel.text = "\(price * Double(count)) czk"
        }
        
    }
    
    @objc func didTapPlusButton(){
        minusButton.isUserInteractionEnabled = true
        minusButton.backgroundColor = .systemRed
        count += 1
        countLabel.text = String(describing: count)
        observeAndUpdateCount()
    }
    
    @objc func didTapMinusButton(){
       
        if count > 1 {
            count -= 1
            countLabel.text = String(describing: count)
            observeAndUpdateCount()
            if count == 1 {
                minusButton.isUserInteractionEnabled = false
                minusButton.backgroundColor = .lightGray
            }
        }
    }
    
    @objc func didTapAddButton(){
        guard let menuItem = menuItem else {return}
        let _menuItem = Menu(name: menuItem.name, imageURL: menuItem.imageURL, userId: user.uid, count: count)
        
        let menuRef = ref.child((menuItem.name.lowercased()))
        menuRef.setValue(_menuItem.convertToDictionary()) { error, reference in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        observeAndUpdateCount()
        //delegate?.sendData(menu: _menuItem) //пробрасываем назад по нажатию | (от куда пробрасываем)
        count += 1
        dismiss(animated: true)
    }
}

