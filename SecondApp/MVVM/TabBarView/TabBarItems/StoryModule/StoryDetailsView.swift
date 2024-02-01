//
//  StoryDetailsView.swift
//  SecondApp
//
//  Created by MacBook27 on 18/01/24.
//

import SwiftUI
import StoryUI

struct StoryDetailsView: View {
    @State var isPresented: Bool = false
    @State var stories = [
        StoryUIModel(user: StoryUIUser(name: "Tolga İskender", image: "https://image.tmdb.org/t/p/original/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"), stories: [
            
            Story(mediaURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
                  date: "30 min ago",
                  config: StoryConfiguration(storyType: .message(config: StoryInteractionConfig(showLikeButton: true),
                                                                 emojis: [["😂","😮","😍"],
                                                                          ["😢","👏","🔥"]],
                                                                 placeholder: "Send Message"),
                                             mediaType: .video)),
            
            Story(mediaURL: "https://image.tmdb.org/t/p/original//pThyQovXQrw2m0s9x82twj48Jq4.jpg", date: "1 hour ago", config: StoryConfiguration(mediaType: .image)),
            Story(mediaURL: "https://image.tmdb.org/t/p/original/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", date: "12 hours ago", config: StoryConfiguration(mediaType: .image))
        ]),
        StoryUIModel(user: StoryUIUser(name: "Jhon Doe", image: "https://image.tmdb.org/t/p/original//pThyQovXQrw2m0s9x82twj48Jq4.jpg"), stories: [
            Story(mediaURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", date: "30 min ago", config: StoryConfiguration(mediaType: .video)),
            Story(mediaURL: "https://picsum.photos/id/237/200/300", date: "12 hours ago", config: StoryConfiguration(mediaType: .image)),
            
        ]),
    ]
    var body: some View {
        NavigationView {
            Button {
                isPresented = true
            } label: {
                Text("Show")
            }
            .fullScreenCover(isPresented: $isPresented) {
                StoryView(stories: stories,
                          isPresented: $isPresented, userClosure: nil)
            }
        }
        
    }
}
// (_ story: Story, _ message: String?, _ emoji: String?, _ isLiked: Bool) -> Void


struct StoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailsView()
    }
}
