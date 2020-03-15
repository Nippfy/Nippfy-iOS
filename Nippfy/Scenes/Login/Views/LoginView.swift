//
//  LoginView.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import LBTATools

class LoginView: UIView {
    
    // The 5s iPhone has a height of 568
    private var backgroundHeight: CGFloat = 400
    
    lazy var middleContainer: UIView = {
        var view = UIView()
        // view.backgroundColor = .purple
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
        label.text = "Welcome"
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var createAccountButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Register", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Buttons Background")
        bt.setTitleColor(UIColor(named: "Card Background"), for: .normal)
        return bt
    }()
    
    lazy var signInButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Sign in", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.layer.cornerRadius = 16
        bt.layer.borderColor = UIColor(named: "Buttons Background")?.cgColor
        bt.layer.borderWidth = 1
        bt.backgroundColor = UIColor(named: "Card Background")
        bt.setTitleColor(UIColor(named: "Buttons Background"), for: .normal)
        return bt
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Forgot Password?", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        // bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Card Background")
        bt.setTitleColor(UIColor(named: "Normal Words"), for: .normal)
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
        setUpMiddleContainer()
        // setUpTopElements()
        // setUpButtons()
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
        
        backgrounContainer.addSubviewForAutolayout(middleContainer)
        NSLayoutConstraint.activate([
            // middleContainer.centerYAnchor.constraint(equalTo: backgrounContainer.centerYAnchor, constant: -30),
            middleContainer.centerXAnchor.constraint(equalTo: backgrounContainer.centerXAnchor),
            middleContainer.leadingAnchor.constraint(equalTo: backgrounContainer.leadingAnchor),
            middleContainer.trailingAnchor.constraint(equalTo: backgrounContainer.trailingAnchor),
            middleContainer.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            middleContainer.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        middleContainer.addSubviewForAutolayout(emailTextField)
        middleContainer.addSubviewForAutolayout(emailSeparatorLine)
        middleContainer.addSubviewForAutolayout(passwordTextField)
        middleContainer.addSubviewForAutolayout(passwordSeparatorLine)
        
        emailTextField.anchor(top: middleContainer.topAnchor, leading: middleContainer.leadingAnchor, bottom: nil, trailing: middleContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 70))
        
        emailSeparatorLine.anchor(top: emailTextField.bottomAnchor, leading: emailTextField.leadingAnchor, bottom: nil, trailing: emailTextField.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        passwordTextField.anchor(top: emailSeparatorLine.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 70))
        
        passwordSeparatorLine.anchor(top: passwordTextField.bottomAnchor, leading: passwordTextField.leadingAnchor, bottom: nil, trailing: passwordTextField.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        backgrounContainer.addSubviewForAutolayout(bottomView)
        bottomView.anchor(top: middleContainer.bottomAnchor, leading: middleContainer.leadingAnchor, bottom: backgrounContainer.bottomAnchor, trailing: middleContainer.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 0))
        
        bottomView.addSubviewForAutolayout(signInButton)
        bottomView.addSubviewForAutolayout(forgotPasswordButton)
        bottomView.addSubviewForAutolayout(createAccountButton)
        
        signInButton.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, bottom: nil, trailing: bottomView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        signInButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.35).isActive = true
        
        forgotPasswordButton.anchor(top: signInButton.bottomAnchor, leading: signInButton.leadingAnchor, bottom: nil, trailing: signInButton.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 30))
        
        createAccountButton.anchor(top: forgotPasswordButton.bottomAnchor, leading: signInButton.leadingAnchor, bottom: nil, trailing: signInButton.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        createAccountButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.35).isActive = true
    }
    
    fileprivate func setUpTopElements() {
        
        backgrounContainer.addSubviewForAutolayout(topLabel)
        backgrounContainer.addSubviewForAutolayout(emailTextField)
        backgrounContainer.addSubviewForAutolayout(emailSeparatorLine)
        backgrounContainer.addSubviewForAutolayout(passwordTextField)
        backgrounContainer.addSubviewForAutolayout(passwordSeparatorLine)
        
        topLabel.anchor(top: backgrounContainer.topAnchor, leading: backgrounContainer.leadingAnchor, bottom: nil, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 50))
        
        emailTextField.anchor(top: topLabel.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        emailSeparatorLine.anchor(top: emailTextField.bottomAnchor, leading: emailTextField.leadingAnchor, bottom: nil, trailing: emailTextField.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        passwordTextField.anchor(top: emailSeparatorLine.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        
        passwordSeparatorLine.anchor(top: passwordTextField.bottomAnchor, leading: passwordTextField.leadingAnchor, bottom: nil, trailing: passwordTextField.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
    }
    
    fileprivate func setUpButtons() {
        
        backgrounContainer.addSubviewForAutolayout(bottomView)
        bottomView.anchor(top: passwordSeparatorLine.bottomAnchor, leading: topLabel.leadingAnchor, bottom: backgrounContainer.bottomAnchor, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0), size: CGSize(width: 0, height: 0))
        
        
        backgrounContainer.addSubviewForAutolayout(signInButton)
        signInButton.anchor(top: passwordTextField.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        signInButton.heightAnchor.constraint(equalTo: backgrounContainer.heightAnchor, multiplier: 0.15).isActive = true
        
        backgrounContainer.addSubviewForAutolayout(forgotPasswordButton)
        forgotPasswordButton.anchor(top: signInButton.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 30))
        
        backgrounContainer.addSubviewForAutolayout(createAccountButton)
        createAccountButton.anchor(top: forgotPasswordButton.bottomAnchor, leading: topLabel.leadingAnchor, bottom: nil, trailing: topLabel.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        createAccountButton.heightAnchor.constraint(equalTo: backgrounContainer.heightAnchor, multiplier: 0.15).isActive = true
        
    }
}
