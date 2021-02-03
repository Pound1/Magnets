//
//  MatchHistoryView.swift
//  Matchday
//
//  Created by Lachy Pound on 19/10/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

protocol MatchHistoryViewDelegate {
    func didAddNewMatch(match: Match)
}

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
//        view.backgroundColor = UIColor.PaletteColour.Green.primaryDarkColor
        segmentedControl.backgroundColor = UIColor.PaletteColour.Green.primaryDarkColor
        segmentedControl.tintColor = .black
//        createMockData()
        fetchMatches()
        navigationItem.title = "Matches"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CreateNewMatch))
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        } else {
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        self.tableView.separatorStyle = .singleLine
        self.tableView.estimatedRowHeight = 60 // these seem to do nothing
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
//        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0) // was for custom filter
        tableView.register(MatchHistoryCell.self, forCellReuseIdentifier: cellID)
        setUpTableViewElements()
    }
    
    func setUpTableViewElements() {
//        view.addSubview(segmentedControl)
//        view.addSubview(separator)
//        view.addSubview(newGameButton)
        NSLayoutConstraint.activate([

//            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -8),
//            segmentedControl.bottomAnchor.constraint(equalTo: tableView.topAnchor),
//            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
//            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
//
//            separator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            separator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            separator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -2),
//            separator.heightAnchor.constraint(equalToConstant: 2),
//
//            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            newGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
//            newGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
//            newGameButton.heightAnchor.constraint(equalToConstant: 44),
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
        cell.match = matches[indexPath.row]
        if matches[indexPath.row].status != matchStatus.complete.rawValue {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = FilterHeaderCell()
//        return headerView
//    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // create a page and display it on the nav stack
        let matchView = MatchDetailView()
        matchView.title = "\(matches[indexPath.row].homeTeam ?? "Home") vs \(matches[indexPath.row].awayTeam ?? "Away")"
        matchView.matchHistory = matches[indexPath.row].history
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let match = matches[indexPath.row]
        matches.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(match)
        do {
            try context.save()
        } catch let err {
            print("Failed to delete with error: \(err)")
        }
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

extension MatchHistoryView: MatchHistoryViewDelegate {
    func didAddNewMatch(match: Match) {
        print("Adding new match inside History view.")
        matches.append(match)
        
        // insert new index path
        let newIndexPath = IndexPath(row: matches.count-1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    //MARK: ObjC methods
    @objc func CreateNewMatch() {
        print("Creating new match")
        let storyboard = UIStoryboard(name: "CreateMatch", bundle: nil)
        guard let createMatchViewController = storyboard.instantiateViewController(withIdentifier: "CreateMatchVC") as? CreateMatchController else {return}
        createMatchViewController.delegate = self
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
            let sortedList = list.sorted(by: {$0.date! > $1.date!})
            self.matches = sortedList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
//            self.tableView.reloadData()
        } catch let fetchError {
            print("Failed to fetch Match list with error: \(fetchError)")
        }
    }
    
    private func createMockData() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let newMatch = NSEntityDescription.insertNewObject(forEntityName: "Match", into: context) as! Match
        newMatch.status = matchStatus.notStarted.rawValue
        newMatch.homeTeam = "GEFC"
        newMatch.awayTeam = "AFC"
        newMatch.location = "Packer Park"
        newMatch.date = Date()
        newMatch.result = "GEFC WON"
        print("Match Created: \(String(describing: newMatch.homeTeam)) v \(String(describing: newMatch.awayTeam))")
                    
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to create match with error: \(saveErr)")
        }
    }
}
