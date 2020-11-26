//
//  MatchCollectionViewControllerTimerExtension.swift
//  Matchday
//
//  Created by Lachy Pound on 29/1/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

extension MatchCollectionViewController {
    //MARK:- Match timer methods
        
        func handleStartMatchTimer () {
            print("Starting timer...")
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(IncrementTimer), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
            // fill the fieldLedger with players on the field
            print("Beginning field ledger")
            timerEnabled = true
            manageButton.isEnabled = false
            initialiseFieldLedger()
        }
        
        private  func initialiseFieldLedger () {
            let currentTime = Date()
            var playerPosition = String()
            
    //        for each player in the allPlayers array, push each into the fieldledger with a beginning time
            playingField.forEach { (playerArray) in
                let positionalArray = playerArray
                
                guard let indexSection = playingField.firstIndex(of: positionalArray) else {return}
                
                playerArray.forEach({ (element) in
                    let player = element
                    // find the player in the allPlayersInMatch array and return the index
                    guard let indexRow = playerArray.firstIndex(of: player) else {return}
                    let index = IndexPath(row: indexRow, section: indexSection)
                    playerPosition = getFieldPositionLabelForRotation(index: index)
                    
                    let rotationData = RotationData(player: player, position: playerPosition, timeStartedOnField: currentTime, timeIntervalSinceStartingOnField: 0)
                    fieldLedger.append(rotationData)
                })
            }
        }
        
        func handlePauseMatchTimer() {
            timer.invalidate()
            timerEnabled = false
            manageButton.isEnabled = true
        }

        func checkIfUserWantedToResetTimer() {
            let alert = UIAlertController(title: "Reset Timer", message: "This will reset the timer. Final player positions will be made available to share in rotation history. Do you want to continue?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { (_) in
//                WHY: how to use 'weak self' to avoid strong reference cycles
                self.restoreMatchTimerView()
            }))
            //            alert.addAction(UIAlertAction(title: "Reset And Send Rotation Data", style: .default, handler: { (tappedReset) in
            //                self.restoreMatchTimerView()
//                            self.handleSendRotationData()
            //            }))
            self.present(alert, animated: true)
    }
    
    func restoreMatchTimerView() {
        if self.matchTimerView.timeStarted == true {
            self.matchTimerView.handlePauseButton()
        }
        self.matchTimerView.timeStarted = false
        self.matchTimerView.timerLabel.text = "0:00:00.0"
        self.matchTimerView.playButton.setImage(UIImage(named: "playIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.timer = Timer()
        self.gameClockTime = 0.0
        self.completeRotationLedger()
        self.matchTimerView.refreshTimerButton.isEnabled = false
    }
        
        @objc func IncrementTimer () {
            gameClockTime += 0.1
            
            let flooredCounter = Int(floor(gameClockTime))
            let hour = flooredCounter / 3600
            let minute = (flooredCounter % 3600) / 60
            var minuteString = "\(minute)"
            if minute < 10{
                minuteString = "0\(minute)"
            }
            let second = (flooredCounter % 3600) % 60
            var secondString = "\(second)"
            if second < 10 {
                secondString = "0\(second)"
            }
            let decisecond = String(format: "%.1f", gameClockTime).components(separatedBy: ".").last!
            matchTimerView.timerLabel.text = "\(hour):\(minuteString):\(secondString).\(decisecond)"
        }
}
