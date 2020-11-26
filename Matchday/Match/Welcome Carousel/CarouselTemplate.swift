//
//  CarouselTemplate.swift
//  Matchday
//
//  Created by Lachy Pound on 2/12/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class CarouselTemplate: UIViewController {

    override func viewDidLoad() {
        setUpCarouselElements()
    }
    
    //MARK:- Declarations
    var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "AFLBoardmanIcon200pt")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var safeSpace: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleText: UILabel = {
        let text = UILabel()
        text.text = "AFL Boardman"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 22)
        return text
    }()

    var subText: UITextView = {
        let text = UITextView()
        text.textColor = .systemGray
        text.text = "The app designed to digitise your playing field. \n\n\nGreat for Amateur clubs to track field movements, monitor player possessions and get insight into your team's performance."
        text.font = UIFont.systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.backgroundColor = .none
        text.isEditable = false
        return text
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start now", for: .normal)
        if #available(iOS 13.0, *) {
            button.setTitleColor(.systemBlue, for: .normal)
        } else {
            button.setTitleColor(.blue, for: .normal)
        }
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()

    func  setUpCarouselElements() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        view.addSubview(safeSpace)
        view.addSubview(imageView)
        view.addSubview(titleText)
        view.addSubview(subText)
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            
            safeSpace.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            safeSpace.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            safeSpace.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            safeSpace.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            
            imageView.centerXAnchor.constraint(equalTo: safeSpace.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleText.topAnchor, constant: -32),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleText.centerXAnchor.constraint(equalTo: safeSpace.centerXAnchor),
            titleText.centerYAnchor.constraint(equalTo: safeSpace.centerYAnchor),
            
            subText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 12),
            subText.leadingAnchor.constraint(equalTo: safeSpace.leadingAnchor),
            subText.trailingAnchor.constraint(equalTo: safeSpace.trailingAnchor),
            subText.heightAnchor.constraint(equalToConstant: 200),
            
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: safeSpace.bottomAnchor),

            ])
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
