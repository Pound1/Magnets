//
//  RecordCell.swift
//  Matchday
//
//  Created by Lachy Pound on 5/10/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    
    var record: Record? {
        didSet{
            guard let record = record else {return}
            if let title = record.title, let created = record.created {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let createdDateString = dateFormatter.string(from: created)
                textLabel?.text = title
                detailTextLabel?.text = createdDateString
            } else {
                textLabel?.text = record.title
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    func setUpCell() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        }
        detailTextLabel?.textColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
