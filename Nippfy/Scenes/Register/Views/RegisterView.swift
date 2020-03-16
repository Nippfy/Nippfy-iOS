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

class RegisterView: UIView {
    
    // MARK: Scroll View
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
        var scrollViewElement = DScrollViewElement(height: 600)
        scrollViewElement.backgroundColor = .red
        return scrollViewElement
    }()
    
    lazy var bottomContainer: UIView = {
        var view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
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
        label.text = "Create Account"
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var registerButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Register", for: .normal)
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
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.setIcon(UIImage(named: "mail")!)
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    lazy var passwordSeparatorLine: UIView = {
        var sp = UIView()
        sp.backgroundColor = UIColor(named: "Buttons Background")
        return sp
    }()
    
    lazy var passwordTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.setIcon(UIImage(named: "password")!)
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
        setUpTopElements()
        setUpButtons()
        prepareScrollView()
        // setUpScrollView()
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
    
    fileprivate func setUpScrollView() {
        
    }
    
    fileprivate func setUpTopElements() {
        backgrounContainer.addSubviewForAutolayout(topLabel)
        
        topLabel.anchor(top: backgrounContainer.topAnchor, leading: backgrounContainer.leadingAnchor, bottom: nil, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 75))
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
        
        container.anchor(top: topLabel.bottomAnchor, leading: backgrounContainer.leadingAnchor, bottom: bottomContainer.topAnchor, trailing: backgrounContainer.trailingAnchor)
        
        addScrollView(in: container,
                      scrollView,
                      container: scrollViewContainer,
                      elements: [scrollViewElement0])
    }
}
