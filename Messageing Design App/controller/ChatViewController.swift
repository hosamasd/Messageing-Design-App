//
//  ChatViewController.swift
//  Messageing Design App
//
//  Created by Hossam on 9/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//


import UIKit
import AVFoundation

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    var player: AVAudioPlayer?
    var messageData:[Messages] = [
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "This is an idea of writing data" , isIncoming: true),
        Messages(messageType: "text", sentBy: "", time: "10/08/2020", image: nil , message: "This is an idea of writing data" , isIncoming: false),
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
    ]
    
    var bottomConstraint: NSLayoutConstraint?
    
    lazy var navView:ChatNavigationView = {
        let v = ChatNavigationView()
        v.controller = self
        v.translatesAutoresizingMaskIntoConstraints = false
        v.constrainHeight(constant: 140)
        return v
    }()
    
    lazy var messageInputView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.constrainHeight(constant: 80)
        return v
    }()
    
    lazy var messageBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CustomColor.appLight
        v.layer.cornerRadius = 20
        v.constrainHeight(constant: 55)
        return v
    }()
    
    lazy var sendBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = CustomColor.appPink
        btn.layer.cornerRadius = 22.5
        btn.layer.shadowColor = CustomColor.appPink.cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.addTarget(self, action: #selector(sendBtnPressed), for: .touchUpInside)
        btn.setImage(UIImage(named: "send"), for: .normal)
        btn.constrainWidth(constant: 55)
        btn.constrainHeight(constant: 55)
        return btn
    }()
    
    lazy var inputMessageField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "to write"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        tf.delegate = self
        tf.constrainHeight(constant: 45)
        return tf
    }()
    
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: "IncomingTextMessageTableViewCell")
        tv.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: "OutgoingTextMessageTableViewCell")
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.transform = CGAffineTransform(scaleX: 1, y: -1)
        tv.separatorStyle = .none
        tv.tableFooterView = UIView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupObservers()
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
        self.inputMessageField.becomeFirstResponder()
    }
    
    
    
    func setupObservers()  {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification) , name: UIResponder.keyboardWillShowNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification) , name: UIResponder.keyboardWillHideNotification , object: nil)
        //AddeventListner
        inputMessageField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    func setupViews()  {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubViews(views: tableView,navView,messageInputView)
        messageInputView.addSubview(messageBar)
        messageBar.addSubViews(views: sendBtn,inputMessageField)
        
        
        navView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        tableView.anchor(top: navView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        messageInputView.anchor(top: tableView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        messageBar.anchor(top: nil, leading: messageInputView.leadingAnchor, bottom: nil, trailing: messageInputView.trailingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        messageBar.hstack(inputMessageField,sendBtn,spacing:8).withMargins(.init(top: 0, left: 16, bottom: 8, right: 16))

//        sendBtn.anchor(top: nil, leading: nil, bottom: messageBar.bottomAnchor, trailing: messageBar.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 15))
//        inputMessageField.anchor(top: nil, leading: messageBar.leadingAnchor, bottom: nil, trailing: sendBtn.leadingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 5))
//
      
        
        //bottomconstraints
//        bottomConstraint = NSLayoutConstraint(item: messageInputView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
//        view.addConstraint(bottomConstraint!)
    
        NSLayoutConstraint.activate([
            messageBar.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            inputMessageField.centerYAnchor.constraint(equalTo: messageBar.centerYAnchor)
        ])
    }
    
    @objc func backBtnPressed(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK:- Animating on textview edit
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageField.text == ""{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendBtn.isEnabled = false
                self.sendBtn.layer.opacity = 0.4
                self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendBtn.isEnabled = true
                self.sendBtn.layer.opacity = 1
                self.sendBtn.transform = .identity
            }, completion: { _ in
            })
        }
    }
    
    @objc func sendBtnPressed(){
        sendBtn.touchAnimation(s: sendBtn)
        self.playSound()
        let message = Messages(messageType: "text", sentBy: "", time: "20/08/2020", image: nil, message: self.inputMessageField.text, isIncoming: false)
        self.messageData.insert(message, at: 0)
        self.tableView.beginUpdates()
        let index = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [index], with: .right)
        self.tableView.endUpdates()
        self.inputMessageField.text = ""
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
}

extension ChatViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messageData[indexPath.row].messageType == "text"{
            if messageData[indexPath.row].isIncoming == true {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingTextMessageTableViewCell", for: indexPath) as! IncomingTextMessageTableViewCell
                cell.transform = CGAffineTransform(scaleX: 1, y: -1)
                cell.data = messageData[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingTextMessageTableViewCell", for: indexPath) as! OutgoingTextMessageTableViewCell
                cell.transform = CGAffineTransform(scaleX: 1, y: -1)
                cell.data = messageData[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if messageData[indexPath.row].messageType == "text"{
            let desc = messageData[indexPath.row].message
            let font = UIFont.systemFont(ofSize: 14)
            let estimatedH = desc?.heightWithConstrainedWidth(width: 220, font: font)
            return CGFloat(65 + estimatedH!)
        }
        return CGFloat()
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
//            bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y-keyboardHeight : self.tableView.center.y+keyboardHeight
            
            UIView.animate(withDuration:0.1, delay: 0 , options: .curveEaseOut , animations: {
                self.view.layoutIfNeeded()
            } , completion: {(completed) in
                
                if isKeyboardShowing{
                }
            })
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}
