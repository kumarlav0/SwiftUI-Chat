//
//  ProfileModel.swift
//  SecondApp
//
//  Created by MacBook27 on 20/12/23.
//

import Foundation

enum ProfileType {
    case general
    case premium
}

enum ProfileSettings {
    case starredMessages(enabled: Bool)
    case account(enabled: Bool)
    case privacy(enabled: Bool)
    case notification(enabled: Bool)
    case storage(enabled: Bool)
    case help(enabled: Bool)
    case invite(enabled: Bool)
    
    var title: String {
        switch self {
        case .starredMessages:
            return "Starred Message"
        case .account:
            return "Account"
        case .privacy:
            return "Privacy"
        case .notification:
            return "Notifications"
        case .storage:
            return "Storage"
        case .help:
            return "Help"
        case .invite:
            return "Invite Friends"
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case let .starredMessages(enabled),
            let .account(enabled),
            let .privacy(enabled),
            let .notification(enabled),
            let .storage(enabled),
            let .help(enabled),
            let .invite(enabled):
            return enabled
        }
    }
    
    static let allSettings: [ProfileSettings] = [
        .starredMessages(enabled: true),
        .account(enabled: true),
        .privacy(enabled: true),
        .notification(enabled: true),
        .storage(enabled: true),
        .help(enabled: false),
        .invite(enabled: true)
    ]
}
