//
//  TimerPageVC.swift
//  Matchday
//
//  Created by Lachy Pound on 22/12/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class TimerPageVC: UIViewController {
    
    let clockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(imageLiteralResourceName: "Timer_2").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.PaletteColour.Green.newGreen
        return imageView
    }()
    let controllerPageTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Timer"
        title.textColor = UIColor.PaletteColour.Green.newGreen
        title.font = UIFont.boldSystemFont(ofSize: 22)
        return title
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .red
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = view.provideBackgroundColour()
        view.addSubview(clockImage)
        view.addSubview(tableView)
        view.addSubview(controllerPageTitle)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
//            clockImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clockImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clockImage.widthAnchor.constraint(equalToConstant: 36),
            clockImage.heightAnchor.constraint(equalToConstant: 40),
            clockImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            controllerPageTitle.leadingAnchor.constraint(equalTo: clockImage.trailingAnchor, constant: 20),
            controllerPageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            controllerPageTitle.centerYAnchor.constraint(equalTo: clockImage.centerYAnchor),
            controllerPageTitle.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: clockImage.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}
