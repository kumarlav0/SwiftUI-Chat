//
//  ChatListViewModel.swift
//  SecondApp
//
//  Created by MacBook27 on 14/12/23.
//

import UIKit

class UsersViewModel {
    
    var allUsers: [AllUsers] = []
    var users = [User]()
    
    init() {
        getMockAllUsers()
    }
    
    func getMockAllUsers() {
        let message1 = Message(messageId: Int.uniqueId, messageType: .text, text: "Hi Dev, How are you brother?", date: Date(), senderType: .incoming, deliveryStatus: .delivered)
        let message2 = Message(messageId: Int.uniqueId, messageType: .text, text: "Hello, I hope you are doing good bro. lets catchup some day", date: Date(), senderType: .outgoing, deliveryStatus: .seen)
        
//        let message3 = Message(messageId: Int.uniqueId, messageType: .text, text: "Hello, I hope you are doing good bro. lets catchup some day", date: Date(), senderType: .outgoing, deliveryStatus: .sent)
        
        let usr1 = User(userId: Int.uniqueId, name: "Rahul", isOnline: true, unreadMessageCount: 10, lastMessage: message1)
        let usr2 = User(userId: Int.uniqueId, name: "Shivam rathi", isOnline: false, unreadMessageCount: 0, lastMessage: message2)
        let usr3 = User(userId: Int.uniqueId, name: "John Stephered", isOnline: true, unreadMessageCount: 999, lastMessage: message1)
        let usr4 = User(userId: Int.uniqueId, name: "Ragini Dubey", isOnline: false, unreadMessageCount: 1, lastMessage: message2, gender: .female)
        let usr5 = User(userId: Int.uniqueId, name: "Sathyasri Sharmila SharmilaSharmila", isOnline: true, unreadMessageCount: 99, lastMessage: message1, gender: .other)
        
        allUsers.append(AllUsers(users: [usr1,usr3, usr5], isActive: true, title: "Active Users"))
        allUsers.append(AllUsers(users: [usr4,usr2], isActive: false, title: "In Active Users"))
        
    }
    
}


class ConversationViewModel: ObservableObject {
    
    @Published var allConversation = [Message]()
    
    var typingTimer: Timer?
    
    init() {
        getAllConversations()
    }
    
    private func getAllConversations() {
        let message1 = Message(messageId: Int.uniqueId, messageType: .singleEmoji, text: "🤪", date: Date(), senderType: .incoming)
        let message2 = Message(messageId: Int.uniqueId, messageType: .text, text: "Hello, Bro. How you doing", date: Date(), senderType: .outgoing, deliveryStatus: .sent)
        
        let message3 = Message(messageId: Int.uniqueId, messageType: .text, text: "😍🥰😘😗", date: Date(), senderType: .outgoing, deliveryStatus: .delivered)
        let message4 = Message(messageId: Int.uniqueId, messageType: .text, text: "I am also gud bro.", date: Date(), senderType: .outgoing, deliveryStatus: .seen)
        
        let message5 = Message(messageId: Int.uniqueId, messageType: .singleEmoji, text: "😘", date: Date(), senderType: .outgoing, deliveryStatus: .seen)
        let message6 = Message(messageId: Int.uniqueId, messageType: .text, text: "Oh It sounds great dud. Okay wait let me check. i=I have few Hotel details. I will share you some contact details. you can call for any enquiry.", date: Date(), senderType: .outgoing, deliveryStatus: .seen)
        
        let message7 = Message(messageId: Int.uniqueId, messageType: .text, text: "Sounds good. So, take your time", date: Date(), senderType: .incoming, deliveryStatus: .delivered)
        let message8 = Message(messageId: Int.uniqueId, messageType: .text, text: "Sure, give me some time will share you.", date: Date(), senderType: .outgoing)
        allConversation = [message1, message2, message3, message4, message5, message6, message7, message8]
    }
    
    func addEmojiMessage(_ emoji: String?) {
        if let emoji = emoji {
            let message = Message(messageId: Int.uniqueId, messageType: .singleEmoji, text: emoji, date: Date(), senderType: .outgoing, deliveryStatus: .seen)
            allConversation.insert(message, at: 0)
        }
    }
    
    func addTextessage(_ text: String) {
        if !text.isEmpty {
            let message = Message(messageId: Int.uniqueId, messageType: .text, text: text, date: Date(), senderType: .outgoing, deliveryStatus: .seen)
            allConversation.insert(message, at: 0)
        }
    }
    
    func sendImageAsMessage(_ image: UIImage?) {
        if let image = image {
            let message = Message(messageId: Int.uniqueId, messageType: .image, date: Date(), senderType: .outgoing, deliveryStatus: .seen, media: image)
            allConversation.insert(message, at: 0)
        }
    }
    
    func getTextessage(_ text: String) {
        if !text.isEmpty {
            let message = Message(messageId: Int.uniqueId, messageType: .text, text: text, date: Date(), senderType: .incoming, deliveryStatus: .seen)
            allConversation.insert(message, at: 0)
        }
    }
    
    func sendPdfAsMessage(_ pdfUrl: URL?) {
        if let pdfUrl = pdfUrl {
            let message = Message(messageId: Int.uniqueId, messageType: .pdf, mediaUrl: pdfUrl, date: Date(), senderType: .outgoing, deliveryStatus: .seen)
            allConversation.insert(message, at: 0)
        }
    }
    
}
