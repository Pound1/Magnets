//
//  CreateMatchController.swift
//  Matchday
//
//  Created by Lachy Pound on 20/10/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import Foundation
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
//        awayTeamTextField.
    }
}

extension CreateMatchController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        return awayTeamTextField
//    }
}
