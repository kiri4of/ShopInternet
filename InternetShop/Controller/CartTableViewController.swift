//
//  CartTableViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 11.07.2022.
//

import UIKit

class CartTableViewController: UITableViewController {

    var priceValue = ""
    
    var menuArray = [Menu]()
    
    var amountPrice = 0.0
    
  //  var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        //print("\(menuArray[0].name) - \(menuArray.count) - \(menuArray[0].imageName)")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "applelogo"), style: .done, target: self, action: #selector(didTapAppleLogo))
        
    }
    
    //MARK: - Fucntions
    @objc func didTapAppleLogo(){
        let myImage = UIImage(systemName: "applelogo")
        var stringImage = myImage?.toPngString()
        stringImage = (stringImage ?? "Apple") + "Pay"
        
        let alert = UIAlertController(title: "\(amountPrice)czk to be paid", message: "Choose payment method", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Pay", style: .default))
        alert.addAction(UIAlertAction(title: "Google Pay", style: .default))
        present(alert, animated: true)
    }
 
    //BUG FIX
    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else { return UITableViewCell()}
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
