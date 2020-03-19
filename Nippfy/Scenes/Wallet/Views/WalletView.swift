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
    
    var transactionsCollectionView: UICollectionView = {
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
        bt.setTitle("Add", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Buttons Background")
        bt.setTitleColor(UIColor(named: "Card Background"), for: .normal)
        return bt
    }()
    
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
        backgrounContainer.addSubviewForAutolayout(transactionsCollectionView)
        transactionsCollectionView.anchor(top: backgrounContainer.topAnchor, leading: backgrounContainer.leadingAnchor, bottom: backgrounContainer.bottomAnchor, trailing: backgrounContainer.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12), size: CGSize(width: 0, height: 0))
        
    }
    
    fileprivate func calculateFontSizes() {
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
            
        case .iPhone4_4S:
            
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 60)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            
            break
            
        case .iPhones_5_5s_5c_SE:
            
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 60)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            break
            
            
        case .iPhones_6_6s_7_8:
            
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 60)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            break
            
            
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 70)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 30)
            
            break
            
            
        case .iPhoneX:
            
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 70)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 30)
            
            break
            
        case .iPhoneXR:
            
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 70)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 30)
            
            break
            
        default:
            
            balanceLabel.font = UIFont.boldSystemFont(ofSize: 70)
            coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 30)
            
            break
            
        }
    }
    
    
}
