//
//  CallDetail.swift
//  SecondApp
//
//  Created by MacBook27 on 22/12/23.
//

import SwiftUI

enum CallType {
    case video
    case voice
}

enum CallFilerType {
    case incoming
    case outgoing
    case missed
    case video
    case voice
    case all
    
    var callType: CallType {
        self == .video ? CallType.video : CallType.voice
    }
    
    var callerType: CallerType {
        switch self {
        case .incoming:
            return .incoming
        case .outgoing:
            return .outgoing
        case .missed:
            return .missed
        case .video, .voice, .all:
            return .incoming
        }
    }
    
    var text: String {
        switch self {
        case .incoming:
            return "Incoming"
        case .outgoing:
            return "Outgoing"
        case .missed:
            return "Missed"
        case .video:
            return "Video"
        case .voice:
            return "Voice"
        case .all:
            return "All"
        }
    }
}

enum CallerType {
    case incoming
    case outgoing
    case missed
    
    var text: String {
        switch self {
        case .incoming:
            return "Incoming"
        case .outgoing:
            return "Outgoing"
        case .missed:
            return "Missed"
        }
    }
    
    var tintColor: Color {
        switch self {
        case .incoming, .outgoing:
            return .gray
        case .missed:
            return .red
        }
    }
    
    var forgroundColor: Color {
        switch self {
        case .incoming, .outgoing:
            return .black
        case .missed:
            return .red
        }
    }
    
    func getIconName(callType: CallType) -> String {
        
        switch self {
        case .incoming:
            return callType == .voice ? "phone inc" : "video inc"
        case .outgoing:
            return callType == .voice ? "phone out" : "video out"
        case .missed:
            return callType == .voice ? "phone inc" : "video inc"
        }
        
    }
}

struct CallDetail {
    var id: Int = Int.uniqueId
    var callType: CallType
    var callerType: CallerType
    var user: User
    var date: Date
}
