//
//  MessageList.swift
//  Messageing Design App
//
//  Created by Hossam on 9/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//


import Foundation

struct MessageList{
    let userName:String!
    let lastMessage:String!
    let userImage:String!
    let date:String!
    let pending:Bool!
    let pendingCount:String!
}

struct Messages{
    var messageType:String!
    var sentBy:String!
    var time:String!
    var image:String!
    var message:String!
    var isIncoming:Bool!
}
