//
//  CartTableViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 11.07.2022.
//

import UIKit
import Firebase

class CartTableViewController: UITableViewController {

    weak var delegate: UpdateProtocol?
    
    var priceValue = ""
    
    var menuArray = [Menu]()
    
    var amountPrice = 0.0
    
    var animatedCircle: AnimatedCircle! //на будущее если придумаю куда всунуть
    
    var ref: DatabaseReference!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "applelogo"), style: .done, target: self, action: #selector(didTapAppleLogo))
        
       guard let currentUser = Auth.auth().currentUser else {return}
        user = currentUser
        ref = Database.database(url: "https://internetshop-8e932-default-rtdb.firebaseio.com").reference(withPath: "users").child(user.uid).child("cart") //Тк у нас путь users/user/cart/...
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { snapshot in
            var _menuArray = [Menu]()
            for item in snapshot.children {
            let menuItem = Menu(snapshot: item as! DataSnapshot)
                _menuArray.append(menuItem)
            }
            self.menuArray = _menuArray
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Fucntions
    @objc func didTapAppleLogo(){
        let myImage = UIImage(systemName: "applelogo")
        var stringImage = myImage?.toPngString()
        stringImage = (stringImage ?? "Apple") + "Pay"
        let alert = UIAlertController(title: "\(amountPrice) czk to be paid", message: "Choose payment method", preferredStyle: .actionSheet)
        let appleAction = UIAlertAction(title: "Pay", style: .default)
        let googleAction = UIAlertAction(title: "Google Pay", style: .default)
        alert.addAction(appleAction)
        alert.addAction(googleAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
 
    //BUG FIX
    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else { return UITableViewCell()}
        cell.detailTextLabel?.text = "zxc"
        cell.configurate(menuArray[indexPath.row])
        amountPrice += cell.price
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let vc = PresentViewController()
        let cell = tableView.cellForRow(at: indexPath) as! CartTableViewCell
        vc.menuItem = menuArray[indexPath.row]
        vc.image = cell.productImageView.image!
        vc.buttonAdd.isHidden = true
        present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    deinit {
        print("свободен Тейбл")
    }
    
    //deleting rows
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let menuItem = menuArray[indexPath.row]
            menuItem.ref?.removeValue()
//            menuArray.remove(at: indexPath.row)
//            tableView.deleteRows(at:[indexPath], with: .automatic)
//           delegate?.updateMenu(menuArray: menuArray)
        }
    }
}
    
    

//didSet or observer
extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

