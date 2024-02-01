//
//  ChatModel.swift
//  SecondApp
//
//  Created by MacBook27 on 14/12/23.
//

import Foundation
import SwiftUI

struct ChatConstants {
    static let maxUnreadMessageCount: Int = 99
}

extension Int {
    static var uniqueId: Int {
        Int(UUID().uuidString.hashValue)
    }
}


extension Date {
    func chatFormatDate(_ date: Date? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let calendar = Calendar.current
        
        let dateToConvert = date ?? self
        
        if calendar.isDateInToday(dateToConvert) {
            dateFormatter.dateFormat = "'Today', h:mm a"
        } else if calendar.isDateInYesterday(dateToConvert) {
            dateFormatter.dateFormat = "'Yesterday', h:mm a"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm a"
            return dateFormatter.string(from: dateToConvert)
        }
        
        return dateFormatter.string(from: dateToConvert)
    }
    
    func chatTime() -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeStyle = .short
        let dateToConvert = self
        return dateFormatter.string(from: dateToConvert)
    }
}

struct AllUsers {
    var id: Int = Int.uniqueId
    var users: [User]
    var isActive: Bool
    var title: String
}

struct User {
    var userId: Int
    var name: String
    var isOnline: Bool
    var unreadMessageCount: Int
    var lastMessage: Message
    var profileUrl: URL?
    var gender: Gender = .male
    var unreadMessageCountStr: String {
        unreadMessageCount > ChatConstants.maxUnreadMessageCount ? "\(ChatConstants.maxUnreadMessageCount)+" : "\(unreadMessageCount)"
    }
    var unreadBgColor: Color {
        unreadMessageCount > ChatConstants.maxUnreadMessageCount ? Color.red : unreadMessageCount > 10 ? Color.brown : Color.green
    }
    var isTyping: Bool = false
    var presenceText: String {
        if isTyping {
            return "Typing..."
        } else if isOnline {
            return "Online"
        } else {
            return ""
        }
    }
}

extension User {
    static func getMockuser() -> User {
        User(userId: Int.uniqueId, name: "John Demon", isOnline: true, unreadMessageCount: 4, lastMessage: Message(messageId: Int.uniqueId, messageType: .text, date: Date(), senderType: .outgoing))
    }
}

enum Messagetype {
    case text
    case image
    case video
    case voice
    case gif
    case singleEmoji
    case youtubeVideoUrl
    case websiteUrl
    case multipleImages
    case pdf
}

enum SenderType {
    case incoming /// send by other
    case outgoing /// send by me
    
    var isOutgoing: Bool {
        self == .outgoing
    }
    
    var bubbleBackgroundColor: Color {
        self == .outgoing ? Color("outgoingbubble") : Color("incomingbubble")
    }
}

enum MessageStatus {
    case isSending
    case sent
    case pending
    case failed
}

enum DeliveryStatus {
    case sent
    case delivered
    case seen
    
    var tintColor: Color {
        switch self {
        case .sent, .delivered:
            return .gray
        case .seen:
            return .green
        }
    }
    
    var icon: String {
        switch self {
        case .sent:
            return "singleCheck"
        case .delivered, .seen:
            return "doubleCheck"
        }
    }
}

enum Gender {
    case male
    case female
    case other
}

enum Media {
    case image (image: UIImage?)
    case video
    case pdf
}

struct Message {
    var messageId: Int
    var messageType: Messagetype
    var text: String?
    var mediaUrl: URL?
    var date: Date
    var senderType: SenderType
    var deliveryStatus: DeliveryStatus = .sent
    var media: UIImage? = UIImage(named: "personPic")
}

struct GroupedMessage {
    var groupId: Int = Int.uniqueId
    var messages: [Message]
    var date: Date
    var title: String
}
