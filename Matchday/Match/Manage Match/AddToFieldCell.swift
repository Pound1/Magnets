//
//  AddToFieldCell.swift
//  Matchday
//
//  Created by Lachy Pound on 14/11/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class AddToFieldCell: UICollectionViewCell {
    
    var delegate: ManageFieldControllerDelegate?
    var title = "Add player(s)" //this defines the button action. Do not adjust - re-think your proposed text.
    var position: PositionOnField? {
        didSet {
            //            print("Set position to \(String(describing: position))") //WHY-> does this get called twice?
            guard let titleString = position?.rawValue else {return}
            title = "Add to " + titleString // WHY-> does this not change the title?
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
//        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle(title, for: .normal)
//        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 14)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        if #available(iOS 13.0, *) {
            button.setTitleColor(.link, for: .normal)
        } else {
            button.setTitleColor(UIColor.PaletteColour.SelectionTones.hyperlinkBlue, for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(handleAddToFieldButton), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Required initialiser methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
        }
        addSubview(addButton)
        addSubview(titleLabel)
        addSubview(bottomLine)
        let screenWidth = frame.width-4
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            titleLabel.widthAnchor.constraint(equalToConstant: screenWidth/3),

            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            addButton.widthAnchor.constraint(equalToConstant: screenWidth/3),
            
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    @objc func handleAddToFieldButton() {
        guard let position = position else {return}
        print("Tapped button \(position)")
        delegate?.addPlayersToPosition(selectedPosition: position)
    }
    
    func animateAddButton(startAlpha: Int, endAlpha: Int, startPos: Int, endPos: Int) {
        self.addButton.transform = CGAffineTransform(translationX: 0, y: CGFloat(startPos))
        self.addButton.alpha = CGFloat(startAlpha)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.addButton.transform = CGAffineTransform(translationX: 0, y: CGFloat(endPos))
            self.addButton.alpha = CGFloat(endAlpha)
        })
    }
}
