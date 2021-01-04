//
//  ControlBookViewController.swift
//  Matchday
//
//  Created by Lachy Pound on 21/12/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class ControlBookViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = .blue
        dataSource = self
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    let viewC = view1()
    let viewC2 = view2()
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [viewC, viewC2]
    }()

    private func newColoredViewController(color: String) -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = UIColor(named: color)
        return view
    }
}

extension ControlBookViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
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
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
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

class view1: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}

class view2: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .green
    }
}
