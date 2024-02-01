//
//  ChatBubbleView.swift
//  SecondApp
//
//  Created by MacBook27 on 15/12/23.
//

import SwiftUI
import WebKit
import ImageViewer

struct ChatBubble: View {
    let hasDoubleTick: Bool = true
    let message: Message
    
    @State private var isContextMenuVisible = false
    
    @GestureState private var isDragging = false
    @State private var draggedBubble: String? = nil
    @State private var originalIndex: Int? = nil
    
    var body: some View {
        HStack {
            if message.senderType.isOutgoing {
                Spacer()
                BubbleContent()
                    .background(.clear)
            } else {
                BubbleContent()
                    .background(.clear)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func BubbleContent() -> some View {
        VStack(alignment: message.senderType.isOutgoing ? .trailing : .leading, spacing: 4) {
            if message.messageType == .text {
                Text(message.text ?? "")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(message.senderType.bubbleBackgroundColor)
                    .clipShape(RoundedCornerShape(isOutgoing: message.senderType.isOutgoing))
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: message.senderType.isOutgoing ? .trailing : .leading)
            } else if message.messageType == .image {
                BubbleImage(message: message)
            } else if message.messageType == .pdf {
                PDFBubble(pdfURL: message.mediaUrl!)
                    .background(message.senderType.bubbleBackgroundColor)
                    .clipShape(RoundedCornerShape(isOutgoing: message.senderType.isOutgoing))
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: message.senderType.isOutgoing ? .trailing : .leading)
            } else {
                Text(message.text ?? "")
                    .frame(width: 80, height: 80, alignment: message.senderType.isOutgoing ? .trailing : .leading)
                    .font(.system(size: 80))
                    .background(.clear)
            }
            HStack {
                Text(message.date.chatTime())
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                if message.senderType.isOutgoing {
                    CheckmarkIcon(delivaryStatus: message.deliveryStatus)
                }
            }
        }
        
    }
    
    private var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.5)
            .onEnded { _ in
                // Handle long press action here if needed
                print("here we rrrrrr.....")
            }
    }
    
    private func contextMenuItems() -> some View {
        VStack {
            Button(action: {
                // Copy action
                // Implement copy logic here
            }) {
                Label("Copy", systemImage: "doc.on.doc")
            }
            Button(action: {
                // Favourite action
                // Implement copy logic here
            }) {
                Label("Favourite", systemImage: "bolt.heart")
            }
            Button(action: {
                // Delete action
                // Implement delete logic here
            }) {
                Label("Delete", systemImage: "trash")
            }
            
            Button(action: {
                // Forward action
                // Implement forward logic here
            }) {
                Label("Forward", systemImage: "arrowshape.turn.up.right")
            }
        }
    }
}

//struct ChatBubbleView_Previews: PreviewProvider {
//    static var previews: some View {
//        let message1 = Message(messageId: Int.uniqueId, messageType: .singleEmoji, text: "🫠", date: Date(), senderType: .outgoing)
//        ChatBubble(message: message1)
//    }
//}

struct CheckmarkIcon: View {
    let delivaryStatus: DeliveryStatus
    
    var body: some View {
        Image(delivaryStatus.icon)
            .resizable()
            .scaledToFit()
            .padding(1)
            .foregroundColor(delivaryStatus.tintColor)
            .frame(width: 18,height: 18)
    }
}

struct RoundedCornerShape: Shape {
    let isOutgoing: Bool
    let corners: UIRectCorner
    let radius: CGFloat
    
    init(isOutgoing: Bool, radius: CGFloat = 10) {
        self.radius = radius
        self.isOutgoing = isOutgoing
        if self.isOutgoing {
            self.corners = [.topLeft, .topRight, .bottomLeft]
        } else {
            self.corners = [.topLeft, .topRight, .bottomRight]
        }
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct BubbleImage: View {
    @State var showImageViewer: Bool = false
    let message: Message
    @State var image: Image
    
    init(message: Message) {
        self.message = message
        self._image = State(initialValue: message.media.map { Image(uiImage: $0) }!)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: message.media!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: message.media!.calculatedImageSize.width, height: message.media!.calculatedImageSize.height)
                .clipped()
                .onTapGesture {
                    showImageViewer.toggle()
                }
                .fullScreenCover(isPresented: $showImageViewer, content: {
                    ImageViewer(image: $image, viewerShown: $showImageViewer)
                })
        }
        .background(message.senderType.bubbleBackgroundColor)
        .clipShape(RoundedCornerShape(isOutgoing: message.senderType.isOutgoing))
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: message.senderType.isOutgoing ? .trailing : .leading)
        
    }
}

struct BubbleImage_Previews: PreviewProvider {
    static var previews: some View {
        let message1 = Message(messageId: Int.uniqueId, messageType: .image, date: Date(), senderType: .outgoing, media: UIImage(named: "personPic"))
        BubbleImage(message: message1)
    }
}

struct VideoPlayerView: UIViewRepresentable {
    let videoURL: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: videoURL) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

/*
 
 //                    .contextMenu {
 //                        contextMenuItems()
 //                    }
 //                    .onTapGesture(count: 1) {
 //                        // Tap action if needed
 //                    }
 //                    .onLongPressGesture {
 //                        isContextMenuVisible = true
 //                    }
 //                    .alert(isPresented: $isContextMenuVisible) {
 //                        Alert(title: Text("Long Pressed"), message: nil, dismissButton: .cancel())
 //                    }
 
 */
