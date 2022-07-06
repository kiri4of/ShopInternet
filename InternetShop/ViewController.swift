//
//  ViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 20.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //For Animations
    lazy var animationViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.center.x = self.view.center.x
        view.center.y = self.view.center.y * 0.75
        return view
    }()
    var cirle1: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return view
    }()
    var cirle2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 100-40, y: 0, width: 40, height: 40)
        return view
    }()
    var cirle3: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 100-40, y: 100-40, width: 40, height: 40)
        return view
    }()
    var cirle4: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 100-40, width: 40, height: 40)
        return view
    }()
    
    lazy var circles = [cirle1,cirle2,cirle3,cirle4]
    var cirleIndex = 0
    var randomIndex = 0
    
    var colors: [UIColor] = [#colorLiteral(red: 0.32390064, green: 0.4138930738, blue: 0.9091263413, alpha: 0.5), #colorLiteral(red: 0.8235835433, green: 0.5749723315, blue: 0, alpha: 0.5), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.5), #colorLiteral(red: 0.09879464656, green: 0.3816201091, blue: 0.2502036691, alpha: 0.5), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 0.5), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5), #colorLiteral(red: 1, green: 0.2204911709, blue: 0.2471658289, alpha: 0.5), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0.5), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0.5), #colorLiteral(red: 1, green: 0.71805197, blue: 1, alpha: 0.5)]
    
    var loading = false
    //
    let welcomelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        label.backgroundColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
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
        button.imageView?.tintColor = .white
        button.backgroundColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
        return button
    }()
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
        return imageView
    }()
    var viewsArray: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        viewsArray = [welcomelabel,loginTextField,passTextField,loginLabel,passLabel,enterButton,userImageView]
        
        self.view.backgroundColor = .white
        //animation
        self.view.addSubview(animationViewContainer)
        for view in circles {
            self.animationViewContainer.addSubview(view)
        }
        setUpCircles()
        //
        for view in viewsArray {
            self.view.addSubview(view)
        }
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
            enterButton.widthAnchor.constraint(equalToConstant: 350),
            enterButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    //MARK: -For Animation Funcs
    func setUpCircles(){
        randomIndex = Int.random(in: 0...colors.count - 1)
        animationViewContainer.isUserInteractionEnabled = false
        
        for circle in circles {
            circle.layer.cornerRadius = circle.frame.height / 2
            circle.backgroundColor = .clear
            circle.isUserInteractionEnabled = false
        }
//        circles.forEach { cirlce in
//            cirlce.layer.cornerRadius = cirlce.frame.height/2
//            cirlce.backgroundColor = .clear
//            cirlce.isUserInteractionEnabled = false
//        }
    }
    
    func nextCircle(){
        randomIndex = Int.random(in: 0...colors.count - 1)
        if cirleIndex == circles.count - 1 {
            cirleIndex = 0
        }
        else {
            cirleIndex += 1
        }
    }
    
    func loadingView(){
        var flag = false //для проверки на то остались еще вью на экране
        
        for view in viewsArray {
            if self.view.contains(view){
                flag = true
                break
            }
        }
        
        if !flag {  //будет фолс но делаем тру чтобы сработало
            self.startAnimateCirlcles()
        } else {
            print("Вью не удалилась")
        }
    }
    func startAnimateCirlcles(){
        circles[cirleIndex].backgroundColor = colors[randomIndex].withAlphaComponent(0)
         UIView.animate(withDuration: 0.4) {
            self.circles[self.cirleIndex].backgroundColor = self.colors[self.randomIndex].withAlphaComponent(0.8)
        } completion: { success in
            self.circles[self.cirleIndex].backgroundColor = self.colors[self.randomIndex].withAlphaComponent(0)
            
            self.nextCircle()
          
            if self.loading == true {
                self.startAnimateCirlcles()
            }
            
        }
        
    }
    //MARK: - Objc func
    @objc func didTapEnterButton(){
        loading = true

        UIView.animate(withDuration: 1, delay: 0.3, options: .curveLinear) {
            for view in self.viewsArray {
                view.alpha = 0
            }
        } completion: { flag in
            if flag {
                for view in self.viewsArray {
                    view.removeFromSuperview()
                }
                self.loadingView()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                    self.loading = false
                    let vc = MainViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.modalPresentationStyle = .fullScreen
                    self.present(navVC, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        for view in self.viewsArray {
                            self.view.addSubview(view)
                            view.alpha = 1
                        }
                        self.configurateConstraints()
                        
                    }
                   
                }
            }
            
            
        }
        
    }
}
extension UITextField {
    func addImageToTextField(_ img: UIImage){
        let view = UIView(frame: CGRect(x:0, y:0, width: img.size.width + 5, height: img.size.height))
        let imageView = UIImageView(frame: CGRect(x:0, y:-1, width: img.size.width, height: img.size.height))
        imageView.image = img
        imageView.tintColor = .darkGray
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always
    }
}
