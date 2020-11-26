//
//  SettingsViewController.swift
//  Matchday
//
//  Created by Lachy Pound on 27/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    let cellID = "CellID"
    let settingsList = [["Club name": "Glen Eira"], ["Number of quarters": "4", "Length of quarters": "25 min"], ["Players on field": "18", "Players on bench": "4"], ]
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    private func setUpSettingsCell(){
        navigationItem.title = "Settings"
        tableView.backgroundColor = .blue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingsList.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellID)
        let indexArray = settingsList[indexPath.section]
        var counter = 0
        for element in indexArray {
            if counter == indexPath.row {
                cell.textLabel?.text = element.key
                cell.detailTextLabel?.text = element.value
            }
            counter += 1
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editSettingController = EditSettingController()
        let dict = findElementAtIndex(index: indexPath)
        var titleText = String()
        var titleValue = String()
        for (key, value) in dict {
            titleText = key
            titleValue = value
        }
        editSettingController.navigationItem.title = titleText
        editSettingController.settingsEntryField.text = titleValue
        navigationController?.pushViewController(editSettingController, animated: true)
    }
    func findElementAtIndex(index: IndexPath) -> [String: String] {
        let indexArray = settingsList[index.section]
        var counter = 0
        for element in indexArray {
            if counter == index.row {
                let dictionary: Dictionary = ["\(element.key)":"\(element.value)"]
                return dictionary
            }
            counter += 1
        }
        return ["":""]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return " "
        case 1:
            return "Quarter defaults"
        case 2:
            return "Field defaults"
        default:
            return ""
        }
    }
}

