//
//  CreateStatSheetController.swift
//  Matchday
//
//  Created by Lachy Pound on 22/9/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

class CreateStatSheetController: UIViewController {
    
    var delegate: StatListController?
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Team", "Individual"])
//        control.
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(handleControlFunction), for: .valueChanged)
        return control
    }()
    
    let entryDataForIndividual = UIView()
    let entryDataForTeam = UIView()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter player name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.text = "Team"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter team"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let opponentLabel: UILabel = {
        let label = UILabel()
        label.text = "Opponent"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let opponentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter opponent"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let teamDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    fileprivate func setUpNavElements() {
        view.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        navigationItem.title = "Create Stat Sheet"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleSave))
        self.hideKeyboardWhenTappedAround()
    }
    
    fileprivate func setUpUI() {
        if #available(iOS 13.0, *) {
            entryDataForIndividual.backgroundColor = .systemBackground
            entryDataForTeam.backgroundColor = .systemBackground
        } else {
            entryDataForIndividual.backgroundColor = .white
            entryDataForTeam.backgroundColor = .white
        }
        entryDataForIndividual.translatesAutoresizingMaskIntoConstraints = false
        entryDataForTeam.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(entryDataForIndividual)
        view.addSubview(entryDataForTeam)
        view.addSubview(typeLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(teamLabel)
        view.addSubview(teamTextField)
        view.addSubview(opponentTextField)
        view.addSubview(opponentLabel)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        view.addSubview(teamDateLabel)
        view.addSubview(teamDatePicker)
        view.addSubview(segmentedControl)
        handleControlFunction()
        let rowHeight = CGFloat(50)

        //MARK: NSLayoutConstraints
        NSLayoutConstraint.activate([
        
        entryDataForIndividual.topAnchor.constraint(equalTo: view.topAnchor),
        entryDataForIndividual.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        entryDataForIndividual.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        entryDataForIndividual.bottomAnchor.constraint(equalTo: datePicker.bottomAnchor),
        
        entryDataForTeam.topAnchor.constraint(equalTo: view.topAnchor),
        entryDataForTeam.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        entryDataForTeam.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        entryDataForTeam.bottomAnchor.constraint(equalTo: teamDatePicker.bottomAnchor),
        
        typeLabel.topAnchor.constraint(equalTo: view.topAnchor),
        typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        typeLabel.widthAnchor.constraint(equalToConstant: 100),
        typeLabel.heightAnchor.constraint(equalToConstant: rowHeight),
        
        segmentedControl.topAnchor.constraint(equalTo: typeLabel.bottomAnchor),
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        segmentedControl.heightAnchor.constraint(equalToConstant: rowHeight),
        
        nameLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 4),
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        nameLabel.widthAnchor.constraint(equalToConstant: 100),
        nameLabel.heightAnchor.constraint(equalToConstant: rowHeight),
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
        
        teamLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 4),
        teamLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        teamLabel.widthAnchor.constraint(equalToConstant: 100),
        teamLabel.heightAnchor.constraint(equalToConstant: rowHeight),
        
        teamTextField.topAnchor.constraint(equalTo: teamLabel.topAnchor),
        teamTextField.leadingAnchor.constraint(equalTo: teamLabel.trailingAnchor, constant: 4),
        teamTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        teamTextField.bottomAnchor.constraint(equalTo: teamLabel.bottomAnchor),
        
        opponentLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor),
        opponentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        opponentLabel.widthAnchor.constraint(equalToConstant: 100),
        opponentLabel.heightAnchor.constraint(equalToConstant: rowHeight),
        
        opponentTextField.topAnchor.constraint(equalTo: opponentLabel.topAnchor),
        opponentTextField.leadingAnchor.constraint(equalTo: opponentLabel.trailingAnchor, constant: 4),
        opponentTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        opponentTextField.bottomAnchor.constraint(equalTo: opponentLabel.bottomAnchor),
        
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
        dateLabel.widthAnchor.constraint(equalToConstant: 100),
        dateLabel.heightAnchor.constraint(equalToConstant: rowHeight),
        
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
        datePicker.heightAnchor.constraint(equalToConstant: 200),
        
        teamDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        teamDateLabel.topAnchor.constraint(equalTo: opponentLabel.bottomAnchor),
        teamDateLabel.widthAnchor.constraint(equalToConstant: 100),
        teamDateLabel.heightAnchor.constraint(equalToConstant: rowHeight),
        
        teamDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        teamDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        teamDatePicker.topAnchor.constraint(equalTo: teamDateLabel.bottomAnchor),
        teamDatePicker.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    //MARK: Initialisation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavElements()
        setUpUI()
    }
    
    //MARK: Segmented Control
    @objc func handleControlFunction() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // this is Team based
            entryDataForIndividual.isHidden = true
            entryDataForTeam.isHidden = false
            nameLabel.isHidden = true
            nameTextField.isHidden = true
            teamLabel.isHidden = false
            teamTextField.isHidden = false
            opponentTextField.isHidden = false
            opponentLabel.isHidden = false
            dateLabel.isHidden = true
            datePicker.isHidden = true
            teamDateLabel.isHidden = false
            teamDatePicker.isHidden = false
        case 1:
            // this is individual
            entryDataForIndividual.isHidden = false
            entryDataForTeam.isHidden = true
            nameLabel.isHidden = false
            nameTextField.isHidden = false
            teamLabel.isHidden = true
            teamTextField.isHidden = true
            opponentTextField.isHidden = true
            opponentLabel.isHidden = true
            dateLabel.isHidden = false
            datePicker.isHidden = false
            teamDateLabel.isHidden = true
            teamDatePicker.isHidden = true
        default:
            print("Default hit and unlikely to do good things..")
        }
    }
    
    //MARK: Button Handling
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("Attempting to add Team record")
            handleAddTeamRecord()
        case 1:
            print("Attempting to add individual record")
            handleAddIndividualRecord()
        default:
            print("Not creating any record. Switch case entered default.")
        }
    }
    
    @objc func handleAddTeamRecord(){
        // checks for valid input
        if teamTextField.text == " " || teamTextField.text?.isEmpty == true {
            let attributedPlaceholder = NSAttributedString(string: "Enter a team name", attributes:[ NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.5)])
            teamTextField.text = ""
            teamTextField.attributedPlaceholder = attributedPlaceholder
        } else if opponentTextField.text == " " || opponentTextField.text?.isEmpty == true {
            let attributedPlaceholder = NSAttributedString(string: "Enter an opponent name", attributes:[ NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.5)])
            opponentTextField.text = ""
            opponentTextField.attributedPlaceholder = attributedPlaceholder
        } else {
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
            let newRecord = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
            newRecord.setValue("team", forKey: "type")
            newRecord.setValue(teamDatePicker.date, forKey: "created")
//            newRecord.setValue("\(teamTextField.text ?? "Team") vs \(opponentTextField.text ?? "Opponent")", forKey: "title")
            
            //The below sets the title to "v Opponent"
            newRecord.setValue("v \(opponentTextField.text ?? "Opponent")", forKey: "title")
            
            let newTeamRecord = NSEntityDescription.insertNewObject(forEntityName: "TeamRecord", into: context) as! TeamRecord
            newTeamRecord.setValue(teamTextField.text, forKey: "teamLabel")
            newTeamRecord.setValue(opponentTextField.text, forKey: "opponentLabel")
            
            newTeamRecord.record = newRecord
            
            let teamStat1 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
            teamStat1.statisticName = "Clearances"
            teamStat1.opponentValue = 0
            teamStat1.teamValue = 0
            
            teamStat1.teamRecord = newTeamRecord
            
            let teamStat2 = NSEntityDescription.insertNewObject(forEntityName: "TeamStatistic", into: context) as! TeamStatistic
            teamStat2.statisticName = "Inside 50s"
            teamStat2.opponentValue = 0
            teamStat2.teamValue = 0
            
            teamStat2.teamRecord = newTeamRecord
            
            // perform the save
            do {
                try context.save()
                dismiss(animated: true) {
                    self.delegate?.didAddStatSheet(newRecord: newRecord)
                }
            } catch let error {
                print("Unable to create Team Statistic with Error: ", error)
            }
        }
    }
    
    @objc func handleAddIndividualRecord(){
        // if check here
        if nameTextField.text == " " || nameTextField.text?.isEmpty == true {
            let attributedPlaceholder = NSAttributedString(string: "Enter a player name", attributes:[ NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.5)])
            nameTextField.text = ""
            nameTextField.attributedPlaceholder = attributedPlaceholder
        } else {
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
            let newRecord = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
//            newRecord.setValue(nameTextField.text, forKey: "label")
            newRecord.setValue("individual", forKey: "type")
            newRecord.setValue(datePicker.date, forKey: "created")
            newRecord.setValue(nameTextField.text, forKey: "title")
            
            let individualRecord = NSEntityDescription.insertNewObject(forEntityName: "IndividualRecord", into: context) as! IndividualRecord
            
            individualRecord.playerName = nameTextField.text
            
            let statSheet = NSEntityDescription.insertNewObject(forEntityName: "StatSheet", into: context) as! StatSheet
            
            statSheet.behinds = 0
            statSheet.goals = 0
            statSheet.handballs = 0
            statSheet.kicks = 0
            statSheet.marks = 0
            statSheet.tackles = 0
            
            newRecord.individualRecord = individualRecord
            
            // perform the save
            do {
                try context.save()
                dismiss(animated: true) {
                    self.delegate?.didAddStatSheet(newRecord: newRecord)
                }
            } catch let saveError{
                print("Failed to save the Statistic Sheet: \(saveError)")
            }
        }
    }
}
