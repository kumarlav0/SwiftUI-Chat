//
//  ContentView.swift
//  SecondApp
//
//  Created by MacBook27 on 14/12/23.
//

import SwiftUI

struct ChatHomeView: View {
    
    @State private var userViewModel = UsersViewModel()
    @State private var presentedAllUsers: Bool = false
    @State private var hasTitle = true
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(userViewModel.allUsers, id: \.id) { allUser in
                    Section(header: Text(allUser.title)) {
                        ForEach(allUser.users, id: \.userId) { user in
                            NavigationLink {
                                ConversationView(user: user)
                                    .toolbar(.hidden, for: .tabBar)
                                    .onAppear {
                                        self.hasTitle = false
                                    }
                                    .onDisappear {
                                        self.hasTitle = true
                                    }
                            } label: {
                                UserCellView(user: user)
                            }
                        }
                    }
                }
            }
            .onAppear {
                print("here.......")
            }
            .navigationBarTitle(self.hasTitle ? "Chat" : "")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentedAllUsers.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $presentedAllUsers) {
                        AllUserListView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHomeView()
    }
}
