//
//  TimerPageVC.swift
//  Matchday
//
//  Created by Lachy Pound on 22/12/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class TimerPageVC: UIViewController {
    
    let dataArray = [["Start", "14:02"],["End", "14:34"],["Total (min)", "32"]]
    let dataArray2 = [["GEAFC", "7.4 (48)"],["NFC", "4.6 (30)"]]
    let clockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(imageLiteralResourceName: "goal_posts").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.PaletteColour.Green.newGreen
        return imageView
    }()
    let controllerPageTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Elements"
        title.textColor = UIColor.PaletteColour.Green.newGreen
        title.font = UIFont.boldSystemFont(ofSize: 22)
        return title
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    private func setUpView() {
        view.backgroundColor = view.provideBackgroundColour()
//        view.addSubview(clockImage)
        view.addSubview(tableView)
//        view.addSubview(controllerPageTitle)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
//            clockImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            clockImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            clockImage.widthAnchor.constraint(equalToConstant: 36),
//            clockImage.heightAnchor.constraint(equalToConstant: 40),
//            clockImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//
//            controllerPageTitle.leadingAnchor.constraint(equalTo: clockImage.trailingAnchor, constant: 20),
//            controllerPageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            controllerPageTitle.centerYAnchor.constraint(equalTo: clockImage.centerYAnchor),
//            controllerPageTitle.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}

extension TimerPageVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Header 1"
        } else {
            return "Header 2"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataArray.count
        } else {
            return dataArray2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        if indexPath.section == 0 {
            cell.detailTextLabel?.text = dataArray[indexPath.row][1]
            cell.textLabel?.text = dataArray[indexPath.row][0]
        } else {
            cell.detailTextLabel?.text = dataArray2[indexPath.row][1]
            cell.textLabel?.text = dataArray2[indexPath.row][0]
        }
        return cell
    }
}

extension TimerPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ControlBookHeaderView()
        if section == 0 {
            headerView.image.image = UIImage(imageLiteralResourceName: "Timer_2").withRenderingMode(.alwaysTemplate)
        } else {
            headerView.image.image = UIImage(imageLiteralResourceName: "goal_posts").withRenderingMode(.alwaysTemplate)
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
