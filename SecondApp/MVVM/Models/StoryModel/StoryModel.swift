//
//  StoryModel.swift
//  SecondApp
//
//  Created by MacBook27 on 17/01/24.
//

import Foundation

enum StoryType {
    case text
    case url
    case image
    case video
}

struct CustomStory {
    var id: Int = Int.uniqueId
    var type: StoryType
    var text: String?
    var image: String?
    var video: URL?
    var url: URL?
}

struct UserStory {
    var id: Int = Int.uniqueId
    var user: User = User.getMockuser()
    var storyies: [CustomStory]
    var storyCount = 1
}

extension UserStory {
    static var mockStory: UserStory {
        UserStory(storyies: [CustomStory(type: .text, text: "Hi this is my first story||||")])
    }
}
