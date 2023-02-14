//
//  MenuCollectionViewCell.swift
//  InternetShop
//
//  Created by Kiri4of on 07.07.2022.
//

import UIKit

//var dispatchGroup = DispatchGroup()

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionViewCell"
    
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
       // label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loadingDelegate: LoadingProtocol?
    
    func configurate(_ menu: Menu, image: UIImage){
        guard let url = menu.imageURL else { return }
        guard let name = menu.name else { return }
        
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 0.05
        
        //imageView.image = UIImage(named: image) // тут
        //dispatchGroup.enter()
//        getFetchData(urlString: url) { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.imageView.image = UIImage(data: data)
//                }
//            case .failure(let error):
//                print("error")
//            }
//        }
        //dispatchGroup.leave()
        self.imageView.image = image
        nameLabel.text = name
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        configurateConstraints()
//        if index == menuCount-1 { //когда будет ласт картинка то анимация остановится
//          //  loadingDelegate?.update(loading: false)
//            completion(true)
//        } else {
//            completion(false)
//        }
    }
    
    func configurateConstraints(){
        NSLayoutConstraint.activate([
        //imageView
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.7),
        //nameLabel
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            
        ])
    }
    
}


