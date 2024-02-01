//
//  UserCellView.swift
//  SecondApp
//
//  Created by MacBook27 on 15/12/23.
//

import SwiftUI

struct UserCellView: View {
    
    @State var user: User
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 52, height: 52)
                    .cornerRadius(26)
                    .foregroundColor(.mint)
                
                Circle()
                    .foregroundColor(user.isOnline ? .green : .gray)
                    .frame(width: 12, height: 12)
                    .offset(x: 18, y: 18)
            }
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(user.name)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .layoutPriority(1)
                    Spacer()
                    Text(user.lastMessage.date.chatFormatDate())
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .layoutPriority(1000)
                }
                
                Text(user.lastMessage.text ?? "")
                    .lineLimit(1)                
            }
            if user.unreadMessageCount > 0 {
                Text(user.unreadMessageCountStr)
                    .font(.system(size: 8, weight: .bold))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(user.unreadBgColor)
                    .clipShape(Capsule())
            }
        }
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(userId: 0, name: "name", isOnline: false, unreadMessageCount: 0, lastMessage: Message(messageId: 0, messageType: .text,text: "Hey man how you doing", date: Date(), senderType: .outgoing))
        UserCellView(user: user)
    }
}
