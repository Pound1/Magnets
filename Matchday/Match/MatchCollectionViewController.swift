//
//  MatchCollectionViewController.swift
//  Matchday
//
//  Created by Lachy Pound on 13/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

protocol MatchCollectionViewControllerDelegate {
    func handleStartMatchTimer()
    func handlePauseMatchTimer()
    func checkIfUserWantedToResetTimer()
    func didManageField(newPlayingField: [[Player]])
    func handleSendRotationData()
    func removeView(view: UIViewController)
    func removeView(view: UIView)
    func displayRotationHistory()
}

class MatchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MatchCollectionViewControllerDelegate {
        
    //declarations for collectionView
    let cellID = "cellID"
    let matchFieldPositionHeader = "headerCellID"
    let benchID = "benchID"
    let nonPlayerID = "nonPlayerID"
    let basePositionCell = "basePositionCell"
    let playingFieldID = "playingFieldID"
    var tappedArray = [IndexPath]()
    
    //MARK:- Player data models
    var playerList = [Player]()
    var playingField = [[Player]]()
    var playerTypes = [
        PositionOnField.Back.rawValue,
        PositionOnField.Midfield.rawValue,
        PositionOnField.Forward.rawValue,
        PositionOnField.Bench.rawValue,
    ]
    var positionDictionary = [IndexPath:Player?]()
    var noFieldedPlayers = true
    
    //declarations for timer
    var timer = Timer()
    var gameClockTime = 0.0
    let matchTimerView: MatchTimerView = {
        let timerView = MatchTimerView()
        timerView.isHidden = true
        return timerView
    }()
    
    var manageButton = UIBarButtonItem()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "AFLField")
        image.contentMode = .scaleAspectFit
        image.tintAdjustmentMode = .dimmed //WHY: this does nothing...
        return image
    }()
    
    //declarations for match Object
    var fieldLedger = [RotationData]()
    var rotationLedger = [RotationData]()
    var timerEnabled = false
    
    //declarations for edit options
//    var editingMode = "Manage"
    
    let noPlayersView: FooterView = {
        let playerView = FooterView()
        playerView.adjustFooterText(title: "Setup required.", subText: "Set the field by tapping 'Manage'.")
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.isHidden = true
        return playerView
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "infoIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleInfoButton), for: .touchUpInside)
        return button
    }()
    
    var hasModifiedField = false
    
    //MARK:- View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        collectionView.register(PositionOnBenchCell.self, forCellWithReuseIdentifier: benchID)
        collectionView.register(MatchFieldPositionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: matchFieldPositionHeader)
        collectionView.register(NonPlayerCell.self, forCellWithReuseIdentifier: nonPlayerID)
        collectionView.register(BasePositionCell.self, forCellWithReuseIdentifier: basePositionCell)
        collectionView.register(PlayingFieldCell.self, forCellWithReuseIdentifier: playingFieldID)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /// called every time the view is presented. ViewDidLoad() is only called upon initialisation.
        print("View loading.")
        if hasModifiedField == false {
            fetchPlayers()
            setPlayingField()
        }
        tappedArray = []
        // if there are no players, reset the view...
        if playerList.isEmpty == true {
            viewDidLoad()
        }
    }
    
    //MARK:- fetchPlayers SAVED onto the device.
    func fetchPlayers(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        do {
            let list = try context.fetch(fetchRequest)
            self.playerList = list
            filterTeamList(teamList: playerList)
            presentAppropriateContent()
        }catch let fetchError {
            print("Failed to fetch Player List with error: \(fetchError)")
        }
    }
    
    // Filter the players into back, mid, forward and bench.
    private func filterTeamList(teamList: [Player]){
        playingField = [[Player]]()
        playerTypes.forEach { (fieldPosition) in
            playingField.append(teamList.filter{$0.positionOnField == fieldPosition})
        }
    }
    
    // MARK: - delegate methods
    // Set the playing field, based on the changes made in 'Manage' mode.
    func didManageField(newPlayingField: [[Player]]){
        print("Updating match field.")
        playingField = newPlayingField
        setPlayingField()
        collectionView.reloadData()
    }
    
    fileprivate func setPlayingField() {
        
        positionDictionary = [[0,0] : nil, // begin backline players
                              [0,1] : nil,
                              [0,2] : nil,
                              [0,3] : nil,
                              [0,4] : nil,
                              [0,5] : nil,
                              [1,0] : nil, // begin midfield players
                              [1,1] : nil,
                              [1,2] : nil,
                              [1,3] : nil,
                              [1,4] : nil,
                              [1,5] : nil,
                              [2,0] : nil, // begin Fwd players
                              [2,1] : nil,
                              [2,2] : nil,
                              [2,3] : nil,
                              [2,4] : nil,
                              [2,5] : nil,
                              [3,0] : nil, // begin Benched players
                              [3,1] : nil,
                              [3,2] : nil,
                              [3,3] : nil,
        ]
        
        for playingLine in playingField { // playingLine is the field Positions or Areas
            let section = playingField.firstIndex(of: playingLine)
            for player in playingLine {
                let row = playingLine.firstIndex(of: player)
                let playingIndex = IndexPath(row: row ?? 3, section: section ?? 3)
                positionDictionary[playingIndex] = player
            }
        }
    }
    
    func removeView(view: UIViewController){
        print("Removing view...")
        view.dismiss(animated: true, completion: nil)
    }
    
    func removeView(view: UIView) {
        print("Removing subView")
        view.removeFromSuperview()
    }
    
    
    func displayRotationHistory(){
        let rotationHistory = RotationHistoryView()
        rotationHistory.delegate = self
        rotationHistory.matchStillRunning = fieldLedger.isEmpty == false ? true : false
        rotationHistory.modalPresentationStyle = .formSheet
        rotationHistory.preferredContentSize = CGSize(width: 100, height: 100)
        var reversedRotationLedger = rotationLedger
        reversedRotationLedger.reverse()
        rotationHistory.rotationList = reversedRotationLedger
        present(rotationHistory, animated: true, completion: nil)
    }
    
    //MARK:- private methods
    
    private func presentAppropriateContent() {
        checkForPlayerData()
        // checks for matchTimer
        if noFieldedPlayers == false {
            matchTimerView.isHidden = false
        } else {
            matchTimerView.isHidden = true
        }
        // checks for "Setup" dialogue
        if noFieldedPlayers == true {
            noPlayersView.isHidden = false
            if playerList.isEmpty == true {
                noPlayersView.isHidden = false
                return
            }
        }
    }
    
    func fillEmptySlotsInPlayingField(position: String, countOfPlayers: Int, sectionToAddTo: Int) {
        var countOfPlayers = countOfPlayers
        print("Beginning count of players in \(position): \(countOfPlayers)")
        // check if the section needs filling
        if countOfPlayers < 6 {
            while countOfPlayers < 6 {
                // create a fake Player
                let player = Player()
                player.name = "NON"
                player.number = Int16(0)
                player.positionOnField = position
                // insert this player into the playing position
                playingField[sectionToAddTo].append(player)
                countOfPlayers += 1
                print("Incremented count: ", countOfPlayers)
            }
        } else {
            print("No players need to be created for ", position)
        }
    }
    
    fileprivate func checkForPlayerData() { // this logic displays the "Setup required" message
        for section in playingField {
            if section.isEmpty == false {
                noFieldedPlayers = false
                noPlayersView.isHidden = true
                return
            } else {
                noFieldedPlayers = true
            }
        }
    }
    
    //MARK:- setUpCollectionView
    private func setUpCollectionView(){
        collectionView?.delegate = self // necessary for didSelect method
        collectionView?.dataSource = self // necessary for didSelect method
        collectionView.allowsSelection = true
        navigationItem.title = "Board"
        if #available(iOS 13, *) {
            collectionView.backgroundColor = .secondarySystemBackground
        } else {
            collectionView.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        }
//        collectionView.backgroundView = backgroundImage // ENABLE THIS WHEN YOU WANT THE BG IMAGE
        manageButton = UIBarButtonItem(title: "Manage", style: .plain, target: self, action: #selector(handleManageButton))
        
        manageButton.isEnabled = true
        navigationItem.rightBarButtonItems = [manageButton]
        
        collectionView.addSubview(noPlayersView)
        collectionView.addSubview(matchTimerView)
        noPlayersView.addSubview(infoButton)
        let bottomInsetSpacing: CGFloat = 68
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInsetSpacing, right: 0) // this spaces the cv up from the bottom of the screen
        matchTimerView.matchCollectionViewDelegate = self
        NSLayoutConstraint.activate([
            matchTimerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            matchTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            matchTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            matchTimerView.heightAnchor.constraint(equalToConstant: bottomInsetSpacing),
            ])
        NSLayoutConstraint.activate([
            noPlayersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noPlayersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noPlayersView.topAnchor.constraint(equalTo: view.topAnchor),
            noPlayersView.heightAnchor.constraint(equalToConstant: 400),
            
            infoButton.centerXAnchor.constraint(equalTo: noPlayersView.centerXAnchor),
//            infoButton.centerYAnchor.constraint(equalTo: noPlayersView.centerYAnchor)
            infoButton.widthAnchor.constraint(equalToConstant: 40),
            infoButton.heightAnchor.constraint(equalToConstant: 40),
            infoButton.bottomAnchor.constraint(equalTo: noPlayersView.bottomAnchor)
            
            ])
    }
    
    //MARK: - @objc methods

    @objc func handleManageButton() {
        print("Tapped MANAGE")
        //check if there are players, show alert if none are present
        if playerList.isEmpty == true {
        //show alert
        print("displaying alert")
            let noPlayersAlert = UIAlertController(title: "Add Players", message: "There are no players listed. Go to the Player List and add players to set up a match and start the game.", preferredStyle: .alert)
            noPlayersAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(noPlayersAlert, animated: true)
        } else {
        print("displaying manage view")
            let manageMatchController = ManageFieldController(collectionViewLayout: UICollectionViewFlowLayout())
            manageMatchController.delegate = self
            manageMatchController.matchInProgress = gameClockTime != 0.0 ? true : false
            navigationController?.pushViewController(manageMatchController, animated: true)
        }
    }
    
    @objc func handleInfoButton() {
        print("Tapped info btn")
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let onboardingInformatic = OnboardingView(frame: frame)
        onboardingInformatic.delegate = self
        onboardingInformatic.animateViewsIn()
        view.addSubview(onboardingInformatic)
        
        NSLayoutConstraint.activate([
            onboardingInformatic.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingInformatic.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingInformatic.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingInformatic.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func handleRotationHistory() {
        print("handling rotation history.")
        let rotationHistory = RotationHistoryView()
        rotationHistory.delegate = self
        rotationHistory.modalPresentationStyle = .formSheet
        rotationHistory.preferredContentSize = CGSize(width: 100, height: 100)
        var reversedRotationLedger = rotationLedger
        reversedRotationLedger.reverse()
        rotationHistory.rotationList = reversedRotationLedger
        present(rotationHistory, animated: true, completion: nil)
    }
    
    
    //MARK:- Rotation methods
    func completeRotationLedger() {
        print("Completing rotation ledger...")
        fieldLedger.forEach { (element) in
            var rotation = element
            // add the time the player stopped
            let now = Date()
            let startingTime = rotation.timeStartedOnField
             rotation.timeIntervalSinceStartingOnField = Int(now.timeIntervalSince(startingTime))
            
            rotationLedger.append(rotation)
        }
        // empty the fieldLedger and rotation
        fieldLedger = []
        
        for element in rotationLedger {
            print("Player Name: \(String(describing:element.player.name))")
            print("Player finished in position: \(element.position)")
            print("Position Start Time: \(element.timeStartedOnField)")
            print("Total time in Position: \(element.timeIntervalSinceStartingOnField)\n")
        }
    }
    
    private func addPlayerToRotationLedger(player: Player, cellIndex: IndexPath){
        if timerEnabled == true {
            // find their position based on the cell they are from
            let position = getFieldPositionLabelForRotation(index: cellIndex)
            
            // find the time they started from Field array
            var startingTime = Date()
            var timeInPosition = Int()
            for element in fieldLedger {
                if player == element.player {
                    startingTime = element.timeStartedOnField
                    // fill in the position length based on starting time
                    let now = Date()
                    timeInPosition = Int(now.timeIntervalSince(startingTime))
                }
            }
            // paste the data into Rotation ledger
            let rotation = RotationData(player: player, position: position, timeStartedOnField: startingTime, timeIntervalSinceStartingOnField: timeInPosition)
            rotationLedger.append(rotation)
        }
    }
    
    private func updateFieldLedger(player: Player, cellIndex: IndexPath) {

        // reset the player's position and timeStartedOnField
        let newPosition = getFieldPositionLabelForRotation(index: cellIndex)
        let now = Date()
        // Find the location of the player in the fieldLedger
        let playerIndex = fieldLedger.firstIndex {$0.player === player}
        // update the player with new values
//        player.positionOnField = newPosition
        let rotation = RotationData(player: player, position: newPosition, timeStartedOnField: now)
        print("/nSetting position \(String(describing: playerIndex)) in FieldLedger to Rotation: \(rotation)")
        if let newIndex = playerIndex {
                fieldLedger[newIndex] = rotation
        }
    }
    
    //MARK:- Collection View Methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return noFieldedPlayers == true ? 0 : playingField.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 3 ? 4 : 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // check if the cell is on the bench
        if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playingFieldID, for: indexPath) as! PlayingFieldCell
            if let fieldedPlayer = positionDictionary[indexPath] {
                // check if there is aplayer in position
                cell.fieldPositionLabel.text = getFieldPositionLabel(index: indexPath)
                if fieldedPlayer == nil {
                    cell.addPlayerButton.isHidden = false
                    cell.matchPlayerDetailView.isHidden = true
                    cell.fieldPositionLabel.isHidden = true
                    return cell
                }
                cell.matchPlayerDetailView.player = fieldedPlayer
                cell.addPlayerButton.isHidden = true
                cell.matchPlayerDetailView.isHidden = false
                cell.fieldPositionLabel.isHidden = true
                return cell
            }
            return cell
        } else {
            // define position and either player or add btn
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playingFieldID, for: indexPath) as! PlayingFieldCell
            if let fieldedPlayer = positionDictionary[indexPath] {
                
                cell.fieldPositionLabel.text = getFieldPositionLabel(index: indexPath)
                if fieldedPlayer == nil {
                    cell.addPlayerButton.isHidden = false
                    cell.matchPlayerDetailView.isHidden = true
                    cell.fieldPositionLabel.isHidden = false
                    return cell
                }
                cell.matchPlayerDetailView.player = fieldedPlayer
                cell.addPlayerButton.isHidden = true
                cell.matchPlayerDetailView.isHidden = false
                cell.fieldPositionLabel.isHidden = false
                return cell
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSize = ((view.frame.width-36)/3)
        let benchWidthSize = (((view.frame.width)-32)/4)
        let height = (view.frame.height-168)/12
        
//        let benchCellHeightSize: CGFloat = 40 // used to be 50
        return indexPath.section == 3 ? CGSize(width: benchWidthSize, height: height) : CGSize(width: widthSize, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        // Check if this is the first touch; append value and exit out
        if tappedArray.isEmpty == true {
            // add the index to the array
            tappedArray.append(indexPath)
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            return false
        } else {
            // the tapped array now has two indexes. Check if they are the same player - reset the array if so.
            if tappedArray.contains(indexPath){
                collectionView.deselectItem(at: indexPath, animated: true)
                tappedArray.removeAll()
                return false
            }
            tappedArray.append(indexPath)
            // Define players for each path:
            let playerOne = positionDictionary[tappedArray[0]]
            let playerTwo = positionDictionary[tappedArray[1]]

            // Unwrap the double optional like this:
            if let firstPlayer = playerOne, let player = firstPlayer {
                addPlayerToRotationLedger(player: player, cellIndex: tappedArray[0])
            }
            if let secondPlayer = playerTwo, let player = secondPlayer {
                addPlayerToRotationLedger(player: player, cellIndex: tappedArray[1])
            }
            // Update the FieldLedger with positional starting times
            // FieldLedger needs to know that player One is now in the second position
            if let firstPlayer = playerOne, let player = firstPlayer {
                updateFieldLedger(player: player, cellIndex: tappedArray[1])
            }
            // FieldLedger needs to know that player Two is now in the first position
            if let secondPlayer = playerTwo, let player = secondPlayer {
                updateFieldLedger(player: player, cellIndex: tappedArray[0])
            }
//            if let secondPlayer = playerTwo, let player = secondPlayer {
//                addPlayerToRotationLedger(player: player, cellIndex: tappedArray[1])
//            }
            // Now swap the players:
            positionDictionary[tappedArray[0]] = playerTwo
            positionDictionary[tappedArray[1]] = playerOne
            // Batch update the view (to ensure animations fire at the same time)
            collectionView.performBatchUpdates({
                // Remove the native reload animation by using this withDuration=0 trick.
                UIView.animate(withDuration: 0) {
                    collectionView.reloadItems(at: [self.tappedArray[0], self.tappedArray[1]])
                }
            }) { (_) in
                self.tappedArray = []
            }
            hasModifiedField = true
        }
        return false
    }
    
    //MARK:- HEADER METHODS
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: matchFieldPositionHeader, for: indexPath) as! MatchFieldPositionHeader
        if indexPath.section == 0 {
            header.headerTitleLabel.text = "BACKLINE"
        } else if indexPath.section == 1 {
            header.headerTitleLabel.text = "MIDFIELD"
        } else if indexPath.section == 2 {
            header.headerTitleLabel.text = "FORWARD"
        } else {
            header.headerTitleLabel.text = "BENCH"
        }
        header.headerTitleLabel.applyHeaderStyle()
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let customInset = UIEdgeInsets(top: 4, left: 16, bottom: 16, right: 4)
        return customInset
    }
    
    private func incrementFieldCount() {
        print("Incrementing count")
    }
    
    //MARK:- Send Rotation Methods
    @objc func handleSendRotationData() {
        if rotationLedger.isEmpty == false { //check for rotation data
            let fileName = "boardmanRotationData.csv"
            // set up the date format
            let dateOfMatch = rotationLedger[0].timeStartedOnField
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd yyyy"
            let formattedDateString = dateFormatter.string(from: dateOfMatch)
            dateFormatter.dateFormat = "HH:mm a"
            let formattedStartTimeString = dateFormatter.string(from: dateOfMatch)
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)!
            var csvText = "Match dated \(formattedDateString),Began: \(formattedStartTimeString)\nPlayer Name,Position,Time in Position(mm:ss)\n"
            
            for listEntry in rotationLedger {
                let mins = listEntry.timeIntervalSinceStartingOnField/60
                let seconds = (listEntry.timeIntervalSinceStartingOnField)
                print("seconds: \(seconds)")
                var secondString = "\(seconds)"
                if seconds > 60 {
                    let modulus = seconds % 60
                    secondString = String(format: "%02d", modulus)
                }
                if seconds < 10 {
                    secondString = "0\(seconds)"
                }
                let timeInPositionString = "\(mins):\(secondString)"
                let txt = "\(listEntry.player.name ?? "(Name unavailable)"),\(listEntry.position),\(timeInPositionString)\n"
                csvText.append(txt)
            }
            // enter end of match recording
            let endDateOfMatch = Date()
            let formattedEndTimeString = dateFormatter.string(from: endDateOfMatch)
            csvText.append("\nFinished: \(formattedEndTimeString)")
            
            do {
                try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8) // ACTIVATE THIS WHEN READY TO USE REAL DEVICES
                print("Rotation data: ", csvText)
            } catch {
                print("Failed to create file with error:  ", error)
            }
            
            let shareActivityView = UIActivityViewController(activityItems: [path], applicationActivities: [])
            shareActivityView.excludedActivityTypes = [
            ]
//            present(shareActivityView, animated: true, completion: nil)
            present(shareActivityView, animated: true) {
                print("Displaying share activity view.")
//                self.rotationLedger = [] do not reset ledger....
                print("rotationLedger reset.")
            }
        } else {
            let noPlayersAlert = UIAlertController(title: "Reset Match Clock", message: "No player rotation data was found. Reset the match clock to collect rotation data.", preferredStyle: .alert)
            noPlayersAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(noPlayersAlert, animated: true)
        }
    }
}
