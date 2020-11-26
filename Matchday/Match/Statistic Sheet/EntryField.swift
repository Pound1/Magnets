//
//  EntryField.swift
//  Matchday
//
//  Created by Lachy Pound on 22/5/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class EntryField: UIView {
    //MARK: properties
    
    var title: String
    var placeholder: String
    
    //MARK: Initialisation
    init(frame: CGRect, title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
