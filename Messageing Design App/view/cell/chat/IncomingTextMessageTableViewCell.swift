//
//  IncomingTextMessageTableViewCell.swift
//  Messageing Design App
//
//  Created by Hossam on 9/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//


import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {
    
    var data:Messages?{
        didSet{
            manageData()
        }
    }
    
    lazy var bubbleview:UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = UIColor(white: 0, alpha: 0.06)
        bv.layer.cornerRadius = 20
        bv.constrainWidth(constant: 250)
        bv.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return bv
    }()
    
    lazy var messageTextLabel = UILabel(text: "The", font: .systemFont(ofSize: 14), textColor: .darkGray,  numberOfLines: 0)
    
    lazy var messageDetail:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.constrainHeight(constant: 14)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews(views: bubbleview,messageDetail,messageTextLabel)
        
        bubbleview.anchor(top: topAnchor, leading: leadingAnchor, bottom: messageDetail.topAnchor, trailing: nil,padding: .init(top: 10, left: 20, bottom: 5, right: 0))
        
        messageTextLabel.anchor(top: bubbleview.topAnchor, leading: bubbleview.leadingAnchor, bottom: bubbleview.bottomAnchor, trailing: bubbleview.trailingAnchor,padding: .init(top: 15, left: 15, bottom: 15, right: 15))
        messageDetail.anchor(top: bubbleview.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,padding: .init(top: 5, left: 20, bottom: 5, right: 0))
        
    }
    
    func setMessageDetailAttributedText(){
        guard let data = data else {return}
        let attributedText = NSMutableAttributedString(string:"\(data.sentBy ?? "")" , attributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        attributedText.append(NSAttributedString(string: "  \(data.time ?? "")" , attributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        messageDetail.attributedText = attributedText
    }
    
    func manageData(){
        guard let data = data else {return}
        messageTextLabel.text = data.message
        setMessageDetailAttributedText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
