//
//  ManageMatchController.swift
//  Matchday
//
//  Created by Lachy Pound on 26/10/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

protocol ManageFieldControllerDelegate {
    func addPlayersToPosition(selectedPosition: PositionOnField)
}

class ManageFieldController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ManageFieldControllerDelegate {
    
    // i need a delegate to send data back to the Match VC
    var delegate: MatchCollectionViewControllerDelegate?
    
    var hasViewedManageTutorial = false
    
    var matchInProgress = false
    
    var playerList = [Player]()
    var playingField = [[Player]]()
    var playerTypes = [
        PositionOnField.Back.rawValue,
        PositionOnField.Midfield.rawValue,
        PositionOnField.Forward.rawValue,
        PositionOnField.Bench.rawValue,
        PositionOnField.Listed.rawValue,
    ]
    var selectedPlayers = [Player]()
    
    //cell IDs
    let playerID = "playerID"
    let buttonID = "buttonID"
    let headerID = "headerID"
    let cellID = "cellID"
    let footerID = "footerID"
    
    let errorTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Team changes cannot be made while recording."
        label.textColor = .systemRed
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewElements()
        fetchPlayers()
        displayManageTutorial()
    }
    
    //MARK:- Fetch players
    private func fetchPlayers(){
        playingField = [[Player]]()     //WHY-> is there a better way to do this
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        do {
            let list = try context.fetch(fetchRequest)
            self.playerList = list
            playerTypes.forEach { (fieldPosition) in
                playingField.append(playerList.filter {$0.positionOnField == fieldPosition})
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }catch let fetchError {
            print("Failed to fetch Player List with error: \(fetchError)")
        }
    }
    
    @objc func handleSaveField() {
        if matchInProgress != true {
            playingField.remove(at: 4)
            delegate?.didManageField(newPlayingField: playingField)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func displayManageTutorial(){
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "hasViewedManageTutorial") == nil {
//            defaults.set("No", forKey: "hasViewedManageTutorial")
//            defaults.synchronize()
            
            // init storyboard
            let tutorialView = ManageTutorialView()
            // display tutorial
//            self.navigationController?.pushViewController(tutorialView, animated: true)

//            present(tutorialView, animated: true, completion: nil)
            view.addSubview(tutorialView)
            print("displaying Tut")
        }
        
//        if hasViewedManageTutorial == false {
//            print("displaying Tut")
//             // this gets re-initialised when the page opens. Either make this a singleton or hold the bool value in the MatchController and pass it in when the Manage view is displayed.
//            func checkForViewedManageTutorial() {
//                hasViewedManageTutorial = true
//            }
//        } else {
//            print("Tutorial has been viewed and will not be displayed.")
//        }
    }
    
    //MARK:- Setup methods
    fileprivate func setUpViewElements() {
        navigationItem.title = "Manage"
        collectionView.allowsMultipleSelection = true
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .secondarySystemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(EmptyPositionCell.self, forCellWithReuseIdentifier: buttonID)
        collectionView.register(ManagePlayerDetailView.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(AddToFieldCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.register(AddToFieldCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        let saveFieldButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveField))
        let resetFieldButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleResetField))
        if matchInProgress != true {
            resetFieldButton.isEnabled = true
        } else {
            resetFieldButton.isEnabled = false
        }
        navigationItem.rightBarButtonItems = [saveFieldButton, resetFieldButton]
        
        if matchInProgress == true {
            collectionView.addSubview(errorTextLabel)
            NSLayoutConstraint.activate([
                errorTextLabel.topAnchor.constraint(equalTo: view.topAnchor),
                errorTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                errorTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        }
    }
    
    @objc func handleResetField() {
        print("resetting field...")
        let resetFieldAlert = UIAlertController(title: "Reset the field?", message: "This will clear the field and return the players to the player list.", preferredStyle: .alert)
//        resetFieldAlert.addAction(UIAlertAction(title: "Reset", style: .default, handler: ))
        resetFieldAlert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            let context = CoreDataManager.shared.persistentContainer.viewContext
            self.playingField.forEach { (playerPosition) in
                playerPosition.forEach { (player) in
                    player.positionOnField = "Listed" // this actually works
                }
            }
            do {
                try context.save()
                DispatchQueue.main.async {
                    self.fetchPlayers()
                    self.collectionView.reloadData()
                }
            } catch let saveErr {
                print("Failed to save with error: \(saveErr)")
            }
            
            self.delegate?.didManageField(newPlayingField: self.playingField)
        }))
        resetFieldAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(resetFieldAlert, animated: true)
    }
    
    //MARK:- Collection View methods
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return playingField.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playingField[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ManagePlayerDetailView
        cell.player = playingField[indexPath.section][indexPath.row]
        cell.backgroundColor = checkSelection(cell: cell)
        return cell
    }
    
    //MARK:- Sizing and insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let customInsets = UIEdgeInsets(top: 4, left: 2, bottom: 4, right: 2)
        return customInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSize = ((view.frame.width-9)/3)
        let benchWidthSize = ((view.frame.width-10)/4)
        let cellHeightSize: CGFloat = 42 // 42 is the height of cell
        return indexPath.section == 4 ? CGSize(width: benchWidthSize, height: cellHeightSize) : CGSize(width: widthSize, height: cellHeightSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 68)
    }
    
    //MARK:- DidSelectitemAt IndexPath
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // ensure the player is added to 'selected' array
            let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = checkSelection(cell: cell as! ManagePlayerDetailView)
        // grab the player
        let player = playingField[indexPath.section][indexPath.row]
        selectedPlayers.append(player)
        //enable add players button
        if selectedPlayers.count == 1 {
            displayAddPlayersButton()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = checkSelection(cell: cell as! ManagePlayerDetailView)
        // remove the player from array
        let selectedPlayer = playingField[indexPath.section][indexPath.row]
        var currentIndex = 0
        for player in selectedPlayers {
            if player == selectedPlayer {
                selectedPlayers.remove(at: currentIndex)
            }
            currentIndex += 1
        }
        //disable add players button
        if selectedPlayers.isEmpty == true {
            displayAddPlayersButton()
        }
    }
    
    private func displayAddPlayersButton() {
        if selectedPlayers.isEmpty != true {
            // do not show the Add players button
            for n in 0...4 {
                let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: [n,0]) as! AddToFieldCell
                header.addButton.isHidden = false
                header.animateAddButton(startAlpha: 0, endAlpha: 1, startPos: 20, endPos: 0)
            }
        } else {
            // show button
            for n in 0...4 {
                let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: [n,0]) as! AddToFieldCell
//                header.addButton.isHidden = true
                header.animateAddButton(startAlpha: 1, endAlpha: 0, startPos: 0, endPos: 20)
            }
        }
    }
    
    private func checkSelection(cell: ManagePlayerDetailView) -> UIColor {
        
        var highlight = UIColor()
        var defaultSelection = UIColor()
            // default cell, with checks for light or dark mode
            // highlighted cell, with checks for L or dark
        if #available(iOS 13.0, *){
            highlight = .systemGray
            defaultSelection = .systemGray3
        } else {
            highlight = .gray
            defaultSelection = .lightGray
        }
        
       return cell.isSelected == true ? highlight : defaultSelection
    }
    
    private func enableAddPlayerButton() -> Bool {
        return selectedPlayers.isEmpty == true ? false : true
    }
    
    //MARK:- Headers & Footers
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AddToFieldCell
        header.delegate = self
        header.addButton.isHidden = true
        if indexPath.section == 0 {
            header.titleLabel.text = "BACKLINE"
            header.position = PositionOnField.Back
        } else if indexPath.section == 1 {
            header.titleLabel.text = "MIDFIELD"
            header.position = PositionOnField.Midfield
        } else if indexPath.section == 2 {
            header.titleLabel.text = "FORWARD"
            header.position = PositionOnField.Forward
        } else if indexPath.section == 3 {
            header.titleLabel.text = "BENCH"
            header.position = PositionOnField.Bench
        } else {
            header.titleLabel.text = "PLAYER LIST"
            header.position = PositionOnField.Listed
        }
        return header
    }
    
    //MARK:- Delegate methods
    
    func addPlayersToPosition(selectedPosition: PositionOnField) {
        if selectedPlayers.isEmpty == true {
            let noPlayersAlert = UIAlertController(title: "Select Players", message: "Select one or more players and then tap this button.", preferredStyle: .alert)
            noPlayersAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(noPlayersAlert, animated: true)
        }
        
        //change the position of selected players
        let context = CoreDataManager.shared.persistentContainer.viewContext
        print("Adjusting positions")
        // find the position on field
        var destinationPosition: PositionOnField
        switch selectedPosition {
        case .Back:
            destinationPosition = .Back
        case .Midfield:
            destinationPosition = .Midfield
        case .Forward:
            destinationPosition = .Forward
        case .Bench:
            destinationPosition = .Bench
        case .Listed:
            destinationPosition = .Listed
        }
        selectedPlayers.forEach { (player) in
            player.positionOnField = destinationPosition.rawValue
            print("Player position updated to: \(String(describing: player.positionOnField))")
        }
        
        do {
            try context.save()
            DispatchQueue.main.async {
                self.fetchPlayers()
                self.collectionView.reloadData()
            }
        } catch let saveErr {
            print("Failed to save with error: \(saveErr)")
        }
        selectedPlayers = [Player]()
    }
    
    func checkIfSelected(){
        if selectedPlayers.isEmpty == true{
            return
        }
    }
}
