//
//  VoiceRecordingView.swift
//  SecondApp
//
//  Created by MacBook27 on 21/12/23.
//

import SwiftUI

struct VoiceRecordingView: View {
    @Binding var voiceRecordingStarted: Bool
    @State var timerCount: String = "0 Sec"
    @State var totalRecordedSeconds = 0
    @State var isPaused = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Text(timerCount)
                    .font(.system(size: 30))
                    .frame(height: 36)
                    .padding(20)
                Text("Recording...")
                    .font(.system(size: 18))
            }
            
            HStack {
                Button {
                    print("Delete voice.....")
                    voiceRecordingStarted.toggle()
                } label: {
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .frame(width: 46, height: 46)
                .background(.white)
                .clipShape(Circle())
                Spacer()
                Button {
                    print("Pause voice recording.....")
                    isPaused.toggle()
                } label: {
                    Image(systemName: isPaused ? "play.circle.fill" : "pause.circle.fill" )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .frame(width: 46, height: 46)
                .background(.white)
                .clipShape(Circle())
                Spacer()
                Button {
                    print("Send voice.....")
                    voiceRecordingStarted.toggle()
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .frame(width: 46, height: 46)
                .background(.white)
                .clipShape(Circle())
                
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
        }
        .onReceive(timer) { _ in
            if !isPaused {
                totalRecordedSeconds += 1
                timerCount = "\(totalRecordedSeconds) Sec"
            }
        }
        .background(Color("lightGrey"))
    }
}

struct VoiceRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecordingView(voiceRecordingStarted: .constant(false))
    }
}
