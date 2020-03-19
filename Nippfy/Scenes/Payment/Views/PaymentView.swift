//
//  LoginView.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import LBTATools

class PaymentView: UIView {
    
    lazy var backgrounContainer: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "Card Background")
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        return view
    }()
    
    lazy var bottomContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "Label Background")
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var bottomContainerViewLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.text = "Bank fee (2.5) will be applied"
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let infoButton = UIButton(type: .infoLight)
        infoButton.tintColor = UIColor(named: "Small Titles")
        infoButton.backgroundColor = UIColor(named: "Normal Words")
        infoButton.layer.cornerRadius = 10
        return infoButton
    }()
    
    lazy var receiverNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Francis Hardy"
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 1)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var receiverPhoneNumber: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "097-396-1390"
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 1)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
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
    
    lazy var tipAmountTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "47.5"
        tf.text = "47.5"
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 100)
        tf.textColor = UIColor(named: "Small Titles")
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    lazy var conceptTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "47.5"
        tf.textAlignment = .center
        tf.text = "Dinner 🍤😋"
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.textColor = UIColor(named: "Small Titles")
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    lazy var concept2TextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "47.5"
        tf.text = "Dinner 🍤😋"
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.textColor = UIColor(named: "Small Titles")
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    lazy var receiverImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "prueba"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        setUpSendButton()
        setUpContainer()
        setUpMiddleContainer()
        calculateFontSizes()
        setUpManualViews()
        
    }
    
    fileprivate func setUpContainer() {
        addSubviewForAutolayout(backgrounContainer)
        backgrounContainer.anchor(top: safeAreaLayoutGuide.topAnchor, leading: sendButton.leadingAnchor, bottom: sendButton.topAnchor, trailing: sendButton.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0), size: CGSize(width: 0, height: 0))
        
    }
    
    fileprivate func setUpSendButton() {
        addSubviewForAutolayout(sendButton)
        sendButton.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 50))
    }
    
    fileprivate func setUpManualViews() {
        
        let myView = UIView()
        // myView.backgroundColor = .blue
        
        backgrounContainer.addSubviewForAutolayout(myView)
        myView.anchor(top: backgrounContainer.topAnchor, leading: backgrounContainer.leadingAnchor, bottom: bottomContainerView.topAnchor, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12), size: CGSize(width: 0, height: 0))
        
        myView.addSubviewForAutolayout(receiverImageView)
        receiverImageView.anchor(top: myView.topAnchor, leading: myView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        myView.addSubviewForAutolayout(receiverNameLabel)
        receiverNameLabel.anchor(top: receiverImageView.topAnchor, leading: receiverImageView.trailingAnchor, bottom: nil, trailing: myView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        myView.addSubviewForAutolayout(receiverPhoneNumber)
        receiverPhoneNumber.anchor(top: receiverNameLabel.bottomAnchor, leading: receiverNameLabel.leadingAnchor, bottom: nil, trailing: receiverNameLabel.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        myView.addSubviewForAutolayout(tipAmountTextField)
        NSLayoutConstraint.activate([
            tipAmountTextField.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            tipAmountTextField.topAnchor.constraint(equalTo: receiverImageView.bottomAnchor, constant: 0),
            tipAmountTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor),
            tipAmountTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor)
        ])
        
        myView.addSubviewForAutolayout(conceptTextField)
        NSLayoutConstraint.activate([
            (conceptTextField).centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            (conceptTextField).topAnchor.constraint(equalTo: tipAmountTextField.bottomAnchor, constant: 10),
            (conceptTextField).leadingAnchor.constraint(equalTo: myView.leadingAnchor),
            (conceptTextField).trailingAnchor.constraint(equalTo: myView.trailingAnchor),
        ])
    }
    
    
    fileprivate func setUpMiddleContainer() {
        
        backgrounContainer.addSubviewForAutolayout(bottomContainerView)
        bottomContainerView.anchor(top: nil, leading: backgrounContainer.leadingAnchor, bottom: backgrounContainer.bottomAnchor, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 0))
        
        bottomContainerView.addSubviewForAutolayout(infoButton)
        
        NSLayoutConstraint.activate([
            infoButton.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor),
            infoButton.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 20),
            infoButton.heightAnchor.constraint(equalToConstant: 20),
            infoButton.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        bottomContainerView.addSubviewForAutolayout(bottomContainerViewLabel)
        
        NSLayoutConstraint.activate([
            bottomContainerViewLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor),
            bottomContainerViewLabel.leadingAnchor.constraint(equalTo: infoButton.trailingAnchor, constant: 12),
            bottomContainerViewLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor)
        ])
        
        bottomContainerView.heightAnchor.constraint(equalTo: bottomContainerViewLabel.heightAnchor, constant: 30).isActive = true
        
    }
    
    fileprivate func calculateFontSizes() {
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
            
        case .iPhone4_4S:
            receiverImageView.withSize(CGSize(width: 60, height: 60))
            receiverImageView.layer.cornerRadius = 30
            
            receiverNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            receiverPhoneNumber.font = UIFont.boldSystemFont(ofSize: 12)
            
            tipAmountTextField.font = UIFont.boldSystemFont(ofSize: 100)
            conceptTextField.font = UIFont.boldSystemFont(ofSize: 20)
            
            bottomContainerViewLabel.font = UIFont.systemFont(ofSize: 12)
            break
            
        case .iPhones_5_5s_5c_SE:
            receiverImageView.withSize(CGSize(width: 60, height: 60))
            receiverImageView.layer.cornerRadius = 30
            
            receiverNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            receiverPhoneNumber.font = UIFont.boldSystemFont(ofSize: 14)
            
            tipAmountTextField.font = UIFont.boldSystemFont(ofSize: 100)
            conceptTextField.font = UIFont.boldSystemFont(ofSize: 20)
            
            bottomContainerViewLabel.font = UIFont.systemFont(ofSize: 12)
            
            break
            
            
        case .iPhones_6_6s_7_8:
            receiverImageView.withSize(CGSize(width: 100, height: 100))
            receiverImageView.layer.cornerRadius = 50
            
            receiverNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
            receiverPhoneNumber.font = UIFont.boldSystemFont(ofSize: 20)
            
            tipAmountTextField.font = UIFont.boldSystemFont(ofSize: 120)
            conceptTextField.font = UIFont.boldSystemFont(ofSize: 30)
            
            bottomContainerViewLabel.font = UIFont.systemFont(ofSize: 16)
            break
            
            
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            receiverImageView.withSize(CGSize(width: 100, height: 100))
            receiverImageView.layer.cornerRadius = 50
            
            receiverNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
            receiverPhoneNumber.font = UIFont.boldSystemFont(ofSize: 20)
            
            tipAmountTextField.font = UIFont.boldSystemFont(ofSize: 120)
            conceptTextField.font = UIFont.boldSystemFont(ofSize: 30)
            
            bottomContainerViewLabel.font = UIFont.systemFont(ofSize: 16)
            break
            
            
        case .iPhoneX:
            receiverImageView.withSize(CGSize(width: 100, height: 100))
            receiverImageView.layer.cornerRadius = 50
            
            receiverNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
            receiverPhoneNumber.font = UIFont.boldSystemFont(ofSize: 20)
            
            tipAmountTextField.font = UIFont.boldSystemFont(ofSize: 120)
            conceptTextField.font = UIFont.boldSystemFont(ofSize: 30)
            
            bottomContainerViewLabel.font = UIFont.systemFont(ofSize: 16)
            break
            
        case .iPhoneXR:
            receiverImageView.withSize(CGSize(width: 100, height: 100))
            receiverImageView.layer.cornerRadius = 50
            
            receiverNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
            receiverPhoneNumber.font = UIFont.boldSystemFont(ofSize: 20)
            
            tipAmountTextField.font = UIFont.boldSystemFont(ofSize: 120)
            conceptTextField.font = UIFont.boldSystemFont(ofSize: 30)
            
            bottomContainerViewLabel.font = UIFont.systemFont(ofSize: 16)
            break
            
        default:
            receiverImageView.withSize(CGSize(width: 100, height: 100))
            receiverImageView.layer.cornerRadius = 50
            
            receiverNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
            receiverPhoneNumber.font = UIFont.boldSystemFont(ofSize: 20)
            
            tipAmountTextField.font = UIFont.boldSystemFont(ofSize: 120)
            conceptTextField.font = UIFont.boldSystemFont(ofSize: 30)
            
            bottomContainerViewLabel.font = UIFont.systemFont(ofSize: 16)
            break
            
        }
    }
    
    
}
