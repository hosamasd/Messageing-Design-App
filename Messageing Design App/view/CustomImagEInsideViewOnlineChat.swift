//
//  CustomImageView.swift
//  Messageing Design App
//
//  Created by Hossam on 9/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//


import UIKit

class CustomImagEInsideViewOnlineChat: UIView {
    
    lazy var imageView:UIImageView = {
        let img = UIImageView(image: UIImage(named: "prof-img4"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        return img
    }()
    
    lazy var  indicatorView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .green
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 2.5
        v.layer.cornerRadius = 7.5
        v.constrainWidth(constant: 15)
        v.constrainHeight(constant: 15)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(views: imageView,indicatorView)
        imageView.fillSuperview()
        indicatorView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 2, left: 0, bottom: 0, right: -5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
