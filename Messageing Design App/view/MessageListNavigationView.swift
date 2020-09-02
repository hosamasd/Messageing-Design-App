//
//  MessageListNavigationView.swift
//  Messageing Design App
//
//  Created by Hossam on 9/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit

class MessageListNavigationView: UIView {
    
    lazy var navBackView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 35
        v.layer.maskedCorners = [.layerMaxXMaxYCorner]
        v.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 5)
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 10
        return v
    }()
    
     lazy var  navBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
     lazy var  searchBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CustomColor.appLight
        v.layer.cornerRadius = 20
        v.hstack(searchLabel,searchBtn).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        v.constrainHeight(constant: 55)
        return v
    }()
    
     lazy var  searchLabel = UILabel(text: "Search", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
     lazy var  searchBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.constrainWidth(constant: 20)
        btn.constrainHeight(constant: 20)
        return btn
    }()
    
     lazy var  stackView:UIStackView = {
        let sv = getStack(views: btn1,btn2, spacing: 10, distribution: .fillEqually, axis: .horizontal)
        sv.constrainWidth(constant: 100)
//        sv.constrainHeight(constant: 30)
        return sv
    }()
    
     lazy var  btn1:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "group"), for: .normal)
        return btn
    }()
    
     lazy var  btn2:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "star"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let ff = hstack(searchBar,stackView,spacing:8)
        stack(navBackView)
        
        stack(UIView(),ff).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
