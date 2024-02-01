//
//  ProfileView.swift
//  SecondApp
//
//  Created by MacBook27 on 19/12/23.
//

import SwiftUI

struct ProfileView: View {
    @State var profileViewModel = ProfileViewModel()
    
    @State var openEditView: Bool = false
    @State var showAlert: Bool = false
    @State var qrCodeViewOpenned: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image("personPic")
                            .resizable()
                            .frame(width: 46, height: 46)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Mock User")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Text("Users a short bio will be visible here only. you can edit at any point of time.")
                                .fontWeight(.regular)
                                .font(.system(size: 12))
                                .lineLimit(3)
                        }
                        Spacer()
                        Button {
                            print("open QR code")
                            qrCodeViewOpenned.toggle()
                        } label: {
                            Image(systemName: "qrcode")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                                .foregroundColor(.black)
                               
                        }
                        .frame(width: 36, height: 36)
                        .background(.gray)
                        .clipShape(Circle())
                        .sheet(isPresented: $qrCodeViewOpenned) {
                            QRCodeView(closeWindow: $qrCodeViewOpenned)
                        }
                    }
                    
                    Button {
                        print("Edit....")
                        openEditView.toggle()
                    } label: {
                       Text("Edit Details")
                    }
                }
                
                Section {
                    ForEach(profileViewModel.settingOptions.indices, id: \.self) { index in
                        NavigationLink(destination: LocationsView()) {
                            HStack {
                                Text(profileViewModel.settingOptions[index].title)
                                    .font(.system(size: 16))
                            }
                        }
                    }
                }
                
                Section {
                    Text("App Version v6.0225")
                        .disabled(true)
                        .foregroundColor(.gray)
                }
                Section {
                    Button {
                        showAlert.toggle()
                    } label: {
                        Text("Logout")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .alert(isPresented: $showAlert) {
                        
                        Alert(title: Text("Are you sure you want to logout?"), primaryButton: .destructive(Text("Logout")) {
                            print("logout here..........")
                        }, secondaryButton: .cancel(Text("Cancel")))
                    }
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $openEditView) {
                EditProfileDetailsView()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
