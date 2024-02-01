//
//  OTPView.swift
//  SecondApp
//
//  Created by MacBook27 on 24/12/23.
//

import SwiftUI

struct OTPView: View {
    let numberOfOTPFields: Int = 6
    @State private var otpValues: [String] = Array(repeating: "", count: 6)
    @State private var isResendAllowed = false
    
    @State private var totalSeconds = 22
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var openTabBarView = false
    
    var body: some View {
        if openTabBarView {
            TabBarView()
        } else {
            ZStack {
                Color.mint
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Verify your number")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                    
                    Text("Enter the code we'he sent by text to\n+9162******46")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .padding(.top, 1)
                    
                    Button(action: {
                        // Resend action
                        loginViewModel.isLoggedIn.toggle()
                    }) {
                        Text("Change")
                            .foregroundColor(.black)
                            .underline()
                            .fontWeight(.bold)
                    }
                    .padding(.top,1)
                    
                    Text("Code")
                        .font(.system(size: 14))
                        .padding(.top, 35)
                    
                    HStack(spacing: 10) {
                        OTPTextField(numberOfFields: 6)
                    }
                    .padding(.top, -12)
                    
                    Spacer()
                    HStack {
                        Text("This code should arrive within \(totalSeconds)s")
                            .font(.system(size: 14))
                            .padding(.bottom, 20)
                        Spacer()
                        
                        Button(action: {
                            openTabBarView.toggle()
                        }) {
                            Image(systemName: "chevron.forward.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                        }
                        .frame(width: 46, height: 46)
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                    
                }
                .padding(.leading, 20)
            }
        }
    }
}

struct OTPTextField: View {
    let numberOfFields: Int
    
    @State var enterValue: [String]
    @FocusState private var fieldFocus: Int?
    @State private var oldValue = ""
    @FocusState private var isTextFieldFocused: Bool
    
    init(numberOfFields: Int) {
        self.numberOfFields = numberOfFields
        self.enterValue = Array(repeating: "", count: numberOfFields)
    }
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfFields, id: \.self) { index in
                TextField("\(index+1)", text: $enterValue[index], onEditingChanged: { editing in
                    if editing {
                        oldValue = enterValue[index]
                    }
                })
                .cornerRadius(8)
                .frame(width: 30, height: 50)
                .font(.system(size: 22))
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($fieldFocus, equals: index)
                .tag(index)
                .onChange (of: enterValue[index]) { newValue in
                    
                    if enterValue[index].count > 1 {
                        let currentValue = Array(enterValue[index])
                        
                        if currentValue[0] == Character(oldValue) {
                            enterValue[index] = String(enterValue[index].suffix(1))
                        } else {
                            enterValue[index] = String(enterValue[index].prefix(1))
                        }
                    }
                    
                    if !newValue.isEmpty {
                        if index == numberOfFields - 1 {
                            fieldFocus = nil
                        } else {
                            fieldFocus = (fieldFocus ?? 0) + 1
                        }
                    } else {
                        fieldFocus = (fieldFocus ?? 0) - 1
                    }
                }
            }
        }
    }
}
