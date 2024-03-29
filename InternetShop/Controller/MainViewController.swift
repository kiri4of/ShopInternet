//
//  MainViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 05.07.2022.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.alpha = 0
        collection.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        return collection
    }()
    
    var menuArray: [Menu] = {
        var menu1 = Menu(name: "Burger", imageURL: "https://nevafood.ru/wp-content/uploads/2017/07/burger-ayam.jpg")
        var menu2 = Menu(name: "Cola", imageURL: "https://s7d1.scene7.com/is/image/mcdonalds/mcdonalds-coca-cola:1-3-product-tile-desktop?wid=829&hei=515&dpr=off")
        var menu3 = Menu(name: "Salat", imageURL: "https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/b9c592ed-652c-4b80-8322-babfc3ecc16f/Derivates/3439ac00-e108-4963-b264-d78cab455293.jpg")
        return [menu1,menu2,menu3]
    }()
    
    var menuImagesArray = [UIImage]()
    var flag = true
    var garbageArray = [Menu]()  //куда будем получать данные обратно
    var itemsMenu = [MenuCollectionViewCell]()
    var animation = Animation()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        configurateAllImages()  //Тут задержка дабы загрузились картинки
        configurateAnimation()
        letsAnimate()
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(didTapCartButton))
        //CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        collectionView.frame = view.bounds
        makeSignOutButton()
    }

    func configurateAllImages(){
        getFetchDataFromURLs(URLs: menuArray) { result in
            switch result {
            case .success(let dataArr):
                    for data in dataArr {
                        print(Thread.current)
                        guard let image = UIImage(data: data) else {return}
                        self.menuImagesArray.append(image)
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                //sleep(1)
                self.stopAnimation(loading: false)
                self.collectionView.reloadData()
            }
            
        }
        
//        getFetchData(urlString: menuArray[0].imageURL!) { result in
//            switch result {
//            case .success(let data):
//                guard let image = UIImage(data: data) else {return}
//                self.menuImagesArray.append(image)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            DispatchQueue.main.async {
//                self.stopAnimation(loading: false)
//                self.collectionView.reloadData()
//            }
//        }
    }
    
    //MARK: - Functions
    
    func makeSignOutButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(didTapSignOut))
        
    }
    
    func letsAnimate() {
        animation.startAnimateCirlcles()
    }
    
    func stopAnimation(loading: Bool) {
        self.animation.loading = loading
            UIView.animate(withDuration: 0.4, delay: 0.3) {
                self.collectionView.alpha = 1
            }
    }
    
    func configurateAnimation() {
        animation.setCenterAnimationVC(view: self.view)
        self.view.addSubview(animation.animationViewContainer)
        for view in animation.circles {
            animation.animationViewContainer.addSubview(view)
        }
        animation.setUpCircles()
    }
    
    
    
    @objc func didTapCartButton(){
        let vcCart = CartTableViewController() //заново создаее с новыми элементами (ссылочный тип,сколько бы не было указывают на один объект)
        vcCart.delegate = self
        vcCart.menuArray = garbageArray
        self.navigationController?.pushViewController(vcCart, animated: true)
    }
    
    @objc func didTapSignOut(){
        do{
           try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true)
    }
    
}

extension MainViewController: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell
        else { return UICollectionViewCell()}
        //itemCell.loadingDelegate = self
        itemCell.configurate(menuArray[indexPath.row],image: menuImagesArray[indexPath.row])
        return itemCell
    }
    
    //Трайнуть notify у групп в GCD (Глобальная группа в которую добавляют и по ее окончанию ебануть false)
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuImagesArray.count
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath)! as! MenuCollectionViewCell
        let vc = PresentViewController()
        vc.delegate = self //без weak получается цикл сильных ссылок
        vc.menuItem = menuArray[indexPath.row] //section для collectionView
        vc.image = cell.imageView.image!
        vc.stackView.isHidden = true
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
        print("Menu - \(menu.name) - \(menu.imageURL)")
        garbageArray.append(menu)
    }
}

extension MainViewController: UpdateProtocol {
    func updateMenu(menuArray: [Menu]) {
        garbageArray = menuArray
    }
}




//оплата кнопка отмена +
//анимация покупки(просто загрузка по кругу) -+ хз куда влепить
//signOut +
//допилить анимацию с помощью dispathGroup +
//Добавить FirebaseDB к корзине +
//Решить проблему с повторением (мб добавив количество которое будет увеличиваться с каждым разом при нажатии на кнопку добавления, думай крч бля ГЕНИЙ ПОКОЛЕНИЯ, да да Я!!!)

