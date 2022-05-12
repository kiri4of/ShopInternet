//
//  PageViewController.swift
//  InternetShop
//
//  Created by Kiri4of on 08.05.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    var previousIndex = 0
    let nextButton = UIButton()
    let skipButton = UIButton()
    let customPageControl = UIPageControl()
    let initialPage = 0
    //animaton
    var nextButtonBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var customPageControlBottomAnchor: NSLayoutConstraint?
    
    //MARK: - crete VC
    //Добавляем в массив все Странички (массив всех страничек)
    //    lazy var pages: [PreviewViewController] = {
    //        var pagesVC = [PreviewViewController]()
    //        for page in pages {
    //            pagesVC.append(PreviewViewController(pageWith: page))
    //        }
    //        return pagesVC
    //    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        navigationItem.title = "Shop"
        setup()
        style()
        layout()
    }
    
    func setup(){
        guard let firstImage = UIImage(named: "natural") else{return}
        guard let secondImage = UIImage(named: "food") else{return}
        guard let lastImage = UIImage(named: "packet") else{return}
        
        let firstPage = PreviewViewController(pageWith: PageHelper(name: " Добро пожаловать в интернет магазин  100%nature", image: firstImage))
        let secondPage = PreviewViewController(pageWith: PageHelper(name: "Здесь можно преобрести разную еду, на ваш выбор!", image: secondImage))
        let lastPage = PreviewViewController(pageWith: PageHelper(name: "Все просто, добавил в корзину, оплатил, получил!", image: lastImage))
        let loginVC = ViewController()
        
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(lastPage)
        pages.append(loginVC)
        //Устанавливаем контрллер который первым увидят
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        customPageControl.addTarget(self, action: #selector(didTapPageControl), for: .valueChanged)
    }
    //MARK: - Configurate Functions
    func style(){
        //customPageControl
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        customPageControl.pageIndicatorTintColor = .systemGray3
        customPageControl.currentPageIndicatorTintColor = UIColor(red: 66/255, green: 112/255, blue: 57/255, alpha: 1.0)
        customPageControl.currentPage = initialPage
        customPageControl.numberOfPages = pages.count
        
        //next
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = UIColor(red: 66/255, green: 100/255, blue: 57/255, alpha: 1.0)
        nextButton.layer.cornerRadius = 15
        nextButton.addTarget(self, action: #selector(goNextPage), for: .touchUpInside)
        //skip
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitleColor(.black, for: .normal)
        skipButton.setTitle("skip", for: .normal)
        skipButton.addTarget(self, action: #selector(goSkipPage), for: .touchUpInside)
    }
    
    func layout(){
        view.addSubview(customPageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        //page
        NSLayoutConstraint.activate([
            customPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           // customPageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            customPageControl.heightAnchor.constraint(equalToConstant: 50),
            customPageControl.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        //next
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           // nextButton.bottomAnchor.constraint(equalTo: customPageControl.topAnchor,constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 250)
        ])
        //skip
        NSLayoutConstraint.activate([
            skipButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
           // skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            skipButton.heightAnchor.constraint(equalToConstant: 20),
            skipButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        customPageControlBottomAnchor = customPageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5)
        nextButtonBottomAnchor = nextButton.bottomAnchor.constraint(equalTo: customPageControl.topAnchor,constant: -30)
        
        customPageControlBottomAnchor?.isActive = true
        skipButtonTopAnchor?.isActive = true
        nextButtonBottomAnchor?.isActive = true
        
    }
    
    func isPrelastPage(){
        //next button change text on the last page
        let preLastPage = customPageControl.currentPage == pages.count - 2
        let lastPage = customPageControl.currentPage == pages.count - 1
        
        animateIfNeeded()
        if preLastPage || lastPage {
            nextButton.setTitle("Let's Go!", for: .normal)
        }
        else {
            nextButton.setTitle("Next", for: .normal)
        }
        previousIndex = customPageControl.currentPage //currentPage меняется сразу по нажитию на любую кнопку передвижения, а здесь мы сохраняем предыдущюю страничку
    }
    
        func animateIfNeeded(){
            let lastPage = customPageControl.currentPage == pages.count - 1
    
            if lastPage{
              hideControls()
            }
            else {
                showControls()
            }
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    
        private func showControls(){
            customPageControlBottomAnchor?.constant = -5
            nextButtonBottomAnchor?.constant = -30
            skipButtonTopAnchor?.constant = 5
        }
    
        private func hideControls(){
            customPageControlBottomAnchor?.constant = 80
            nextButtonBottomAnchor?.constant = 80
            skipButtonTopAnchor?.constant = -80
        }
    
    //MARK: - @objc | pageControl Funcs to move
    @objc func goNextPage(){
        let currentIndex = customPageControl.currentPage
        let vc = pages[currentIndex]
        if currentIndex < pages.count  {
            guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: vc) else {return}
            setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
        }
        customPageControl.currentPage += 1
        isPrelastPage()
        
    }
    
    @objc func goSkipPage(){
        guard let vc = pages.last else {return}
        setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        customPageControl.currentPage = pages.count - 1
        isPrelastPage()
    }
    
    @objc func didTapPageControl(){
        
        let currentIndex = customPageControl.currentPage
        if previousIndex > currentIndex {
            setViewControllers([pages[currentIndex]], direction: .reverse, animated: true, completion: nil)
        }
        else {
            setViewControllers([pages[currentIndex]], direction: .forward, animated: true, completion: nil)
        }
        isPrelastPage()
    }
}


extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    //MARK: - DataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController){ //индекс берется от положения vc в массиве pages (vc этот тот viewController на котором мы щас находимся)
            if index > 0 {
                return  pages[index - 1] // -1 Тк назад идем
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController) {
            if index < pages.count-1 {
                return pages[index+1] // +1 Тк идем вперед
            }
        }
        return nil
    }
    
    //MARK: - Delegate (точечки скока и как)
    //Синхра customPageControl с Контролерами (когда свайпешь! мб еще когда-то, но не точно)
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers  else {return}
        guard let currentIndex = pages.firstIndex(of: viewControllers[0])  else {return} //viewController[0] - текущий контролер (и кастим его к нашему типу Тк они должны быть индентичны)
        customPageControl.currentPage = currentIndex
        isPrelastPage()
    }
    
}

