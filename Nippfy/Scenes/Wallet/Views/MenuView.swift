//
//  LoginView.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import LBTATools

class MenuView: UIView {
    
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
    
    lazy var testLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.text = "Transactions"
        label.textColor = UIColor(named: "Large Titles")
        return label
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
        addSubviewForAutolayout(menuContainer)
        menuContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        menuContainer.addSubviewForAutolayout(testLabel)
        testLabel.anchor(top: menuContainer.topAnchor, leading: menuContainer.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        // setUpBackgroundView()
    }
    
    
    
    fileprivate func calculateFontSizes() {
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
            
        case .iPhone4_4S:
            
           
            
            break
            
        case .iPhones_5_5s_5c_SE:
            
            
            
            break
            
            
        case .iPhones_6_6s_7_8:
            
           
            
            break
            
            
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            
            
            
            break
            
            
        case .iPhoneX:
            
           
            
            break
            
        case .iPhoneXR:
            
            
            break
            
        default:
            
            
            break
            
        }
    }
}
