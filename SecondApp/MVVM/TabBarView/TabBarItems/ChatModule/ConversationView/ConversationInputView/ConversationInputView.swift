//
//  ConversationInputView.swift
//  SecondApp
//
//  Created by Kumar Lav on 19/12/23.
//

import SwiftUI
import PhotosUI

struct ChatInputView: View {
    @State var messageText = ""
    @Binding var voiceRecordingStarted: Bool
    @State var openEmojiList = false
    @State var openGalerySheet = false
    @State private var showToast = false
    @State private var isPressing = false
    
    @State private var showCamera = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var picketImage : UIImage? = nil
    
    @State private var showDocumentPicker = false
    @State var fileContent: URL?
    
    @ObservedObject var chatViewModel: ConversationViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            
            Button(action: {
                openGalerySheet.toggle()
            }) {
                Image(systemName: "paperclip.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            .actionSheet(isPresented: $openGalerySheet) {
                ActionSheet(title: Text(""), buttons: [
                    .default(Text("Camera"), action: {
                        // Handle Camera action
                        showCamera.toggle()
                    }),
                    .default(Text("Photo & Video Library"), action: {
                        // Handle Photo Library action
                        showImagePicker.toggle()
                    }),
                    .default(Text("Document"), action: {
                        // Handle Photo Library action
                        showDocumentPicker.toggle()
                    }),
                    .default(Text("Location"), action: {
                        // Handle Camera action
                    }),
                    .default(Text("Contact"), action: {
                        // Handle Camera action
                    }),
                    .cancel()
                ])
            }
            .fullScreenCover(isPresented: $showCamera) {
                accessCameraView(selectedImage: $selectedImage)
            }
            .sheet(isPresented: $showImagePicker) {
                PhotoCaptureView(showImagePicker: $showImagePicker, image: $picketImage)
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker(fileContent: $fileContent)
            }
            
            Button(action: {
                openEmojiList.toggle()
            }) {
                Image(systemName: "face.dashed.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            TextView(text: $messageText)
                .frame(minHeight: 36, maxHeight: 100)
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color("lightGrey"))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .scrollContentBackground(.hidden)
            
            Button(action: {
                if !messageText.isEmpty {
                    sendMessage()
                } else {
                    print("Long press to record voice message..")
                    showToast.toggle()
                }
            }) {
                if messageText.isEmpty {
                    Image(systemName: "mic.slash.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                } else {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }
            .onTapGesture(count: 1) {
                // Tap action if needed
            }
            .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10) {
                if messageText.isEmpty {
                    print("Start Voice recording.....")
                    //                        voiceRecordingStarted.toggle()
                }
            } onPressingChanged: { inProgress in
                print("In progress: \(inProgress)!")
                isPressing = inProgress
                if !inProgress && messageText.isEmpty {
                    print("Start Voice recording.....")
                    //                        voiceRecordingStarted.toggle()
                }
            }
            
        }.onChange(of: selectedImage, perform: { newValue in
            chatViewModel.sendImageAsMessage(selectedImage)
        })
        .onChange(of: picketImage, perform: { newValue in
            chatViewModel.sendImageAsMessage(picketImage)
        })
        .onChange(of: fileContent, perform: { newValue in
            chatViewModel.sendPdfAsMessage(fileContent)
        })
        .sheet(isPresented: $openEmojiList, content: {
            EmojiGridView(isSelected: $openEmojiList, chatViewModel: chatViewModel)
        })
        .overlay(
            ToastView(isShowing: $showToast, message: "Long press to record voice message..")
        )
        .padding(5)
    }
}

extension ChatInputView {
    func sendMessage() {
        print("Sending message: \(messageText)")
        chatViewModel.addTextessage(messageText)
        messageText = ""
    }
}

struct ChatInputView_Previews: PreviewProvider {
    static var previews: some View {
        ChatInputView(voiceRecordingStarted: .constant(false), chatViewModel: ConversationViewModel())
    }
}

struct TextView: View {
    @FocusState private var keyboardFocused:Bool
    @Binding var text: String
    var placeholder = "Type Here..."
    var shouldShowPlaceholder:Bool { text.isEmpty && !keyboardFocused }
    var body: some View {
        ZStack(alignment: .topLeading) {
            if shouldShowPlaceholder {
                Text(placeholder)
                    .padding(.top, 10)
                    .padding(.leading, 6)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        keyboardFocused = true
                    }
            }
            
            TextEditor(text: $text)
                .colorMultiply(shouldShowPlaceholder ? .clear : .white)
                .focused($keyboardFocused)
        }
    }
}
