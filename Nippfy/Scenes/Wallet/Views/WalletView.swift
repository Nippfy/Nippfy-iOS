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
    
    lazy var cancelButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Cancel", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        bt.layer.cornerRadius = 8
        bt.backgroundColor = UIColor(named: "Card Background")
        bt.setTitleColor(UIColor(named: "Normal Words"), for: .normal)
        return bt
    }()
    
    lazy var amountTextField: UILabel = {
        var tf = UILabel()
        tf.textAlignment = .center
        tf.text = "1.00"
        tf.font = UIFont.boldSystemFont(ofSize: 40)
        tf.textColor = UIColor(named: "Small Titles")
        tf.backgroundColor = UIColor(named: "Card Background")
        return tf
    }()
    
    lazy var lessButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("-", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Sent Transaction Button")
        bt.setTitleColor(UIColor(named: "Sent Transaction Text"), for: .normal)
        return bt
    }()
    
    lazy var plusButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("+", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Received Transaction Button")
        bt.setTitleColor(UIColor(named: "Received Transaction Text"), for: .normal)
        return bt
    }()
    
    lazy var chooseAmountLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.text = "Choose or enter amount"
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var menuContainer: UIView = {
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
    
    lazy var blackView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    lazy var transactionsTopLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.text = "Transactions"
        label.textColor = UIColor(named: "Large Titles")
        return label
    }()
    
    lazy var transactionsCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "Card Background")
        return cv
    }()
    
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
    
    lazy var balanceLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "2200"
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var coinBalanceLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "$"
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var addButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Add To Wallet", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        bt.layer.cornerRadius = 8
        bt.backgroundColor = UIColor(named: "Buttons Background")
        bt.setTitleColor(UIColor(named: "Card Background"), for: .normal)
        return bt
    }()
    
    // var menuContainerHeight: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        
        setUpTopLabels()
        setUpContainer()
        
        setUpMiddleContainer()
        calculateFontSizes()
        
    }
    
    fileprivate func setUpTopLabels() {
        
        addSubviewForAutolayout(balanceLabel)
        NSLayoutConstraint.activate([
            balanceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            balanceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            // balanceLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12)
        ])
        
        addSubviewForAutolayout(coinBalanceLabel)
        coinBalanceLabel.anchor(top: balanceLabel.topAnchor, leading: balanceLabel.trailingAnchor, bottom: balanceLabel.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func setUpContainer() {
        addSubviewForAutolayout(backgrounContainer)
        backgrounContainer.anchor(top: balanceLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 0))
        
    }
    
    fileprivate func setUpMiddleContainer() {
        
        backgrounContainer.addSubviewForAutolayout(transactionsTopLabel)
        transactionsTopLabel.anchor(top: backgrounContainer.topAnchor, leading: backgrounContainer.leadingAnchor, bottom: nil, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 12), size: CGSize(width: 0, height: 0))
        
        backgrounContainer.addSubviewForAutolayout(transactionsCollectionView)
        transactionsCollectionView.anchor(top: transactionsTopLabel.bottomAnchor, leading: backgrounContainer.leadingAnchor, bottom: backgrounContainer.bottomAnchor, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12), size: CGSize(width: 0, height: 0))
        
    }
    
    fileprivate func setUpBackgroundView() {
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubviewForAutolayout(blackView)
            blackView.anchor(top: window.topAnchor, leading: window.leadingAnchor, bottom: window.bottomAnchor, trailing: window.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeMenu)))
            
            blackView.addSubviewForAutolayout(menuContainer)
            NSLayoutConstraint.activate([
                menuContainer.bottomAnchor.constraint(equalTo: blackView.bottomAnchor),
                menuContainer.leadingAnchor.constraint(equalTo: blackView.leadingAnchor),
                menuContainer.trailingAnchor.constraint(equalTo: blackView.trailingAnchor),
                menuContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
            ])
            
            menuContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(prueba)))
            
            menuContainer.alpha = 0
            
            menuContainer.addSubviewForAutolayout(chooseAmountLabel)
            NSLayoutConstraint.activate([
                chooseAmountLabel.centerXAnchor.constraint(equalTo: menuContainer.centerXAnchor),
                chooseAmountLabel.topAnchor.constraint(equalTo: menuContainer.topAnchor, constant: 24)
            ])
            
            menuContainer.addSubviewForAutolayout(amountTextField)
            NSLayoutConstraint.activate([
                amountTextField.centerXAnchor.constraint(equalTo: menuContainer.centerXAnchor),
                amountTextField.topAnchor.constraint(equalTo: chooseAmountLabel.bottomAnchor, constant: 24)
            ])
            
            menuContainer.addSubviewForAutolayout(lessButton)
            NSLayoutConstraint.activate([
                lessButton.centerYAnchor.constraint(equalTo: amountTextField.centerYAnchor),
                lessButton.leadingAnchor.constraint(equalTo: menuContainer.leadingAnchor, constant: 20)
            ])
            lessButton.withSize(CGSize(width: 60, height: 60))
            lessButton.layer.cornerRadius = 30
            
            menuContainer.addSubviewForAutolayout(plusButton)
            NSLayoutConstraint.activate([
                plusButton.centerYAnchor.constraint(equalTo: amountTextField.centerYAnchor),
                plusButton.trailingAnchor.constraint(equalTo: menuContainer.trailingAnchor, constant: -20)
            ])
            plusButton.withSize(CGSize(width: 60, height: 60))
            plusButton.layer.cornerRadius = 30
            
            NSLayoutConstraint.activate([
                amountTextField.leadingAnchor.constraint(equalTo: lessButton.trailingAnchor, constant: 12),
                amountTextField.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -12),
            ])
            
            menuContainer.addSubviewForAutolayout(addButton)
            addButton.anchor(top: amountTextField.bottomAnchor, leading: lessButton.leadingAnchor, bottom: nil, trailing: plusButton.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
            addButton.withHeight(60)
            
            menuContainer.addSubviewForAutolayout(cancelButton)
            cancelButton.anchor(top: addButton.bottomAnchor, leading: lessButton.leadingAnchor, bottom: nil, trailing: plusButton.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
            
        }
        
        
    }
    
    @objc func prueba() {
        print("PRUEBA")
    }
    
    var midHeight: CGFloat = 0
    
    func showMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            
            midHeight = window.frame.height * 0.6
            
            print("MID HEIGHT \(midHeight), \(midHeight*2)")
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            setUpBackgroundView()
            
            blackView.alpha = 0
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .transitionCrossDissolve, animations: {
                self.blackView.alpha = 1
                
                self.menuContainer.alpha = 1
                
            }, completion: nil)
            
        }
    }
    
    @objc func closeMenu() {
        UIView.animate(withDuration: 1) {
            print("CLOSING MENU")
            self.blackView.alpha = 0
            self.menuContainer.alpha = 0
            // self.menuContainer.isHidden = true
        }
    }
    
    fileprivate func calculateFontSizes() {
        let deviceType = UIDevice.current.deviceType
        
        // Small Devices
        if (deviceType == .iPhone4_4S || deviceType == .iPhones_5_5s_5c_SE || deviceType == .iPhones_6_6s_7_8) {
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 60)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            transactionsTopLabel.font = UIFont.boldSystemFont(ofSize: 16)
            
            chooseAmountLabel.font = UIFont.boldSystemFont(ofSize: 16)
            amountTextField.font = UIFont.boldSystemFont(ofSize: 40)
            lessButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 40)
            plusButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 40)
            
            plusButton.withSize(CGSize(width: 60, height: 60))
            plusButton.layer.cornerRadius = 30
            lessButton.withSize(CGSize(width: 60, height: 60))
            lessButton.layer.cornerRadius = 30
            
            addButton.withHeight(60)
            addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        // Large Devices
        else {
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 70)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 30)
            
            transactionsTopLabel.font = UIFont.boldSystemFont(ofSize: 22)
            
            chooseAmountLabel.font = UIFont.boldSystemFont(ofSize: 18)
            amountTextField.font = UIFont.boldSystemFont(ofSize: 50)
            lessButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 50)
            plusButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 50)
            
            plusButton.withSize(CGSize(width: 100, height: 100))
            plusButton.layer.cornerRadius = 50
            lessButton.withSize(CGSize(width: 100, height: 100))
            lessButton.layer.cornerRadius = 50
            
            addButton.withHeight(70)
            addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            
        }
    }
}


// MARK: View Methods
extension WalletView {
    
    func increaseTipAmount() {
        guard let amount = amountTextField.text else { return }
        
        if let floatValue = Float(amount) {
            let increasedAmount = floatValue + 1
            amountTextField.text = String(format: "%.2f", increasedAmount)
        }
    }
    
    func decreaseTipAmount() {
        guard let amount = amountTextField.text else { return }
        
        if let floatValue = Float(amount) {
            let decreasedAmount = floatValue - 1
            
            if (decreasedAmount <= 1) {
                amountTextField.text = "1.00"
            } else {
                amountTextField.text = String(format: "%.2f", decreasedAmount)
            }
        }
    }
    
}
