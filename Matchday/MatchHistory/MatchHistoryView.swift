//
//  MatchHistoryView.swift
//  Matchday
//
//  Created by Lachy Pound on 19/10/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

class MatchHistoryView: UITableViewController {
    
    //MARK: Properties
    let cellID = "cellID"
    var matches = [Match]()
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Recent", "Won", "Lost"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.backgroundColor = UIColor.PaletteColour.Green.primaryDarkColor
        control.layer.cornerRadius = 0.0
        control.layer.borderWidth = 10
        control.layer.borderColor = UIColor.PaletteColour.Green.primaryDarkColor.cgColor
        control.layer.masksToBounds = false
        control.tintColor = .clear
        control.setWidth(60, forSegmentAt: 1)
        control.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
//        control.addTarget(self, action: #selector(handleFilter), for: .valueChanged)
        return control
    }()
    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.PaletteColour.White.marble
        return view
    }()
    
    let newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("+   create new match", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor.PaletteColour.Red.primaryRed
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(CreateNewMatch), for: .touchUpInside)
        return button
    }()
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.backgroundColor = UIColor.PaletteColour.Green.primaryDarkColor
        segmentedControl.tintColor = .black
        fetchMatches()
        navigationItem.title = "Matches"
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        } else {
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        self.tableView.separatorStyle = .singleLine
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        tableView.register(MatchHistoryCell.self, forCellReuseIdentifier: cellID)
        setUpTableViewElements()
    }
    
    func setUpTableViewElements() {
        view.addSubview(segmentedControl)
        view.addSubview(separator)
        view.addSubview(newGameButton)
        NSLayoutConstraint.activate([

            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -8),
            segmentedControl.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            separator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            separator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -2),
            separator.heightAnchor.constraint(equalToConstant: 2),
            
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            newGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            newGameButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}

extension MatchHistoryView {
    //MARK: TableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MatchHistoryCell
//        cell.accessoryType = .disclosureIndicator // KEEP THIS FOR LATER
        cell.resultLabel.preferredMaxLayoutWidth = tableView.bounds.width
        if indexPath.row == 0 {
            cell.resultLabel.text = ""
        }
        return cell
    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = FilterHeaderCell()
//        return headerView
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("taped agraldkj \(indexPath.row)")
        // create a page and display it on the nav stack
        let matchView = MatchDetailView()
        matchView.title = "EFC vs OAFC"
        navigationController?.pushViewController(matchView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = FooterView()
        footer.footerTitle.text = "No matches available"
        footer.footerSubText.text = "Add matches by tapping the + button."
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return matches.isEmpty == true ? 150 : 0
    }
    
    //MARK: Custom methods for TableView
    func getBackgroundColour(rowNumber: Int) -> UIColor {
        if rowNumber % 2 == 0 {
            return UIColor.PaletteColour.Green.softGreen
        } else {
            return UIColor.PaletteColour.Red.primaryRed
        }
    }
}

extension MatchHistoryView {
    //MARK: ObjC methods
    @objc func CreateNewMatch() {
        print("Creating new match")
        let storyboard = UIStoryboard(name: "CreateMatch", bundle: nil)
        let createMatchViewController = storyboard.instantiateViewController(withIdentifier: "CreateMatchVC")
        navigationController?.pushViewController(createMatchViewController, animated: true)
    }
}


extension MatchHistoryView {
    //MARK: CoreData and Fetch methods
    private func fetchMatches(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Match>(entityName: "Match")
        do {
            let list = try context.fetch(fetchRequest)
            self.matches = list
            self.tableView.reloadData()
        } catch let fetchError {
            print("Failed to fetch Player List with error: \(fetchError)")
        }
    }
    
    private func createMockData() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let newMatch = NSEntityDescription.insertNewObject(forEntityName: "Match", into: context) as! Match
        newPlayer.name = self.surnameEntryField.text
        newPlayer.number = 99
        newPlayer.positionOnField = "Listed"
        newPlayer.number = number
        print("Player Created: \(String(describing: newPlayer.name)), number: \(number); position: \(String(describing: newPlayer.positionOnField))")
                    
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to create match with error: \(saveErr)")
        }
    }
}
