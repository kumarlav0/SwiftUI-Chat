//
//  LoginView.swift
//  SecondApp
//
//  Created by Kumar Lav on 22/12/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @State var isOTPOpenned = false
    
    @State private var isShowingAlert = false
    @StateObject var networkMonitor = NetworkMonitor()
    @State private var isShowNetworkAlert = false
    
    @State var alertMessage = ("Error ","Please enter mobile number")
    
    var body: some View {
        if loginViewModel.isLoggedIn {
            OTPView(loginViewModel: loginViewModel)
        } else {
            ZStack {
                GeometryReader { geometry in
                    Image("loginbg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 350)
                        .clipped()
                        .edgesIgnoringSafeArea(.leading)
                        .edgesIgnoringSafeArea(.trailing)
                        .edgesIgnoringSafeArea(.top)
                        .frame(width: geometry.size.width)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Welcome")
                            .font(.system(size: 42))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 5, leading: 30, bottom: 0, trailing: 30))
                        Text("Let's begin new journey with us")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 5, leading: 30, bottom: 0, trailing: 30))
                    }
                }
                
                GeometryReader { geometry in
                    ScrollView(showsIndicators: false) {
                        VStack {
                            VStack(alignment: .center) {
                                Text("Login")
                                    .foregroundColor(.black)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                
                                TextField("Email/Mobile Number", text: $loginViewModel.email)
                                    .padding()
                                    .keyboardType(.emailAddress)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .padding(.horizontal)
                                
                                Button(action: {
                                    if networkMonitor.isConnected {
                                        if loginViewModel.validateFields(mobileNumber: loginViewModel.email) {
                                            loginViewModel.performLogin()
                                        } else {
                                            alertMessage = ("Error ","Please enter mobile number")
                                            isShowingAlert.toggle()
                                        }
                                        
                                    } else {
                                        alertMessage = ("Network Error","Please connect your device to internet")
                                        isShowingAlert.toggle()
                                    }
                                }) {
                                    
                                    if loginViewModel.isLoading {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            
                                        } else {
                                            
                                            Text("Login")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20))
                                                .fontWeight(.bold)
                                                .frame(width: 260)
                                        }
                                }
                                .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                                .background(.black)
                                .cornerRadius(8)
                                .disabled(loginViewModel.isLoading)
                                .padding()
                                .alert(isPresented: $isShowingAlert) {
                                    Alert(
                                        title: Text(alertMessage.0),
                                        message: Text(alertMessage.1),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(16)
                            .padding(EdgeInsets(top: 230, leading: 20, bottom: 0, trailing: 20))
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                            
                            Spacer()
                            VStack {
                                Text("OR LOGIN WITH")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                
                                HStack(spacing: 30){
                                    Button {
                                        
                                    } label: {
                                        Image("apple-logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 22, height: 22)
                                            .foregroundColor(.white)
                                        Text("Apple")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                            .fontWeight(.bold)
                                    }
                                    .frame(width: 140, height: 46)
                                    .background(.black)
                                    .clipShape(Capsule())
                                    
                                    Button {
                                        
                                    } label: {
                                        Image("google")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 22, height: 22)
                                            .foregroundColor(.white)
                                        Text("Google")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                            .fontWeight(.bold)
                                    }
                                    .frame(width: 140, height: 46)
                                    .background(.black)
                                    .clipShape(Capsule())
                                }
                                .padding(.bottom, 20)
                            }
                        }
                        .frame(minHeight: geometry.size.height)
                    }.frame(width: geometry.size.width)
                }
               
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
