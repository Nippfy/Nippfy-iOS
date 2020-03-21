//
//  LoginView.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import LBTATools

class SearchView: UIView {
    
    // MARK: Constants
    var scrollViewHeight: NSLayoutConstraint?
    let spaceBetweenButtons: CGFloat = 30
    let buttonSize: CGFloat = 60
    let scrollViewHeightConstant: CGFloat = 90
    
    var isScrollViewHidden: Bool? = true {
        didSet {
            if (isScrollViewHidden == true) {
                showScrollView()
            } else {
                hideScrollView()
            }
        }
    }
    
    // MARK: Scroll View and containers
    lazy var scrollView: DScrollView = {
        var scrollView = DScrollView()
        // scrollView.backgroundColor = .red
        return scrollView
    }()
    
    lazy var scrollViewContainer: DScrollViewContainer = {
        var scrollViewContainer = DScrollViewContainer(axis: .horizontal, spacing: 20)
        return scrollViewContainer
    }()
    
    lazy var scrollViewElement0: UIView = {
        var scrollViewElement = DScrollViewElement(width: 380)
        // scrollViewElement.backgroundColor = .yellow
        return scrollViewElement
    }()
    
    lazy var scrollViewContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "Card Background")
        return view
    }()
    
    lazy var filterButton1: UIButton = {
        var bt = UIButton()
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Received Transaction Button")
        let image = UIImage(named: "foodx32")?.withRenderingMode(.alwaysTemplate)
        let normalImage = image?.maskWithColor(color: UIColor(named: "Received Transaction Text")!)
        let selectedImage = image?.maskWithColor(color: UIColor(named: "Received Transaction Button")!)
        bt.clipsToBounds = true
        bt.setImage(normalImage, for: .normal)
        bt.setImage(selectedImage, for: .highlighted)
        return bt
    }()
    
    lazy var filterButton1Label: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.text = "Food"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var filterButton2: UIButton = {
        var bt = UIButton()
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Received Transaction Button")
        let image = UIImage(named: "forkx32")?.withRenderingMode(.alwaysTemplate)
        let normalImage = image?.maskWithColor(color: UIColor(named: "Received Transaction Text")!)
        let selectedImage = image?.maskWithColor(color: UIColor(named: "Received Transaction Button")!)
        bt.clipsToBounds = true
        bt.setImage(normalImage, for: .normal)
        bt.setImage(selectedImage, for: .highlighted)
        return bt
    }()
    
    lazy var filterButton2Label: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.text = "Restaurant"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var filterButton3: UIButton = {
        var bt = UIButton()
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Received Transaction Button")
        let image = UIImage(named: "waiterx32")?.withRenderingMode(.alwaysTemplate)
        let normalImage = image?.maskWithColor(color: UIColor(named: "Received Transaction Text")!)
        let selectedImage = image?.maskWithColor(color: UIColor(named: "Received Transaction Button")!)
        bt.clipsToBounds = true
        bt.setImage(normalImage, for: .normal)
        bt.setImage(selectedImage, for: .highlighted)
        return bt
    }()
    
    lazy var filterButton3Label: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.text = "Waiter"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var filterButton4: UIButton = {
        var bt = UIButton()
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(named: "Received Transaction Button")
        let image = UIImage(named: "waiterx32")?.withRenderingMode(.alwaysTemplate)
        let normalImage = image?.maskWithColor(color: UIColor(named: "Received Transaction Text")!)
        let selectedImage = image?.maskWithColor(color: UIColor(named: "Received Transaction Button")!)
        bt.clipsToBounds = true
        bt.setImage(normalImage, for: .normal)
        bt.setImage(selectedImage, for: .highlighted)
        return bt
    }()
    
    lazy var filterButton4Label: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.text = "Waiter"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    // MARK: Collection View
    lazy var collectionViewContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "Card Background")
        return cv
    }()
    
    // MARK: Search Bar
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.setImage(UIImage(named: "sliderx24"), for: .bookmark, state: .normal)
        
        searchBar.showsBookmarkButton = true
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    lazy var backgroundContainer: UIView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set Up UI
    func setUpUI() {
        
        setUpBackgroundContainer()
        setUpSearchBar()
        setUpScrollView()
        setUpScrollViewElements()
        setUpCollectionView()
    }
    
    fileprivate func setUpCollectionView() {
        backgroundContainer.addSubviewForAutolayout(collectionViewContainerView)
        collectionViewContainerView.anchor(top: scrollViewContainerView.bottomAnchor, leading: scrollViewContainerView.leadingAnchor, bottom: backgroundContainer.bottomAnchor, trailing: scrollViewContainerView.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0), size: CGSize(width: 0, height: 0))
        
    }
    
    fileprivate func setUpScrollView() {
        backgroundContainer.addSubviewForAutolayout(scrollViewContainerView)
        scrollViewContainerView.anchor(top: searchBar.bottomAnchor, leading: searchBar.leadingAnchor, bottom: nil, trailing: searchBar.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        scrollViewHeight = scrollViewContainerView.heightAnchor.constraint(equalToConstant: scrollViewHeightConstant)
        scrollViewHeight?.isActive = true
        
        addScrollView(in: scrollViewContainerView,
                      scrollView,
                      container: scrollViewContainer,
                      elements: [scrollViewElement0])
    }
    
    fileprivate func setUpScrollViewElements() {
        scrollViewElement0.addSubviewForAutolayout(filterButton1)
        NSLayoutConstraint.activate([
            filterButton1.centerYAnchor.constraint(equalTo: scrollViewElement0.centerYAnchor, constant: -6),
            filterButton1.leadingAnchor.constraint(equalTo: scrollViewElement0.leadingAnchor, constant: 10)
        ])
        filterButton1.withSize(CGSize(width: buttonSize, height: buttonSize))
        
        scrollViewElement0.addSubviewForAutolayout(filterButton1Label)
        NSLayoutConstraint.activate([
            filterButton1Label.centerXAnchor.constraint(equalTo: filterButton1.centerXAnchor),
            filterButton1Label.topAnchor.constraint(equalTo: filterButton1.bottomAnchor, constant: 0),
        ])
        
        scrollViewElement0.addSubviewForAutolayout(filterButton2)
        NSLayoutConstraint.activate([
            filterButton2.centerYAnchor.constraint(equalTo: filterButton1.centerYAnchor),
            filterButton2.leadingAnchor.constraint(equalTo: filterButton1.trailingAnchor, constant: spaceBetweenButtons)
        ])
        filterButton2.withSize(CGSize(width: buttonSize, height: buttonSize))
        
        scrollViewElement0.addSubviewForAutolayout(filterButton2Label)
        NSLayoutConstraint.activate([
            filterButton2Label.centerXAnchor.constraint(equalTo: filterButton2.centerXAnchor),
            filterButton2Label.topAnchor.constraint(equalTo: filterButton2.bottomAnchor, constant: 0)
        ])
        
        scrollViewElement0.addSubviewForAutolayout(filterButton3)
        NSLayoutConstraint.activate([
            filterButton3.centerYAnchor.constraint(equalTo: filterButton2.centerYAnchor),
            filterButton3.leadingAnchor.constraint(equalTo: filterButton2.trailingAnchor, constant: spaceBetweenButtons)
        ])
        filterButton3.withSize(CGSize(width: buttonSize, height: buttonSize))
        
        scrollViewElement0.addSubviewForAutolayout(filterButton3Label)
        NSLayoutConstraint.activate([
            filterButton3Label.centerXAnchor.constraint(equalTo: filterButton3.centerXAnchor),
            filterButton3Label.topAnchor.constraint(equalTo: filterButton3.bottomAnchor, constant: 0)
        ])
        
        scrollViewElement0.addSubviewForAutolayout(filterButton4)
        NSLayoutConstraint.activate([
            filterButton4.centerYAnchor.constraint(equalTo: filterButton3.centerYAnchor),
            filterButton4.leadingAnchor.constraint(equalTo: filterButton3.trailingAnchor, constant: spaceBetweenButtons)
        ])
        filterButton4.withSize(CGSize(width: buttonSize, height: buttonSize))
        
        scrollViewElement0.addSubviewForAutolayout(filterButton4Label)
        NSLayoutConstraint.activate([
            filterButton4Label.centerXAnchor.constraint(equalTo: filterButton4.centerXAnchor),
            filterButton4Label.topAnchor.constraint(equalTo: filterButton4.bottomAnchor, constant: 0)
        ])
    }
    
    fileprivate func setUpSearchBar() {
        backgroundContainer.addSubviewForAutolayout(searchBar)
        searchBar.anchor(top: backgroundContainer.topAnchor, leading: backgroundContainer.leadingAnchor, bottom: nil, trailing: backgroundContainer.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func setUpBackgroundContainer() {
        addSubviewForAutolayout(backgroundContainer)
        backgroundContainer.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func calculateFontSizes() {
        let deviceType = UIDevice.current.deviceType
        
        // Small Devices
        if (deviceType == .iPhone4_4S || deviceType == .iPhones_5_5s_5c_SE || deviceType == .iPhones_6_6s_7_8) {
            
        }
            // Large Devices
        else {
            
            
        }
        
    }
    
    // MARK: View Methods
    func showScrollView() {
        self.scrollViewHeight?.isActive = false
        self.scrollViewHeight = self.scrollViewContainerView.heightAnchor.constraint(equalToConstant: scrollViewHeightConstant)
        self.scrollViewHeight?.isActive = true
        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
    }
    
    func hideScrollView() {
        self.scrollViewHeight?.isActive = false
        self.scrollViewHeight = self.scrollViewContainerView.heightAnchor.constraint(equalToConstant: 0)
        self.scrollViewHeight?.isActive = true
        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
    }
}
