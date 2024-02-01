//
//  ConversationHeaderView.swift
//  SecondApp
//
//  Created by MacBook27 on 19/12/23.
//

import SwiftUI

struct ConversationHeaderView: View {
    @State var user: User
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .padding(1)
                        .foregroundColor(.black)
                }
                .frame(width: 28, height: 28)
                Image("personPic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                VStack(alignment: .leading) {
                    Text(user.name)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    if user.isOnline {
                        Text("Online")
                            .fontWeight(.regular)
                            .font(.subheadline)
                            .lineLimit(1)
                        
                    }
                }
                Spacer()
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
            .padding()
    }
}

struct ConversationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationHeaderView(user: User.getMockuser())
    }
}
