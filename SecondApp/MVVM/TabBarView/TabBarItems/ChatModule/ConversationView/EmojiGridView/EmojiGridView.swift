//
//  EmojiGridView.swift
//  SecondApp
//
//  Created by MacBook27 on 21/12/23.
//
import SwiftUI

struct EmojiGridView: View {
    
    @State var selectedEmoji: String = ""
    @Binding var isSelected: Bool
    var emojis: [String] = []
    @ObservedObject var chatViewModel: ConversationViewModel
    
    init(isSelected: Binding<Bool>, chatViewModel: ConversationViewModel) {
        self._isSelected = isSelected
        self.chatViewModel = chatViewModel
        
        var emojisArray: [String] = []
        for i in 0x1F600...0x1F64F {
            if let emoji = UnicodeScalar(i) {
                emojisArray.append(String(emoji))
            }
        }
        self.emojis = emojisArray
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 4), spacing: 10) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .frame(width: 80, height: 80)
                        .font(.system(size: 80))
                        .background(selectedEmoji == emoji ? Color.blue : Color.clear)
                        .cornerRadius(10)
                        .onTapGesture {
                            chatViewModel.addEmojiMessage(emoji)
                            // Perform actions on selecting emoji
                            print("Selected emoji: \(emoji)")
                            isSelected.toggle()
                        }
                }
            }
            .padding()
        }
    }
}

struct EmojiGridView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGridView(isSelected: .constant(false), chatViewModel: ConversationViewModel())
    }
}
