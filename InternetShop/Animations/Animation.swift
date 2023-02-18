//
//  Animation.swift
//  InternetShop
//
//  Created by Kiri4of on 09.12.2022.
//

import UIKit

class Animation {
    lazy var animationViewContainer: UIView = {
    let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        //  view.center.x = self.view.center.x
       // view.center.y = self.view.center.y * 0.75

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

//    func loadingView(viewsArray: [UIView]){
//        var flag = false //для проверки на то остались еще вью на экране
//        
//        for view in viewsArray {
//            if view.contains(view){
//                flag = true
//                break
//            }
//        }
//        
//        if !flag {  //будет фолс но делаем тру чтобы сработало
//            self.startAnimateCirlcles()
//        } else {
//            print("Вью не удалилась")
//        }
//    }
    
    func startAnimateCirlcles(){
        //смена кружочков
        //каждый раз комплишин проверяет loading, true = еще раз запуск анимки
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
    
    func setCenterAnimationVC(view: UIView) {
        animationViewContainer.center.x = view.center.x
        animationViewContainer.center.y = view.center.y * 0.75
    }

}

