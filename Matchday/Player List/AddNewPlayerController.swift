//
//  AddNewPlayerController.swift
//  Matchday
//
//  Created by Lachy Pound on 24/7/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

class AddNewPlayerController: UIViewController {
    
    var delegate: TeamListControllerDelegate?
    var player: Player? {
        didSet{
            guard let playerObj = player else {return}
            surnameEntryField.text = playerObj.name
            numberEntryField.text = String(playerObj.number)
            topRightButtonTitle = "Save"
            saveAndAddAnotherButton.isHidden = true
        }
    }
    var topRightButtonTitle = "Add"
    var playerIndexPath: IndexPath?
    
    let saveAndAddAnotherButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save and add another", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: #selector(handleSaveAndAddAnother), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        return button
    }()
    let backgroundView: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = .white
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let firstnameLabel: UILabel = {
        let label = UILabel()
        label.text = "First name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstNameEntryField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter first name"
        return textField
    }()
    let surnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Surname"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let surnameEntryField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter surname"
        return textField
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberEntryField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter player number"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ternary operator:
        navigationItem.title = player == nil ? "Create Player" : "Edit Player"
        if navigationItem.title == "Create Player" {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpView()
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleAddPlayer(){
        if player == nil {
            createPlayer()
            dismissView()
        } else {
            savePlayerChanges()
            dismissView()
        }
    }
    
    private func removeTrailingSpaces(name: String) -> String {
        var validatedName = name
        let lastCharacter = name.suffix(1)
        if lastCharacter.contains(" ") {
            validatedName.removeLast()
        }
        return validatedName
    }
    
    private func savePlayerChanges(){
        // validation :
        guard var nameEntry = surnameEntryField.text else {return}
        nameEntry = removeTrailingSpaces(name: nameEntry)
        guard let numberEntry = numberEntryField.text else {return}
        
        if nameEntry.checkForValidString(entryString: nameEntry) == false {
            displayOKAlert(title: "Empty Player Name", message: "You have not entered a player name.", style: .alert)
            return
        }
        if nameEntry.checkStringForCommas(entryString: nameEntry) == false {
            displayOKAlert(title: "Comma Detected", message: "Commas impair rotation data files. Please remove commas from player names.", style: .alert)
            return
        }
        if numberEntry.isEmpty {
            displayOKAlert(title: "Empty Player Number", message: "You have not entered a player number.", style: .alert)
            return
        }
        guard Int16(numberEntry) != nil else {
            displayOKAlert(title: "Numbers Only", message: "Player number not valid.", style: .alert)
        return
        }
        if let number = Int16(numberEntry) {
            guard let checkPlayerDuplicate = delegate?.checkForDuplicate(playerName: nameEntry, playerNumber: number) else {return}
            if checkPlayerDuplicate {
                displayOKAlert(title: "Duplicate Player", message: "A player with this name and number already exists. Create another or modify the original player.", style: .alert)
                return
            }
        }
        
        guard let player = self.player else {return}
        print("Attempting core data update to Player: \(player)")
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        player.name = self.surnameEntryField.text
        
        if let numberText = numberEntryField.text {
            guard let number = Int16(numberText) else {return}
            player.number = number
            print("Player: \(String(describing: player.name)), number: \(number), position: \(String(describing: player.positionOnField))")
        }
        
        self.navigationController?.popViewController(animated: true)
        do {
            try context.save()
            // RELOAD TABLEVIEW
            guard let playerIndexPath = self.playerIndexPath else {return}
            self.delegate?.DidEditExistingPlayer(player: player, playerIndexPath: playerIndexPath)
        } catch let updateErr {
            print("Failed to update the player with error: \(updateErr)")
        }
    }
    
    private func createPlayer(){
        print("Attempting to create player...")
        // check if the user has adequate input
        guard var nameEntry = surnameEntryField.text else {return}
        nameEntry = removeTrailingSpaces(name: nameEntry)
        guard let numberEntry = numberEntryField.text else {return}
        
        if nameEntry.checkForValidString(entryString: nameEntry) == false {
            displayOKAlert(title: "Empty Player Name", message: "You have not entered a player name.", style: .alert)
            return
        }
        if nameEntry.checkStringForCommas(entryString: nameEntry) == false {
            displayOKAlert(title: "Comma Detected", message: "Commas impair rotation data files. Please remove commas from player names.", style: .alert)
            return
        }
        if numberEntry.isEmpty {
            displayOKAlert(title: "Empty Player Number", message: "You have not entered a player number.", style: .alert)
            return
        }
        guard let number = Int16(numberEntry) else {
            displayOKAlert(title: "Numbers Only", message: "Player number not valid.", style: .alert)
            return
        }
        if let number = Int16(numberEntry) {
            guard let checkPlayerDuplicate = delegate?.checkForDuplicate(playerName: nameEntry, playerNumber: number) else {return}
            if checkPlayerDuplicate {
                displayOKAlert(title: "Duplicate Player", message: "A player with this name and number already exists. Create another or modify the original player.", style: .alert)
                return
            }
        }
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let newPlayer = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context) as! Player
        newPlayer.name = self.surnameEntryField.text
        newPlayer.number = 99
        newPlayer.positionOnField = "Listed"
        newPlayer.number = number
        print("Player Created: \(String(describing: newPlayer.name)), number: \(number); position: \(String(describing: newPlayer.positionOnField))")
                    
        do {
            try context.save()
            self.delegate?.DidAddNewPlayer(player: newPlayer)
        } catch let saveErr {
            print("Failed to update the player with error: \(saveErr)")
        }
    }
    
    func dismissView() {
        dismiss(animated: true)
    }
    func setUpView(){
            
        view.addSubview(backgroundView)
        view.addSubview(firstnameLabel)
        view.addSubview(firstNameEntryField)
        view.addSubview(surnameLabel)
        view.addSubview(surnameEntryField)
        view.addSubview(numberLabel)
        view.addSubview(numberEntryField)
        view.addSubview(saveAndAddAnotherButton)
        
        NSLayoutConstraint.activate([backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                    backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                                    backgroundView.bottomAnchor.constraint(equalTo: numberEntryField.bottomAnchor),
            
                                    firstnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                                    firstnameLabel.heightAnchor.constraint(equalToConstant: 50),
                                    firstnameLabel.topAnchor.constraint(equalTo: view.topAnchor),
                                    firstnameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
                                    
                                    firstNameEntryField.leadingAnchor.constraint(equalTo: surnameLabel.trailingAnchor, constant: 8),
                                    firstNameEntryField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
                                    firstNameEntryField.heightAnchor.constraint(equalToConstant: 50),
                                    firstNameEntryField.topAnchor.constraint(equalTo: firstnameLabel.topAnchor),
                                    
                                    surnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                                    surnameLabel.heightAnchor.constraint(equalToConstant: 50),
                                    surnameLabel.topAnchor.constraint(equalTo: firstnameLabel.bottomAnchor),
                                    surnameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
                                    
                                    surnameEntryField.leadingAnchor.constraint(equalTo: surnameLabel.trailingAnchor, constant: 8),
                                    surnameEntryField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
                                    surnameEntryField.heightAnchor.constraint(equalToConstant: 50),
                                    surnameEntryField.topAnchor.constraint(equalTo: surnameLabel.topAnchor),
            
                                    numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                                    numberLabel.trailingAnchor.constraint(equalTo: surnameLabel.trailingAnchor),
                                    numberLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor),
                                    numberLabel.heightAnchor.constraint(equalToConstant: 50),
                                    
                                    numberEntryField.leadingAnchor.constraint(equalTo: surnameLabel.trailingAnchor, constant: 8),
                                    numberEntryField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
                                    numberEntryField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor),
                                    numberEntryField.heightAnchor.constraint(equalToConstant: 50),
                                    
                                    saveAndAddAnotherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                    saveAndAddAnotherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                    saveAndAddAnotherButton.topAnchor.constraint(equalTo: numberEntryField.bottomAnchor, constant: 60),
                                    saveAndAddAnotherButton.heightAnchor.constraint(equalToConstant: 44),
            ])
    }
    
    func setUpNavBar(){
        view.backgroundColor = view.provideSecondaryBackgroundColour()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: topRightButtonTitle, style: .plain, target: self, action: #selector(handleAddPlayer))
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func handleSaveAndAddAnother() {
        print("saving player and adding another")
        createPlayer()
        resetEntryFields()
    }
    private func resetEntryFields() {
        firstNameEntryField.text = ""
        surnameEntryField.text = ""
        numberEntryField.text = ""
        firstNameEntryField.placeholder = "Enter first name"
        surnameEntryField.placeholder = "Enter surname"
        numberEntryField.placeholder = "Enter player number"
    }
}

extension UIViewController {
    func displayOKAlert(title: String, message: String, style: UIAlertController.Style){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension String {
    func checkForValidString(entryString: String) -> Bool{
        if entryString.isEmpty {
            return false
        }
        return true
    }
    func checkStringForCommas(entryString: String) -> Bool {
        if entryString.contains(",") == true {
            return false
        }
        return true
    }
}
