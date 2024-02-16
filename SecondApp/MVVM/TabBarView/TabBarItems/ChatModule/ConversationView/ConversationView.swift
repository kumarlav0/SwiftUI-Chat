//
//  ConversationView.swift
//  SecondApp
//
//  Created by MacBook27 on 15/12/23.
//

import SwiftUI

struct ConversationView: View {
    
    @State var user: User
    @StateObject var conversationViewModel = ConversationViewModel()
    @State private var voiceRecordingStarted = false
    
    @State var msgCount = 1
    
    @State private var scrollToBottomVisible = false
    @State private var isScrolledToBottom = true
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(conversationViewModel.allGroupedMessage, id: \.groupId) { groupedMessage in                        
                        Section(footer:
                                    VStack {
                            Spacer()
                            Text(groupedMessage.title)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.headline)
                                .foregroundColor(.gray)
                                .background(.black)
                                .padding(10)
                                .containerShape(Ellipse())
                            Spacer()
                        }
                            .frame(maxWidth: .infinity) // Expand VStack to fill width of section header
                        .scaleEffect(x: 1, y: -1)
                        ) {
                            ForEach(groupedMessage.messages, id: \.messageId) { message in
                                ChatBubble(message: message)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                                    .padding(0)
                                    .scaleEffect(x: 1, y: -1)
                                    .onChange(of: conversationViewModel.allGroupedMessage.last?.groupId) { _ in
                                        isScrolledToBottom = true
                                    }
                            }
                        }
                    }
                }
                .listStyle(.grouped)
                .padding(5)
                .scrollIndicators(.hidden)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .scaleEffect(x: 1, y: -1)
                .gesture(DragGesture().onChanged { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    checkScrollPosition()
                })
                .overlay(
                    VStack {
                        Spacer()
                        if scrollToBottomVisible {
                            Button(action: scrollToBottom) {
                                Image(systemName: "arrow.down.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                )
                
                Spacer()
                if voiceRecordingStarted {
                    Divider()
                    VoiceRecordingView(voiceRecordingStarted: $voiceRecordingStarted)
                } else {
                    Divider()
                    ChatInputView(voiceRecordingStarted: $voiceRecordingStarted, chatViewModel: conversationViewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image("personPic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .frame(maxWidth: 200, alignment: .leading)
                                if user.isTyping || user.isOnline {
                                    Text(user.presenceText)
                                        .fontWeight(.regular)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: 0))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 20) {
                        
                        Button(action: {
                            print("Start Video Calling.....")
                        }) {
                            Image(systemName: "video.fill")
                                .resizable()
                                .scaledToFit()
                                .padding(1)
                                .foregroundColor(.blue)
                            
                        }
                        .frame(width: 28, height: 28)
                        
                        Button(action: {
                            print("Start Voice Calling.....")
                        }) {
                            Image(systemName: "phone.fill")
                                .resizable()
                                .scaledToFit()
                                .padding(1)
                                .foregroundColor(.blue)
                        }
                        .frame(width: 28, height: 28)
                    }
                }
            }
        }
        .onAppear {
            
        }
        .onDisappear {
            stopTimer()
        }
    }
}

extension ConversationView {
    private func startTyping() {
        user.isTyping = true
    }
    
    private func stopTyping() {
        user.isTyping = false
    }
    
    private func startTimer() {
        conversationViewModel.typingTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.startTyping()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                if msgCount == 1 {
                    self.conversationViewModel.getTextessage("Hi, What are you doing now...")
                } else  if msgCount == 2 {
                    self.conversationViewModel.getTextessage("Dud, We are planning to go to Dubai this weekend.")
                } else  if msgCount == 3 {
                    self.conversationViewModel.getTextessage("Yeah, if you have time you can join us for this trip, will have lots of fun and adventure bro......... ")
                } else  if msgCount == 4 {
                    self.conversationViewModel.getTextessage("Oh Wow, thats Amazing bro...")
                } else {
                    self.conversationViewModel.getTextessage("Ok, Lets catchup tomorrow. will discuss more on this.")
                }
                self.stopTyping()
                self.msgCount += 1
            }
        }
    }
    
    private func stopTimer() {
        conversationViewModel.typingTimer?.invalidate()
        conversationViewModel.typingTimer = nil
    }
    
    private func checkScrollPosition() {
            // You can customize this logic based on your requirements
            if isScrolledToBottom {
                scrollToBottomVisible = true
            } else {
                scrollToBottomVisible = false
            }
        }

        private func scrollToBottom() {
            print("......")
            // Your logic to scroll to the bottom
            // For example, you can use ScrollViewReader to scroll to the last message
        }
    
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(user: User.getMockuser())
    }
}
