//
//  ChatNavigationView.swift
//  Messageing Design App
//
//  Created by Hossam on 9/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//


import UIKit

class ChatNavigationView: UIView {
    
    var controller:ChatViewController?{
        didSet {
            backBtn.addTarget(controller, action:#selector(ChatViewController.backBtnPressed), for: .touchUpInside)
        }
    }
    
    lazy var navBackView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 35
        v.layer.maskedCorners = [.layerMaxXMaxYCorner]
        v.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 10)
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 10
        return v
    }()
    
    lazy var navBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var searchBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CustomColor.appLight
        v.layer.cornerRadius = 20
        return v
    }()
    
    lazy var searchLabel = UILabel(text: "Search", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var searchBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "search"), for: .normal)
        return btn
    }()
    
    lazy var backBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back"), for: .normal)
        return btn
    }()
    
    lazy var customImage:CustomImagEInsideViewOnlineChat = {
        let img = CustomImagEInsideViewOnlineChat()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.imageView.image = UIImage(named: "prof-img2")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navBackView)
        navBackView.addSubview(navBar)
        navBar.addSubview(backBtn)
        navBar.addSubview(customImage)
        navBar.addSubview(searchBar)
        searchBar.addSubview(searchLabel)
        searchBar.addSubview(searchBtn)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            navBackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBackView.topAnchor.constraint(equalTo: topAnchor),
            navBackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backBtn.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            backBtn.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            backBtn.heightAnchor.constraint(equalToConstant: 30),
            backBtn.widthAnchor.constraint(equalToConstant: 30),
            
            customImage.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 20),
            customImage.heightAnchor.constraint(equalToConstant: 55),
            customImage.widthAnchor.constraint(equalToConstant: 55),
            customImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: customImage.trailingAnchor, constant: 20),
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchBtn.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            searchBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchBtn.widthAnchor.constraint(equalToConstant: 20),
            searchBtn.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
