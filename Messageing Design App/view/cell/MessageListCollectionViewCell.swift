//
//  MessageListCollectionViewCell.swift
//  Messageing Design App
//
//  Created by Hossam on 9/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//



import UIKit

class MessageListCollectionViewCell: UICollectionViewCell {
    
    var data:MessageList?{
        didSet {
            manageData()
        }
    }
    
    lazy var customImageView:CustomImagEInsideViewOnlineChat = {
        let v = CustomImagEInsideViewOnlineChat()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.constrainWidth(constant: 55)
        v.constrainHeight(constant: 55)
        return v
    }()
    
    lazy var userName:UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        return l
    }()
    lazy var messagesName:UILabel = {
        let l = UILabel()
        l.textColor = .lightGray
        return l
    }()
    
    lazy var dateLabel = UILabel(text: "10/03/2020", font: .systemFont(ofSize: 13), textColor: .lightGray)
    lazy var pendingMessageView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CustomColor.appPink
        v.layer.cornerRadius = 8
        v.constrainWidth(constant: 26)
        v.constrainHeight(constant: 20)
        v.addSubview(pendingLabel)
        return v
    }()
    
    lazy var pendingLabel =  UILabel(text: "4", font: .systemFont(ofSize: 16), textColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pendingLabel.translatesAutoresizingMaskIntoConstraints = false
        let tt = hstack(userName,dateLabel,spacing:8)
        let ff = hstack(messagesName,pendingMessageView,spacing:8)
        
        let dd = stack(tt,ff,spacing:8)
        
        hstack(customImageView,dd,spacing:16).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        
        NSLayoutConstraint.activate([
            pendingLabel.centerYAnchor.constraint(equalTo: pendingMessageView.centerYAnchor),
            pendingLabel.centerXAnchor.constraint(equalTo: pendingMessageView.centerXAnchor),
        ])
    }
    
    func manageData(){
        guard let data = data else {return}
        customImageView.imageView.image = UIImage(named: data.userImage)
        messagesName.text = data.lastMessage
        userName.text = data.userName
        dateLabel.text = data.date
        if data.pending {
            pendingMessageView.isHidden = false
            pendingLabel.text = data.pendingCount
        } else {
            pendingMessageView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
