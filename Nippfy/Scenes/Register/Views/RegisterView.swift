//
//  LoginView.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import LBTATools
import UIKit
import CountryPickerView
import SKCountryPicker

class RegisterView: UIView {
    
    var selectedCountry: SelectedCountry = SelectedCountry() {
        didSet {
            
            guard let flag = selectedCountry.flag else { return }
            guard let name = selectedCountry.name else { return }
            guard let countryCode = selectedCountry.countryCode else { return }
            guard let dialingCode = selectedCountry.dialingCode else { return }
            
            selectCountryButton.image = flag
            dialCodeLabel.text = dialingCode
        }
    }
    
    // MARK: Scroll View and containers
    lazy var scrollView: DScrollView = {
        var scrollView = DScrollView()
        // scrollView.backgroundColor = .red
        return scrollView
    }()
    
    lazy var scrollViewContainer: DScrollViewContainer = {
        var scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 0)
        return scrollViewContainer
    }()
    
    lazy var scrollViewElement0: UIView = {
        var scrollViewElement = DScrollViewElement(height: 400)
        // scrollViewElement.backgroundColor = UIColor(named: "Background")
        return scrollViewElement
    }()
    
    lazy var bottomContainer: UIView = {
        var view = UIView()
        // view.backgroundColor = .blue
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 7
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
    
    // MARK: Elements
    
    lazy var topLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Create Account"
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var topLabel2: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Let's start by getting your account setup"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var miniView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 20
        return view
    }()
    
    // MARK: Register Button
    lazy var registerButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Register", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Buttons Background")
        bt.setTitleColor(UIColor(named: "Card Background"), for: .normal)
        return bt
    }()
    
    // MARK: ScrollView Elements
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Name *"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var nameSeparatorLine: UIView = {
        var sp = UIView()
        sp.backgroundColor = UIColor(named: "Buttons Background")
        return sp
    }()
    
    lazy var nameTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "John"
        tf.setInnerPadding()
        // tf.setIcon(UIImage(named: "mail")!)
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    lazy var surnameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Surname *"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var surnameSeparatorLine: UIView = {
        var sp = UIView()
        sp.backgroundColor = UIColor(named: "Buttons Background")
        return sp
    }()
    
    lazy var surnameTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "Gregor"
        tf.setInnerPadding()
        // tf.setIcon(UIImage(named: "password")!)
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    lazy var phoneLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Phone number and region *"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var selectCountryButton: UIImageView = {
        var button = UIImageView()
        button.image = UIImage(named: "flag")
        button.isUserInteractionEnabled = true
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var dialCodeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "+ 1"
        // label.backgroundColor = .blue
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Normal Words")
        label.textColor = .black
        return label
    }()
    
    /*
     lazy var countryPicker: CountryPickerView = {
     var picker = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
     return picker
     }()
     */
    
    lazy var phoneSeparatorLine: UIView = {
        var sp = UIView()
        sp.backgroundColor = UIColor(named: "Buttons Background")
        return sp
    }()
    
    lazy var verticalPhoneSeparatorLine: UIView = {
        var sp = UIView()
        sp.backgroundColor = .lightGray
        return sp
    }()
    
    lazy var phoneTextField: UITextField = {
        var tf = UITextField()
        // tf.placeholder = "123456789"
        tf.attributedPlaceholder = NSAttributedString(string: "123456789",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.setInnerPadding()
        tf.keyboardType = .phonePad
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    lazy var emailLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Email *"
        // label.backgroundColor = .blue
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Normal Words")
        // label.textColor = .black
        return label
    }()
    
    lazy var emailSeparatorLine: UIView = {
        var sp = UIView()
        sp.backgroundColor = UIColor(named: "Buttons Background")
        return sp
    }()
    
    lazy var emailTextField: UITextField = {
        var tf = UITextField()
        // tf.placeholder = "123456789"
        tf.placeholder = "abc@gmail.com"
        tf.setInnerPadding()
        tf.keyboardType = .emailAddress
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
    
    // MARK: SetUp
    
    func setUpUI() {
        setUpContainer()
        setUpTopElements()
        setUpButtons()
        prepareScrollView()
        prepareElementsInsideScrollView()
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
    
    fileprivate func setUpTopElements() {
        backgrounContainer.addSubviewForAutolayout(topLabel)
        
        backgrounContainer.addSubviewForAutolayout(topLabel2)
        
        backgrounContainer.addSubviewForAutolayout(miniView)
        
        topLabel.anchor(top: backgrounContainer.topAnchor, leading: backgrounContainer.leadingAnchor, bottom: nil, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 0))
        
        topLabel2.anchor(top: topLabel.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 20), size: CGSize(width: 0, height: 0))
        
        miniView.anchor(top: topLabel2.bottomAnchor, leading: backgrounContainer.leadingAnchor, bottom: nil, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
    }
    
    fileprivate func setUpButtons() {
        backgrounContainer.addSubviewForAutolayout(bottomContainer)
        
        bottomContainer.anchor(top: nil, leading: backgrounContainer.leadingAnchor, bottom: backgrounContainer.bottomAnchor, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        bottomContainer.heightAnchor.constraint(equalTo: backgrounContainer.heightAnchor, multiplier: 0.2).isActive = true
        
        bottomContainer.addSubviewForAutolayout(registerButton)
        registerButton.anchor(top: bottomContainer.topAnchor, leading: bottomContainer.leadingAnchor, bottom: bottomContainer.bottomAnchor, trailing: bottomContainer.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 0))
        
    }
}

// MARK: ScrollView
extension RegisterView {
    
    func prepareScrollView() {
        let container = UIView()
        backgrounContainer.addSubviewForAutolayout(container)
        
        container.anchor(top: topLabel2.bottomAnchor, leading: backgrounContainer.leadingAnchor, bottom: bottomContainer.topAnchor, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        addScrollView(in: container,
                      scrollView,
                      container: scrollViewContainer,
                      elements: [scrollViewElement0])
    }
    
    func prepareElementsInsideScrollView() {
        
        scrollViewElement0.addSubviewForAutolayout(nameLabel)
        scrollViewElement0.addSubviewForAutolayout(nameTextField)
        scrollViewElement0.addSubviewForAutolayout(nameSeparatorLine)
        
        nameLabel.anchor(top: scrollViewElement0.topAnchor, leading: scrollViewElement0.leadingAnchor, bottom: nil, trailing: scrollViewElement0.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 0))
        
        nameTextField.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        
        nameSeparatorLine.anchor(top: nameTextField.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        scrollViewElement0.addSubviewForAutolayout(surnameLabel)
        scrollViewElement0.addSubviewForAutolayout(surnameTextField)
        scrollViewElement0.addSubviewForAutolayout(surnameSeparatorLine)
        
        surnameLabel.anchor(top: nameSeparatorLine.topAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        surnameTextField.anchor(top: surnameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        
        surnameSeparatorLine.anchor(top: surnameTextField.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        scrollViewElement0.addSubviewForAutolayout(phoneLabel)
        scrollViewElement0.addSubviewForAutolayout(phoneTextField)
        scrollViewElement0.addSubviewForAutolayout(phoneSeparatorLine)
        
        scrollViewElement0.addSubviewForAutolayout(selectCountryButton)
        scrollViewElement0.addSubviewForAutolayout(dialCodeLabel)
        scrollViewElement0.addSubviewForAutolayout(verticalPhoneSeparatorLine)
        
        phoneLabel.anchor(top: surnameSeparatorLine.topAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        selectCountryButton.anchor(top: phoneLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 50, height: 50))
        dialCodeLabel.anchor(top: selectCountryButton.topAnchor, leading: selectCountryButton.trailingAnchor, bottom: selectCountryButton.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0), size: CGSize(width: 60, height: 0))
        verticalPhoneSeparatorLine.anchor(top: dialCodeLabel.topAnchor, leading: dialCodeLabel.trailingAnchor, bottom: dialCodeLabel.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 0), size: CGSize(width: 1, height: 0))
        
        
        
        phoneTextField.anchor(top: dialCodeLabel.topAnchor, leading: verticalPhoneSeparatorLine.trailingAnchor, bottom: dialCodeLabel.bottomAnchor, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        
        phoneSeparatorLine.anchor(top: phoneTextField.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        scrollViewElement0.addSubviewForAutolayout(emailLabel)
        scrollViewElement0.addSubviewForAutolayout(emailTextField)
        scrollViewElement0.addSubviewForAutolayout(emailSeparatorLine)
        
        emailLabel.anchor(top: phoneSeparatorLine.topAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        
        emailSeparatorLine.anchor(top: emailTextField.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
    }
    
}
