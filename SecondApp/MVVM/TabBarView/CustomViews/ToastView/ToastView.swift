//
//  ToastView.swift
//  SecondApp
//
//  Created by MacBook27 on 22/12/23.
//

import SwiftUI

struct ToastView: View {
    @Binding var isShowing: Bool
    let message: String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                if isShowing {
                    Text(message)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .transition(.move(edge: .bottom))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    isShowing = false
                                }
                            }
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

struct ContentView: View {
    @State private var showToast = false
    @State var message: String
    
    var body: some View {
        VStack {
            Button("Show Toast") {
                showToast = true
            }
        }
        .overlay(
            ToastView(isShowing: $showToast, message: message)
        )
    }
}


struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(isShowing: .constant(true), message: "Message here..")
    }
}
