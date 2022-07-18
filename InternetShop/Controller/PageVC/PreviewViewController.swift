//
//  PreviewViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 08.05.2022.
//

import UIKit

class PreviewViewController: UIViewController {

    private let infoImage: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subView: [UIView] = [self.infoImage,self.textLabel]
    
    //MARK: - init
    init(pageWith: PageHelper) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        infoImage.image = pageWith.image
        textLabel.text = pageWith.name
        
        for view in subView { self.view.addSubview(view) } //Просто добавляем на главную view
        
        configurateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configurateConstraints() {
        //Image
        NSLayoutConstraint.activate([
            infoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            infoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoImage.widthAnchor.constraint(equalToConstant:300),
            infoImage.heightAnchor.constraint(equalToConstant: 310)
        ])
        //Label
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: infoImage.bottomAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.widthAnchor.constraint(equalToConstant:300),
            textLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
