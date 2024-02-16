//
//  AddNewUserView.swift
//  SecondApp
//
//  Created by MacBook27 on 15/02/24.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct AddNewUserView: View {
    @State var fullName: String = ""
    @State var mobileNumber: String = ""
    @State var email: String = ""
    @State var address: String = ""
    @State var imageURL: String = ""
    @Binding var closeView: Bool
    
    var imgURL: URL? {
        URL(string: imageURL)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImageView(imageURL: imgURL, placeholderImage: nil)
                FloatingLabelTextField($fullName, placeholder: "First Name", editingChanged: { (isChanged) in
                    
                }) {
                    
                }
                .frame(height: 70)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 60)
                
                FloatingLabelTextField($mobileNumber, placeholder: "Mobile Number", editingChanged: { (isChanged) in
                    
                }) {
                    
                }
                .frame(height: 70)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 15)
                
                FloatingLabelTextField($email, placeholder: "Email", editingChanged: { (isChanged) in
                    
                }) {
                    
                }
                .frame(height: 70)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 15)
                
                FloatingLabelTextField($address, placeholder: "Address/Location", editingChanged: { (isChanged) in
                    
                }) {
                    
                }
                .frame(height: 70)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 15)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        closeView.toggle()
                    } label: {
                        Text("Save")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        closeView.toggle()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct AddNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUserView(closeView: .constant(false))
    }
}

struct AsyncImageView: View {
    var imageURL: URL?
    var placeholderImage: String?

    var body: some View {
        if let imageURL = imageURL {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding(.top, 30)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding(.top, 30)
            }
        } else {
            // Placeholder if the imageURL is nil
            Image("personPic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding(.top, 30)
        }
    }
}
