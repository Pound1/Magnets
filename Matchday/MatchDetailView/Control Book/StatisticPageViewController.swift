//
//  StatisticPageViewController.swift
//  Matchday
//
//  Created by Lachy Pound on 22/12/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

class StatisticPageViewController: UIViewController {
    
    var statisticArray = [TeamStatistic]()
    let statistic = [["Statistic Name", "Statistic 1"], ["Home Name", "AFC"], ["Home value", "4"], ["Away Name", "NFC"], ["Away value", "6"]]
    let statsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(imageLiteralResourceName: "statsIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.PaletteColour.Green.newGreen
        return imageView
    }()
    let controllerPageTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Statistics"
        title.textColor = UIColor.PaletteColour.Green.newGreen
        title.font = UIFont.boldSystemFont(ofSize: 22)
        return title
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
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
        fetchStatSheets()
        view.addSubview(statsImage)
        view.addSubview(controllerPageTitle)
        view.addSubview(tableView)
        
//        view.addSubview(controllerPageTitle)
    }
    
    //MARK:- fetch service
    
    private func fetchStatSheets(){
        let context = CoreDataManager.shared.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<TeamStatistic>(entityName: "TeamStatistic")
        do {
            let stats = try context.fetch(fetchRequest)
    
            self.statisticArray = stats
//            self.statisticArray.sort{$0.created!.compare($1.created!) == .orderedDescending}
            self.tableView.reloadData()
            
        } catch let fetchError {
            print("Failed to fetch Stat List: \(fetchError)")
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            statsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statsImage.widthAnchor.constraint(equalToConstant: 30),
            statsImage.heightAnchor.constraint(equalToConstant: 25),
            statsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//
            controllerPageTitle.leadingAnchor.constraint(equalTo: statsImage.trailingAnchor, constant: 20),
            controllerPageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            controllerPageTitle.centerYAnchor.constraint(equalTo: statsImage.centerYAnchor),
            controllerPageTitle.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: statsImage.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}

extension StatisticPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count of Stats: ", statistic.count)
        return statisticArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StatisticTableViewCell(style: .default, reuseIdentifier: "cellID")
        cell.statistic = statisticArray[indexPath.row]
        return cell
    }
}

extension StatisticPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = StatisticHeaderViewCell()
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
