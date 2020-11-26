//
//  SaveSheetController.swift
//  Matchday
//
//  Created by Lachy Pound on 20/9/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

protocol TeamSheetControllerDelegate {
    func handleCancel()
    func handleAddNewStatistic()
    func updateStatistic(name: String, value: Int, cell: Int)
}

class TeamStatisticSheetController: UIViewController, TeamSheetControllerDelegate, UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate {
    
    let statCellId = "statCellId"
    let newStatCellID = "newStatCellID"
    let cellHeader = "cellHeader"
    var record: Record? {
        didSet {
            
            navigationItem.title = record?.title
            
            guard let statisticsArray = record?.teamRecord?.teamStatistics?.allObjects as? [TeamStatistic] else {return}
            statArray = statisticsArray
        }
    }
    
    let rowHeight = CGFloat(60)
    
    var statArray = [TeamStatistic]()
    
    let statisticTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: Set up methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavElements()
    }
    
    private func setUpNavElements() {
        if #available(iOS 13.0, *){
            statisticTableView.backgroundColor = .secondarySystemBackground
            view.backgroundColor = .secondarySystemBackground
        } else {
            statisticTableView.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
            view.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        }
        statisticTableView.dataSource = self
        statisticTableView.delegate = self
        statisticTableView.tableFooterView = UIView()
        self.hideKeyboardWhenTappedAround()
        
        let statisticCellNib = UINib(nibName: "TeamStatisticCell", bundle: nil)
        statisticTableView.register(statisticCellNib, forCellReuseIdentifier: statCellId)
        statisticTableView.register(AddNewStatisticCell.self, forCellReuseIdentifier: newStatCellID)
        statisticTableView.register(TeamStatSheetHeader.self, forHeaderFooterViewReuseIdentifier: cellHeader)
        
        setUpMenuElements()
        view.addSubview(statisticTableView)
        
        NSLayoutConstraint.activate([
            
            statisticTableView.topAnchor.constraint(equalTo: view.topAnchor),
            statisticTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statisticTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statisticTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    func setUpMenuElements(){
        let sendStatSheetDataButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sendTeamData))
        navigationItem.rightBarButtonItems = [sendStatSheetDataButton]
    }
    
    @objc func sendTeamData(){
        print("Readying to send team data")
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        guard let dateOfMatch = record?.created else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let formattedDateString = dateFormatter.string(from: dateOfMatch)
        
        if let record = record {

            let homeTeam = record.teamRecord?.teamLabel ?? "<home team>"
            let opponentTeam = record.teamRecord?.opponentLabel ?? "<opponent>"
            
            composeVC.body = "Match stats for \(homeTeam) vs \(opponentTeam), created on \(formattedDateString)\n\n\(homeTeam)"
            
            // append all the stats to the text document.
            for statistic in statArray {
                //find the name and the value
                let statName = statistic.statisticName ?? "Statistic"
                let statValue = statistic.teamValue
                let statisticEntryText = "\n\(statName): \(statValue)"
                composeVC.body?.append(statisticEntryText)
            }
            
            composeVC.body?.append("\n\n\(opponentTeam)")
            
            for statistic in statArray {
                //find the name and the value
                let statName = statistic.statisticName ?? "Statistic"
                let statValue = statistic.opponentValue
                let statisticEntryText = "\n\(statName): \(statValue)"
                composeVC.body?.append(statisticEntryText)
            }
        }
        
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Could not compose a message view, likely due to 'sharing permissions' on the device.")
            let alert = UIAlertController(title: "Unable To Share", message: "This device does not allow sharing.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == statArray.count {
            //  else display the AddNewStatCell
            let cell = statisticTableView.dequeueReusableCell(withIdentifier: newStatCellID, for: indexPath) as! AddNewStatisticCell
            cell.delegate = self
            cell.addNewStatButton.addTarget(self, action: #selector(handleAddNewStatistic), for: .touchUpInside)
            cell.contentView.isUserInteractionEnabled = false
            if #available(iOS 13.0, *) {
                cell.backgroundColor = .secondarySystemBackground
            } else {
                cell.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
            }
            return cell
        } else {
            // display a statistic cell
            let cell = statisticTableView.dequeueReusableCell(withIdentifier: statCellId, for: indexPath) as! TeamStatisticCell
            cell.statisticNameLabel.text = statArray[indexPath.row].statisticName
            cell.teamSheetDelegate = self
            cell.statisticNumber = indexPath.row
            cell.statistic = statArray[indexPath.row]
            if #available(iOS 13.0, *) {
                cell.backgroundColor = .systemBackground
            } else {
                cell.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        return true
        if indexPath.row == statArray.count {
            return
        } else {
            let statistic = statArray[indexPath.row]
            statArray.remove(at: indexPath.row)
            statisticTableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
            context.delete(statistic)
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to save with error: \(saveErr)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = statisticTableView.dequeueReusableHeaderFooterView(withIdentifier: cellHeader) as! TeamStatSheetHeader
        view.record = record
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    //MARK: Delegate methods
    func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleAddNewStatistic() {
        print("Adding new statistic")
        // create new stat element
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let newTeamStatistic = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newTeamStatistic.statisticName = "Statistic"
        newTeamStatistic.opponentValue = 0
        newTeamStatistic.teamValue = 0
        
        newTeamStatistic.teamRecord = record?.teamRecord
        
        // perform the save
        do {
            try context.save()
            statArray.append(newTeamStatistic)
            let insertionIndexPath = IndexPath(row: statArray.count - 1, section: 0)
            statisticTableView.insertRows(at: [insertionIndexPath], with: .automatic)
        } catch let error {
            print("Unable to create Team Statistic with Error: ", error)
        }
    }
    
    func updateStatistic(name: String, value: Int, cell: Int){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        switch name {
        case "opponentValue":
            statArray[cell].opponentValue = Int16(value)
            print("Updated opponent stat to:", value)
        case "teamValue":
            statArray[cell].teamValue = Int16(value)
            print("Updated team stat to:", value)
        default:
            print("updating neither value. Switch case entered default.")
        }
        
        do {
            try context.save()
            print("Saving...")
        } catch let error {
            print("Failed to update Statistic \(name) with error:", error)
        }
    }
}
//MARK: TeamStatSheet Header
class TeamStatSheetHeader: UITableViewHeaderFooterView {
    
    var record: Record? {
        didSet {
            guard let date = record?.created else {return}
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM, dd, yyyy"
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
            
            homeTeamLabel.text = record?.teamRecord?.teamLabel
            opponentTeamLabel.text = record?.teamRecord?.opponentLabel
        }
    }
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some date"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        if #available(iOS 13.0, *) {
            label.textColor = .tertiaryLabel
        } else {
            label.textColor = .lightGray
        }
        label.textColor = .lightText
        return label
    }()
    
    let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some home team"
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textAlignment = .left
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.textColor = .white
        return label
    }()
    
    let opponentTeamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some opponent"
        label.textAlignment = .right
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.textColor = .white
        return label
    }()
    
    let homeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My team"
        label.font = UIFont.systemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            label.textColor = .tertiaryLabel
        } else {
            label.textColor = .black
        }
        label.textColor = .lightText
        return label
    }()
    
    let opponentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Opponent"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            label.textColor = .tertiaryLabel
        } else {
            label.textColor = .black
        }
        label.textColor = .lightText
        return label
    }()
    
    let versusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "v"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .black
        }
        label.textColor = .lightText
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            view.backgroundColor = .separator
        } else {
            view.backgroundColor = .black
        }
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    private func configureContents(){
        print("configuring contents")
        contentView.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(opponentTeamLabel)
        contentView.addSubview(homeLabel)
        contentView.addSubview(opponentLabel)
        contentView.addSubview(versusLabel)
        contentView.addSubview(separator)
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
        
        homeTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
        homeTeamLabel.bottomAnchor.constraint(equalTo: homeLabel.topAnchor),
        homeTeamLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3, constant: 0),
        
        opponentTeamLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        opponentTeamLabel.bottomAnchor.constraint(equalTo: opponentLabel.topAnchor),
        opponentTeamLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3, constant: 0),
        
        homeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
        homeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        homeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3, constant: 0),
        
        opponentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        opponentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        opponentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3, constant: 0),
        
        versusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        versusLabel.bottomAnchor.constraint(equalTo: homeLabel.topAnchor),
        
        separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        separator.heightAnchor.constraint(equalToConstant: 1),
        separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        dateLabel.bottomAnchor.constraint(equalTo: separator.topAnchor),
        dateLabel.centerXAnchor.constraint(equalTo: versusLabel.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
