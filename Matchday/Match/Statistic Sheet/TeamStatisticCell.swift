//
//  TeamStatisticCell.swift
//  Matchday
//
//  Created by Lachy Pound on 2/6/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

class TeamStatisticCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate {
    
    var statistic: TeamStatistic?{
        didSet{
            statisticNameLabel.text = statistic?.statisticName
            statisticNameLabel.delegate = self
            if let tStat = statistic?.teamValue {
                teamStatistic = Int(tStat)
            }
            if let oStat = statistic?.opponentValue {
                opponentStatistic = Int(oStat)
            }
        }
    }
    var teamSheetDelegate: TeamSheetControllerDelegate?
    @IBOutlet weak var teamStatLabel: UILabel!
    @IBOutlet weak var opponentStatLabel: UILabel!
    @IBOutlet weak var statisticNameLabel: UITextField!
    //    @IBOutlet weak var statisticNameLabel: UILabel!
    var statisticNumber: Int?
    var teamStatistic: Int = 0 {
        didSet{
            teamStatLabel.text = String(teamStatistic)
        }
    }
    var opponentStatistic: Int = 0 {
        didSet{
            opponentStatLabel.text = String(opponentStatistic)
        }
    }
    
    @IBAction func teamStatDown(_ sender: UIButton) {
        if teamStatistic > 0 {
            teamStatistic -= 1
            teamSheetDelegate?.updateStatistic(name: "teamValue", value: teamStatistic, cell: statisticNumber!)
        }
    }
    @IBAction func teamStatUp(_ sender: UIButton) {
        teamStatistic += 1
        teamSheetDelegate?.updateStatistic(name: "teamValue", value: teamStatistic, cell: statisticNumber!)
        
    }
    
    @IBAction func opponentStatDown(_ sender: UIButton) {
        if opponentStatistic > 0 {
            opponentStatistic -= 1
            teamSheetDelegate?.updateStatistic(name: "opponentValue", value: opponentStatistic, cell: statisticNumber!)
        }
    }
    
    @IBAction func opponentStatUp(_ sender: UIButton) {
        opponentStatistic += 1
        teamSheetDelegate?.updateStatistic(name: "opponentValue", value: opponentStatistic, cell: statisticNumber!)
    }
    
    //MARK: Text field delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // save the name of the stat to coreData
        let data = textField.text
        statistic?.statisticName = data
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        do {
            try context.save()
            print("Updated statistic name.")
        } catch let saveErr {
            print("Failed to save with error: \(saveErr)")
        }
    }
}
