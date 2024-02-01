//
//  CustomChatBubble.swift
//  SecondApp
//
//  Created by MacBook27 on 19/12/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ChatHomeView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Chat")
                }
                .tag(0)
            
            CallsView()
                .tabItem {
                    Image(systemName: "phone")
                    Text("Calls")
                }
                .tag(1)
            
            CustomStoryView()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Story")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(3)
        }
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
