//
//  LoginView.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import LBTATools

class WalletView: UIView {
    
    // The 5s iPhone has a height of 568
    private var backgroundHeight: CGFloat = 400
    
    lazy var middleContainer: UIView = {
        var view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    lazy var topView: UIView = {
        var view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    lazy var bottomView: UIView = {
        var view = UIView()
        return view
    }()
    
    lazy var backgrounContainer: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "Card Background")
        // view.backgroundColor = .blue
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var topLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Forgotten Password?"
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var topLabel2: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Enter the email address associated with your account"
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 1)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var topLabel3: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "We will email you a link to reset your password"
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 1)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var sendButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Send", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Buttons Background")
        bt.setTitleColor(UIColor(named: "Card Background"), for: .normal)
        return bt
    }()
    
    lazy var emailSeparatorLine: UIView = {
        var sp = UIView()
        sp.backgroundColor = UIColor(named: "Buttons Background")
        return sp
    }()
    
    lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "Enter Email Address"
        tf.keyboardType = .emailAddress
        tf.setIcon(UIImage(named: "mail")!)
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        setUpContainer()
        setUpMiddleContainer()
    }
    
    fileprivate func setUpContainer() {
        addSubviewForAutolayout(backgrounContainer)
        NSLayoutConstraint.activate([
            backgrounContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgrounContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgrounContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            // backgrounContainer.heightAnchor.constraint(equalToConstant: backgroundHeight),
            backgrounContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
        
    }
    
    fileprivate func setUpMiddleContainer() {
        
        backgrounContainer.addSubviewForAutolayout(topLabel)
        topLabel.anchor(top: backgrounContainer.topAnchor, leading: backgrounContainer.leadingAnchor, bottom: nil, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 75))
        
        backgrounContainer.addSubviewForAutolayout(topLabel2)
        topLabel2.anchor(top: topLabel.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        backgrounContainer.addSubviewForAutolayout(topLabel3)
        topLabel3.anchor(top: topLabel2.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 0))
        
        backgrounContainer.addSubviewForAutolayout(emailTextField)
        backgrounContainer.addSubviewForAutolayout(emailSeparatorLine)
        
        emailTextField.anchor(top: topLabel3.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 70))
        
        emailSeparatorLine.anchor(top: emailTextField.bottomAnchor, leading: emailTextField.leadingAnchor, bottom: nil, trailing: emailTextField.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        backgrounContainer.addSubviewForAutolayout(sendButton)
        sendButton.anchor(top: emailSeparatorLine.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 70))
    
    }
}
