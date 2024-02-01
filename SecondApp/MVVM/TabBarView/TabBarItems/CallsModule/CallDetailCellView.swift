//
//  CallDetailCellView.swift
//  SecondApp
//
//  Created by MacBook27 on 22/12/23.
//

import SwiftUI

struct CallDetailCellView: View {
    
    @State var callDetail: CallDetail
    
    var body: some View {
        HStack {
            ZStack {
                Image("personPic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 52, height: 52)
                    .cornerRadius(26)
                
                Circle()
                    .foregroundColor(callDetail.user.isOnline ? .green : .gray)
                    .frame(width: 12, height: 12)
                    .offset(x: 18, y: 18)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(callDetail.user.name)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .layoutPriority(1)
                        .foregroundColor(callDetail.callerType.forgroundColor)
                    Spacer()
                    Text(callDetail.date.chatFormatDate())
                        .foregroundColor(callDetail.callerType.tintColor)
                        .lineLimit(1)
                        .layoutPriority(1000)
                }
                Image(callDetail.callerType.getIconName(callType: callDetail.callType))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 26, height: 26)
                    .cornerRadius(26)
                    .foregroundColor(callDetail.callerType.tintColor)
            }
        }
    }
}

struct CallDetailCellView_Previews: PreviewProvider {
    static var previews: some View {
        
        CallDetailCellView(callDetail: CallDetailsViewModels().callDetails.first!)
    }
}
