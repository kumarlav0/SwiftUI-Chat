//
//  LoginViewModel.swift
//  SecondApp
//
//  Created by Kumar Lav on 27/12/23.
//

import Foundation

class LoginViewModel: ObservableObject {
  
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var email: String = ""
    
    func performLogin() {
        DispatchQueue.main.async {
            self.isLoading = true
            // Simulate API request/response delay using async/await
            Task {
                await self.loginUser()
                self.isLoading = false
                self.isLoggedIn = true
            }
        }
    }
    
    func loginUser() async {
        try? await Task.sleep(nanoseconds: 0 * 1_000_000_000) // 2 seconds delay
        print("Login successful")
    }
}

extension LoginViewModel {
    func validateFields(mobileNumber: String) -> Bool {
        !mobileNumber.isEmpty
    }
}
