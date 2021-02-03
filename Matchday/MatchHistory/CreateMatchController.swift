//
//  CreateMatchController.swift
//  Matchday
//
//  Created by Lachy Pound on 20/10/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CreateMatchController: UIViewController {

    var someVar: String?
    var delegate: MatchHistoryViewDelegate?
    
    @IBOutlet weak var homeTeamTextField: UITextField!
    @IBOutlet weak var awayTeamTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateSelector: UIDatePicker!
    @IBAction func nextButton(_ sender: UIButton) {
        print("Button tapped")
        // run checks for valid text in fields
        // save all the content and send it to the MatchHistoryView
        let status = matchStatus.notStarted.rawValue
        let homeTeam = homeTeamTextField.text ?? "Home"
        let awayTeam = awayTeamTextField.text ?? "Away"
        let location = locationTextField.text ?? "MCG"
        let date = dateSelector.date
        
//        createMatch(status: status, homeTeam: homeTeam, awayTeam: awayTeam, location: location, date: date)
        createMockMatch()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextFields()
//        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = view.provideSecondaryBackgroundColour()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .blue
        self.hideKeyboardWhenTappedAround()
    }
    
    func setUpTextFields() {
        print("setting up tfs")
        homeTeamTextField.keyboardType = .default
        awayTeamTextField.keyboardType = .default
//        .
    }
    
    func createMockMatch() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let match = NSEntityDescription.insertNewObject(forEntityName: "Match", into: context) as! Match
        match.status = "Complete"
        match.homeTeam = "AFC"
        match.awayTeam = "BFC"
        match.location = "someGround"
        match.date = Date()
        
        let matchHistory = NSEntityDescription.insertNewObject(forEntityName: "MatchHistory", into: context) as! MatchHistory
        
        //Define scores
        let homeScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        homeScore.teamName = "AFC"
        homeScore.teamType = groundAdvantage.home.rawValue
        homeScore.goalTally = 4
        homeScore.pointTally = 4
                
        let awayScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        awayScore.teamName = "BFC"
        awayScore.teamType = groundAdvantage.away.rawValue
        awayScore.goalTally = 4
        awayScore.pointTally = 3
        
        let scoreSet = NSSet(objects: homeScore, awayScore)
        matchHistory.totalScore = scoreSet
        
        //Quarter 1
        let quarter1 = NSEntityDescription.insertNewObject(forEntityName: "Quarter", into: context) as! Quarter
        quarter1.number = 1
        
        //new score
        let newHomeScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        newHomeScore.teamName = "AFC"
        newHomeScore.teamType = groundAdvantage.home.rawValue
        newHomeScore.goalTally = 1
        newHomeScore.pointTally = 1
        
        let newAwayScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        newAwayScore.teamName = "BFC"
        newAwayScore.teamType = groundAdvantage.away.rawValue
        newAwayScore.goalTally = 1
        newAwayScore.pointTally = 1
        
        let newStat1 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newStat1.teamValue = 1
        newStat1.opponentValue = 0
        newStat1.statisticName = "Clearances"
        
        let newStat2 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newStat2.teamValue = 1
        newStat2.opponentValue = 0
        newStat2.statisticName = "Inside 50s"
        
        let newStatSet = NSSet(objects: newStat1, newStat2)
        quarter1.statistics = newStatSet
        let newScoreSet = NSSet(objects: newHomeScore, newAwayScore)
        
        quarter1.score = newScoreSet
        quarter1.matchHistory = matchHistory
        quarter1.startTime = Date(timeIntervalSinceNow: -9600)
        quarter1.finishTime = Date(timeIntervalSinceNow: -7800)
        
        //Quarter 2
        let quarter2 = NSEntityDescription.insertNewObject(forEntityName: "Quarter", into: context) as! Quarter
        quarter2.number = 2
        
        //new score
        let newHomeScore2 = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        newHomeScore2.teamName = "AFC"
        newHomeScore2.teamType = groundAdvantage.home.rawValue
        newHomeScore2.goalTally = 2
        newHomeScore2.pointTally = 2
        
        let newAwayScore2 = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        newAwayScore2.teamName = "BFC"
        newAwayScore2.teamType = groundAdvantage.away.rawValue
        newAwayScore2.goalTally = 2
        newAwayScore2.pointTally = 2
        
        let newScoreSet2 = NSSet(objects: newHomeScore2, newAwayScore2)
        
        let newStat3 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newStat3.teamValue = 2
        newStat3.opponentValue = 3
        newStat3.statisticName = "Clearances"
        
        let newStat4 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newStat4.teamValue = 2
        newStat4.opponentValue = 3
        newStat4.statisticName = "Inside 50s"
        
        let newStatSet2 = NSSet(objects: newStat3, newStat4)
        quarter2.statistics = newStatSet2
        
        quarter2.score = newScoreSet2
        quarter2.matchHistory = matchHistory
        quarter2.startTime = Date(timeIntervalSinceNow: -7200)
        quarter2.finishTime = Date(timeIntervalSinceNow: -5400)
        
        //Quarter 3
        let quarter3 = NSEntityDescription.insertNewObject(forEntityName: "Quarter", into: context) as! Quarter
        quarter3.number = 3
        
        //new score
        let newHomeScore3 = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        newHomeScore3.teamName = "AFC"
        newHomeScore3.teamType = groundAdvantage.home.rawValue
        newHomeScore3.goalTally = 3
        newHomeScore3.pointTally = 3
        
        let newAwayScore3 = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        newAwayScore3.teamName = "BFC"
        newAwayScore3.teamType = groundAdvantage.away.rawValue
        newAwayScore3.goalTally = 3
        newAwayScore3.pointTally = 3
        
        let newScoreSet3 = NSSet(objects: newHomeScore3, newAwayScore3)
        
        let newStat5 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newStat5.teamValue = 3
        newStat5.opponentValue = 2
        newStat5.statisticName = "Clearances"
        
        let newStat6 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newStat6.teamValue = 3
        newStat6.opponentValue = 4
        newStat6.statisticName = "Inside 50s"
        
        let newStatSet3 = NSSet(objects: newStat5, newStat6)
        quarter3.statistics = newStatSet3
        
        quarter3.score = newScoreSet3
        quarter3.matchHistory = matchHistory
        quarter3.startTime = Date(timeIntervalSinceNow: -4200)
        quarter3.finishTime = Date(timeIntervalSinceNow: -2400)
        
        //Quarter 4
        let quarter4 = NSEntityDescription.insertNewObject(forEntityName: "Quarter", into: context) as! Quarter
        quarter4.number = 4
        
        //new score
        let newHomeScore4 = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        newHomeScore4.teamName = "AFC"
        newHomeScore4.teamType = groundAdvantage.home.rawValue
        newHomeScore4.goalTally = 4
        newHomeScore4.pointTally = 4
        
        let newAwayScore4 = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        newAwayScore4.teamName = "BFC"
        newAwayScore4.teamType = groundAdvantage.away.rawValue
        newAwayScore4.goalTally = 4
        newAwayScore4.pointTally = 3
        
        let newScoreSet4 = NSSet(objects: newHomeScore4, newAwayScore4)
        
        let newStat7 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newStat7.teamValue = 2
        newStat7.opponentValue = 3
        newStat7.statisticName = "Clearances"
        
        let newStat8 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
        newStat8.teamValue = 5
        newStat8.opponentValue = 3
        newStat8.statisticName = "Inside 50s"
        
        let newStatSet4 = NSSet(objects: newStat7, newStat8)
        quarter4.statistics = newStatSet4
        
        quarter4.score = newScoreSet4
        quarter4.matchHistory = matchHistory
        quarter4.startTime = Date(timeIntervalSinceNow: -1800)
        quarter4.finishTime = Date()
        
        matchHistory.startTime = quarter1.startTime
        matchHistory.finishTime = quarter4.finishTime
        match.history = matchHistory
        
        do {
            try context.save()
            DispatchQueue.main.async {
                self.delegate?.didAddNewMatch(match: match)
            }
            self.navigationController?.popViewController(animated: true)
        } catch let err {
            print("Failed to create new match with error: ", err)
        }
    }
    
    func createMatch(status: String, homeTeam: String, awayTeam: String, location: String, date: Date) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let match = NSEntityDescription.insertNewObject(forEntityName: "Match", into: context) as! Match
        match.status = status
        match.homeTeam = homeTeam
        match.awayTeam = awayTeam
        match.location = location
        match.date = date
        
        let matchHistory = NSEntityDescription.insertNewObject(forEntityName: "MatchHistory", into: context) as! MatchHistory
        
        //Define scores
        let homeScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        homeScore.teamName = "AFC"
        homeScore.teamType = groundAdvantage.home.rawValue
        homeScore.goalTally = 0
        homeScore.pointTally = 0
                
        let awayScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        awayScore.teamName = "BFC"
        awayScore.teamType = groundAdvantage.away.rawValue
        awayScore.goalTally = 0
        awayScore.pointTally = 0
        
        let scoreSet = NSSet(objects: homeScore, awayScore)
        matchHistory.totalScore = scoreSet
        
        //Define quarter array
        for n in 0...3 {
            print(n)
            let quarter = NSEntityDescription.insertNewObject(forEntityName: "Quarter", into: context) as! Quarter
            quarter.number = Int16(n)
            
            //new score
            let newHomeScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
            newHomeScore.teamName = "GEFC"
            newHomeScore.teamType = groundAdvantage.home.rawValue
            newHomeScore.goalTally = 2
            newHomeScore.pointTally = 10
                    
            let newAwayScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
            newAwayScore.teamName = "RFC"
            newAwayScore.teamType = groundAdvantage.away.rawValue
            newAwayScore.goalTally = 1
            newAwayScore.pointTally = 20
            
            let newScoreSet = NSSet(objects: newHomeScore, newAwayScore)
            
            quarter.score = newScoreSet
            quarter.matchHistory = matchHistory
            quarter.startTime = Date(timeIntervalSinceNow: -61)
            quarter.finishTime = Date()
        }
        
        matchHistory.startTime = date
        match.history = matchHistory
        
        do {
            try context.save()
            DispatchQueue.main.async {
                self.delegate?.didAddNewMatch(match: match)
            }            
            self.navigationController?.popViewController(animated: true)
        } catch let err {
            print("Failed to create new match with error: ", err)
        }
    }
}

extension CreateMatchController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        return awayTeamTextField
//    }
}
