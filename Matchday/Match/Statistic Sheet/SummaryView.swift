//
//  SummaryView.swift
//  Matchday
//
//  Created by Lachy Pound on 10/10/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class SummaryView: UIView {
    
    var delegate: TeamSheetControllerDelegate?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    @IBOutlet weak var disposalCount: UILabel!
    @IBOutlet weak var kickCount: UILabel!
    @IBOutlet weak var markCount: UILabel!
    @IBOutlet weak var handballCount: UILabel!
    @IBOutlet weak var tackleCount: UILabel!
    @IBOutlet weak var goalCount: UILabel!
    @IBOutlet weak var behindCount: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    func setUpView(){
        Bundle.main.loadNibNamed("SummaryView", owner: self, options: nil)
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    //MARK:- buttons
    
    @IBAction func handleCancelButton(_ sender: Any) {
        delegate?.handleCancel()
    }
    
    @IBAction func handleSendAction(_ sender: Any) {
        print("Tapped Send...")
    }
    
}
