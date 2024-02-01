//
//  StoryViewModel.swift
//  SecondApp
//
//  Created by MacBook27 on 17/01/24.
//

import Foundation

class StoryViewModel {
   
    var allUserStories = [UserStory]()
    
    init() {
        getAllUserStoryies()
    }
    
    func getAllStoryList() -> [CustomStory] {
        let story1 = CustomStory(type: .image, image: "stry1")
        let story2 = CustomStory(type: .text, text: "I’m writing my story so that others might see fragments of themselves. - Lena Waithe, screenwriter for Bones and Master of None")
        let story3 = CustomStory(type: .url, url: URL(string: "https://www.youtube.com/watch?v=Lpivp1hJ8ys"))
        return [story1, story2, story3]
    }
    
    func getAllUserStoryies() {
        let userStory1 = UserStory(storyies: getAllStoryList(), storyCount: 1)
        let userStory2 = UserStory(storyies: getAllStoryList(), storyCount: 2)
        let userStory3 = UserStory(storyies: getAllStoryList(), storyCount: 3)
        let userStory4 = UserStory(storyies: getAllStoryList(), storyCount: 4)
        
        let userStory5 = UserStory(storyies: getAllStoryList(), storyCount: 5)
        let userStory6 = UserStory(storyies: getAllStoryList(), storyCount: 6)
        let userStory7 = UserStory(storyies: getAllStoryList(), storyCount: 7)
        let userStory8 = UserStory(storyies: getAllStoryList(), storyCount: 8)
        
        let userStory9 = UserStory(storyies: getAllStoryList(), storyCount: 9)
        let userStory10 = UserStory(storyies: getAllStoryList(), storyCount: 10)
        let userStory11 = UserStory(storyies: getAllStoryList(), storyCount: 11)
        let userStory12 = UserStory(storyies: getAllStoryList(), storyCount: 12)
        
        allUserStories = [userStory1, userStory2, userStory3, userStory4, userStory5, userStory6, userStory7, userStory8, userStory9, userStory10, userStory11, userStory12]
    }
}
