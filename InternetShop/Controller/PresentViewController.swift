//
//  PresentViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 11.07.2022.
//

import UIKit

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
       // label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(buttonAdd)
        self.view.addSubview(priceLabel)
        //substitute the data
        guard let imageURL = menuItem?.imageURL else {return}
        guard let labelName = menuItem?.name  else {return}
      //imageView.image = UIImage(named: imageName) // тут данные с апишки
       // getFetch(imageView: imageView, menuItem: menuItem)
        imageView.image = image
        nameLabel.text = labelName
        //
        setPriceForMenu()
        //constraints
        configurateConstraints()
    }
    
 //  public var completion: ((Menu?) -> Void)?
    
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
            priceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
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
        priceLabel.text = "\(price) czk"
    }
    
    @objc func didTapAddButton(){
        guard let menuItem = menuItem else {return}
        
        delegate?.sendData(menu: menuItem) //пробрасываем назад по нажатию | (от куда пробрасываем)
        dismiss(animated: true)
    }
    deinit {
        print("свободен Презент")
    }
}

