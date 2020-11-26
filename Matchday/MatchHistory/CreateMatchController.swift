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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = view.provideSecondaryBackgroundColour()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .blue
        self.hideKeyboardWhenTappedAround()
    }
}
