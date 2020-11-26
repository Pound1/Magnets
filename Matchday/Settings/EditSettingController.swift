//
//  EditSettingController.swift
//  Matchday
//
//  Created by Lachy Pound on 19/10/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import Foundation
import UIKit

class EditSettingController: UIViewController {
    
    enum keyboardType {
        case string, numeric
    }
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = view.provideBackgroundColour()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let settingsEntryField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .always
        textField.text = "Enter new setting"
        textField.backgroundColor = textField.provideBackgroundColour()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpView()
    }
    func setUpNavBar() {
        
    }
    func setUpView() {
        view.backgroundColor = view.provideSecondaryBackgroundColour()
        view.addSubview(backgroundView)
        view.addSubview(settingsEntryField)
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        settingsEntryField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        settingsEntryField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        settingsEntryField.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        settingsEntryField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func provideKeyboard() {
//        var value = Int(settingsEntryField.text)
//        if value != nil {
//            // do numeric keyboard
//        } else {
//            // do default keyboard
//        }
    }
}
