//
//  MainViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 05.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        return collection
    }()
    
    var menuArray: [Menu] = {
        var menu1 = Menu(name: "Burger", imageName: "burger")
        var menu2 = Menu(name: "Cola", imageName: "cola")
        var menu3 = Menu(name: "Salat", imageName: "salat")
        return [menu1,menu2,menu3]
    }()
    
    var garbageArray = [Menu]()  //куда будем получать данные обратно
   // var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(didTapCartButton))
        //CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
  
    @objc func didTapCartButton(){
//        let vc = PresentViewController()
//        vc.completion = { [weak self] menu in
//            DispatchQueue.main.async { //когда работаешь с UI частью (по типу label)
//                guard let newMenu = menu else {return}
//                //self?.menuArray.append(newMenu)
////                self?.vcCart.menuArray.append(newMenu)
//                self?.vcCart.menuItem = newMenu
//            }
//        }
//        observer = NotificationCenter.default.addObserver(forName: Notification.Name("takeMenu"), object: nil, queue: .main, using: { notification in
//            guard let object = notification.object as? Menu else {return}
//            self.vcCart.menuItem = object
//        })
        let vcCart = CartTableViewController() //заново создаее с новыми элементами (ссылочный тип,сколько бы не было указывают на один объект)
        vcCart.menuArray = garbageArray
        self.navigationController?.pushViewController(vcCart, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell
        else { return UICollectionViewCell()}
        itemCell.configurate(menuArray[indexPath.row])
        return itemCell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PresentViewController()
        vc.delegate = self //без weak получается цикл сильных ссылок
        vc.menuItem = menuArray[indexPath.row] //section для collectionView
       present(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80 * 2, height: 100 * 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
    }
}


//Можно паснуть менюЭрей в ПрезентКонтролер и потом эту хуйню (количество выходит) паснуть в Тейбл Вью
//Модель юзать

extension MainViewController: presentVCDelegate {
    // здесь принимаем данные | (куда пробрасываем)
    func sendData(menu: Menu) {
        print("Menu - \(menu.name) - \(menu.imageName)")
        garbageArray.append(menu)
    }
   
}
