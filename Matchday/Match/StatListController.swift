//
//  StatisticSheet.swift
//  Matchday
//
//  Created by Lachy Pound on 12/9/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

protocol StatListControllerDelegate {
    func didAddStatSheet(newRecord: Record)
}

class StatListController: UITableViewController, StatListControllerDelegate {
    
    //MARK:- declarations for statistic sheets
    var records = [Record]()
    var masterRecordList = [Record]()
    let cellID = "cellID"
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All", "Team", "Individual"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(handleFilter), for: .valueChanged)
        return control
    }()
    
    //MARK:- fetch service
    
    private func fetchStatSheets(){
        let context = CoreDataManager.shared.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Record>(entityName: "Record")
        do {
            let records = try context.fetch(fetchRequest)
    
            self.masterRecordList = records
            self.masterRecordList.sort{$0.created!.compare($1.created!) == .orderedDescending}
            self.tableView.reloadData()
            
        } catch let fetchError {
            print("Failed to fetch Stat List: \(fetchError)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        handleFilter() // also does fetch call for data
        tableView.register(RecordCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setUpView(){
        navigationItem.title = "Stat Sheets"
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        }
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddSheetHandler))
        
    }
    
        //MARK:- tableView functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecordCell
        cell.record = records[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
        
    @objc private func AddSheetHandler() {
        let createStatSheetController = CreateStatSheetController()
        createStatSheetController.delegate = self
        let navController = UINavigationController(rootViewController: createStatSheetController)
        present(navController, animated: true, completion: nil)
    }
    
    // func to delete a record
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let record = records[indexPath.row]
        records.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        context.delete(record)
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save with error: \(saveErr)")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // display statistic sheet based on type
        let givenRecord = records[indexPath.row]
        if givenRecord.type == "individual" {
            let statisticController = StatisticSheetController()
            statisticController.record = givenRecord
            navigationController?.pushViewController(statisticController, animated: true)
        } else {
            print("accessing Team record")
            let teamSheetController = TeamStatisticSheetController()
            teamSheetController.record = givenRecord
            navigationController?.pushViewController(teamSheetController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = FooterView()
        footer.adjustFooterText(title: "No Stats available.", subText: "Add a Stat Sheet by tapping the + button")
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return records.isEmpty == true ? 150 : 0
    }
    //MARK: Private functions.
    @objc private func handleFilter(){
        fetchStatSheets()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("\(segmentedControl.selectedSegmentIndex) selected")
            records = masterRecordList
            tableView.reloadData()
        case 1:
            print("\(segmentedControl.selectedSegmentIndex) selected")
            records = masterRecordList.filter {$0.type == "team"}
            tableView.reloadData()
        case 2:
            print("\(segmentedControl.selectedSegmentIndex) selected")
            records = masterRecordList.filter {$0.type == "individual"}
            tableView.reloadData()
        default:
            print("default selected")
        }
    }
    
    //MARK:- delegate methods
    func didAddStatSheet(newRecord: Record) {
        
        // append to the array
        records.append(newRecord)
        
        // insert new index path
        let newIndexPath = IndexPath(row: records.count-1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
}
