//
//  StoryView.swift
//  SecondApp
//
//  Created by MacBook27 on 19/12/23.
//

import SwiftUI
import StoryUI

struct CustomStoryView: View {
    
    let storyViewModel = StoryViewModel()
    
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
        NavigationStack {
            List {
                ForEach(storyViewModel.allUserStories, id: \.id) { userStory in
                    UserStoryCellView(userStory: userStory)
                        .onTapGesture {
                            isPresented.toggle()
                        }
                }
            }
            .fullScreenCover(isPresented: $isPresented) {
                StoryView(stories: stories,
                          isPresented: $isPresented, userClosure: nil)
            }
            .navigationTitle("Stories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("addd....")
                    } label: {
                        Image(systemName: "memories.badge.plus")
                    }

                }
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        CustomStoryView()
    }
}


struct UserStoryCellView: View {
    
    @State var userStory: UserStory
   
    var body: some View {
        HStack {
            InstaStory(cuts: userStory.storyCount)
            Text(userStory.user.name + " - \(userStory.storyCount)")
                .fontWeight(.bold)
                .lineLimit(1)
        }
    }
}

//struct StoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserStoryCellView(userStory: UserStory.mockStory)
//    }
//}

struct InstaStory: View {
    var cuts: Int = 1  // Set the number of cuts
    
    var body: some View {
        VStack(alignment: .center) {
            
            ZStack {
                Circle()
                    .fill(.clear)
                    .frame(width: 80, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(
                                LinearGradient(
                                    gradient:
                                        Gradient(colors: [
                                            .red,
                                            .yellow,
                                            .purple
                                        ]),
                                    startPoint: .topTrailing,
                                    endPoint: .bottomLeading
                                ),
                                style: StrokeStyle(lineWidth: 4, dash: dashParameters(for: cuts))
                            )
                    )
                Image("personPic")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
//                    .rotationEffect(.degrees(360.0 / Double(cuts) * Double(0)))
            }
        }
    }
    
    
    // Function to calculate dash parameters based on the number of cuts
       private func dashParameters(for cuts: Int) -> [CGFloat] {
           let totalDashLength: CGFloat = 160
           let dashLength = totalDashLength / CGFloat(cuts - 1)
           print("dashLength", dashLength)
           if cuts == 1 {
               return [260, 4]
           } else if cuts == 2 {
               return [120, 4]
           } else {
               return [dashLength, 4]
           }
           
       }
}
  // (160 / 40 ) + 1 = 5
  // 160 / x ) + 1 = 5
// 160  / x = 5 - 1
// 160 / x = 4
// 160 / x = 4 / 1
// 160 / 4 = x = 40

//struct StoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        InstaStory()
//    }
//}
