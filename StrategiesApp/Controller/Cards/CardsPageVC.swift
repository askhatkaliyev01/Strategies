//
//  CardsPageVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class CardsPageVC: UIPageViewController {

    private(set) lazy var orderedViewControllers: [CardVC] = {
        return self.getCards()
    }()
    
    private func getCards() -> [CardVC] {
        var res:[CardVC] = []
        for i in 1 ... 33 {
            let curV = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardVC") as! CardVC
            curV.cardIndex = i-1
            res.append(curV)
        }
        return res
    }
    
    var currentIndex:Int = 0
    var isLight:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        view.backgroundColor = .white
        
        do {
            let firstViewController = orderedViewControllers[currentIndex]
            firstViewController.darkShown = !isLight
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}

extension CardsPageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! CardVC) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! CardVC) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
        
    }
}

