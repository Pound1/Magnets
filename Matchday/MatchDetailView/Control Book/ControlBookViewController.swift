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
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 3
        control.translatesAutoresizingMaskIntoConstraints = false
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = .black
        return control
    }()
    let viewC = StatisticPageViewController()
    let viewC2 = ScorePageVC()
    let viewC3 = TimerPageVC()

    //MARK: Private Methods
    private func setUpView() {
        view.backgroundColor = UIColor.PaletteColour.Green.newGreen
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
//        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Rounds both top corners
        view.layer.maskedCorners = [.layerMinXMinYCorner] // Rounds left top corner
        dataSource = self
        delegate = self
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        addConstraints()
    }
    private func addConstraints() {
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
//            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
//            pageControl.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [viewC, viewC3, viewC2]
    }()
    private func newColoredViewController(color: String) -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = UIColor(named: color)
        return view
    }
    private func updatePageControl(index: Int) {
        print("Navigating to page: ", index)
        pageControl.currentPage = index
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

extension ControlBookViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let locationIndex = orderedViewControllers.firstIndex(of: pendingViewControllers[0]) {
            updatePageControl(index: locationIndex)
        }
    }
}
