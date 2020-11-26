//
//  StatisticSheet.swift
//  Matchday
//
//  Created by Lachy Pound on 12/9/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

protocol StatisticSheetControllerDelegate {
    func updateRecord(statistic: Statistic)
}

class StatisticSheetController: UITableViewController, StatisticSheetControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    let cellID = "cellID"
    var record: Record? {
        didSet{
            
            navigationItem.title = record?.title
            
            if let statSheet = record?.individualRecord?.statSheet {
                scores[0].value = Int(statSheet.goals)
                scores[1].value = Int(statSheet.behinds)
                statistics[2].value = Int(statSheet.handballs)
                statistics[1].value = Int(statSheet.marks)
                statistics[0].value = Int(statSheet.kicks)
                statistics[3].value = Int(statSheet.tackles)

                tableView.reloadData()
            }
        }
    }
    
    var dateCreated = String()
    
    var statistics = [
        Statistic(label: "Kicks", value: 0),
        Statistic(label: "Marks", value: 0),
        Statistic(label: "Handballs", value: 0),
        Statistic(label: "Tackles", value: 0),
    ]
    
    var scores = [
        Statistic(label: "Goals", value: 0),
        Statistic(label: "Behinds", value: 0)
    ]
    
    var allStats = [[Statistic]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tableView.register(StatisticCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allStats[0].count
        } else {
            return allStats[1].count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allStats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! StatisticCell
        
        if indexPath.section == 0 {
            cell.statistic = statistics[indexPath.row]
            cell.delegate = self
            return cell
        } else {
            cell.statistic = scores[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    
    func setUpView(){
        if #available(iOS 13.0, *){
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        }
        tableView.allowsSelection = false
        let sendStatSheetDataButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(displayMessageInterface))
        navigationItem.rightBarButtonItems = [sendStatSheetDataButton]
        allStats = [statistics, scores]
    }
    
    //MARK:- Navigation button methods
    
    @objc func handleSend(){
        print("Pressed Send")
        let fileName = "StatisticData"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)!
        
        // define a 'comma separated value' variable
//        var csvText = "Player Name,Position,Time Started,Time in Position (mins)\n"
        
        // then iterate through the Stat sheet, adding values to each BELOW IS COPIED CODE
//        for listEntry in rotationLedger {
//            let txt = "\(String(describing:listEntry.player.name)),\(listEntry.position),\(listEntry.timeStartedOnField),\(String(describing: listEntry.timeIntervalSinceStartingOnField/60))\n"
//            csvText.append(txt)
//            print("Text entry will look like this: \(String(describing:listEntry.player.name)),\(listEntry.position),\(listEntry.timeStartedOnField),\(String(describing: listEntry.timeIntervalSinceStartingOnField))")
//        }
        
        // attempt to save the file
//        do {
//            try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8) // ACTIVATE THIS WHEN READY TO USE REAL DEVICES
//            print("Rotation data: ", csvText)
//        } catch {
//            print("Failed to create file with error:  ", error)
//        }
        
        let shareActivityView = UIActivityViewController(activityItems: [path], applicationActivities: [])
        shareActivityView.excludedActivityTypes = [ //below are examples of uiactivities to exclude
            //            UIActivityTypeAssignToContact,
            //            UIActivityTypeSaveToCameraRoll,
            //            UIActivityTypePostToTwitter,
            //            UIActivityTypePostToFacebook,
        ]
        present(shareActivityView, animated: true, completion: nil)
        
        // THE BELOW IS TO CREATE A SEND VIEW, WITH ANIMATION AND NICE UX
//        let sendSheetController = SaveSheetController()
//        sendSheetController.record = record
//        present(sendSheetController, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        let title = record?.type ?? "No title found"
        guard let dateOfMatch = record?.created else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let formattedDateString = dateFormatter.string(from: dateOfMatch)
//        composeVC.recipients = ["1233123"]
        if let record = record {
//            var statText =
            composeVC.body = "Match stats for \(title), created on \(formattedDateString)\nKicks: \(record.individualRecord?.statSheet?.kicks ?? 0)\nMarks: \(record.individualRecord?.statSheet?.marks ?? 0)\nHandballs: \(record.individualRecord?.statSheet?.handballs ?? 0)\nTackles: \(record.individualRecord?.statSheet?.tackles ?? 0)\nGoals: \(record.individualRecord?.statSheet?.goals ?? 0)\nBehinds: \(record.individualRecord?.statSheet?.behinds ?? 0)"
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
    
    func updateRecord(statistic: Statistic){
        print("Updating Record with statistic: ", statistic)
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        guard let record = record else {return}
        let statisticLabel = statistic.label
        switch statisticLabel {
        case "Kicks":
            record.individualRecord?.statSheet?.kicks = Int16(statistic.value)
        case "Marks":
            record.individualRecord?.statSheet?.marks = Int16(statistic.value)
        case "Handballs":
            record.individualRecord?.statSheet?.handballs = Int16(statistic.value)
        case "Tackles":
            record.individualRecord?.statSheet?.tackles = Int16(statistic.value)
        case "Goals":
            record.individualRecord?.statSheet?.goals = Int16(statistic.value)
        case "Behinds":
            record.individualRecord?.statSheet?.behinds = Int16(statistic.value)
        default:
            print("Nothing to update for ", statisticLabel)
        }
        
        do {
            try context.save()
            print("Successfully updated record.")
        } catch let saveError{
            print("Failed to save the Statistic Sheet: \(saveError)")
        }
    }
}

struct Statistic {
    var label: String
    var value: Int
}
