//
//  CartTableViewCell.swift
//  InternetShop
//
//  Created by Kiri4of on 11.07.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    static let identifier = "CartTableViewCell"
    
    var price = 0.00
    
     let productImageView: UIImageView = {
       let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.backgroundColor = .clear
        imageV.clipsToBounds
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
       // label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.textAlignment = .left
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
    
    func configurate(_ menu: Menu){
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        guard let imageURL = menu.imageURL else {return}
        guard let labelName = menu.name else {return}
        //productImageView.image = UIImage(named: imageName)
       //getFetch(imageView: productImageView, menuItem: menu)
        getFetchData(urlString: imageURL) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.productImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print("error")
            }
        }
        nameLabel.text = labelName
        setPriceForMenu(menuItem: menu)
        configurateConstraints()
    }
    
    func setPriceForMenu(menuItem: Menu){
        if menuItem.name == "Burger" {
            price = 34.75
        } else if menuItem.name == "Cola" {
            price = 24.75
        } else if menuItem.name == "Salat" {
            price = 22.75
        }
        
        priceLabel.text = "\(price) czk"
    }

    
    func configurateConstraints(){
        NSLayoutConstraint.activate([
        //imageView
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
        //nameLabel
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
        //priceLabel
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            priceLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
//top и bottom вместо height констрейнта
