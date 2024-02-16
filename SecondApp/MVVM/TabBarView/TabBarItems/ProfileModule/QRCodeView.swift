//
//  QRCodeView.swift
//  SecondApp
//
//  Created by MacBook27 on 08/01/24.
//

import SwiftUI
import UIKit
import CodeScanner

struct QRCodeView: View {
    @Binding var qrCodeViewOpenned: Bool
    @Binding var scannedQRCodeData: String?
    @State private var isSharePresented: Bool = false
    @State private var isShowingScanner = false
    
    var body: some View {
       
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        
                        Text("Kumar Lav")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .padding(.top, 45)
                        Spacer()
                        QRCodeGenerator(text: QRGenerator.shared.loadUserDataAsString() ?? "")
                            
                    }
                  
                    .frame(width: 300, height: 300)
                    .background(Color("darkbg"))
                    .cornerRadius(12)
                    .padding(.top, 70)
                    .overlay(alignment: .top, content: {
                        Image("personPic")
                            .resizable()
                            .frame(width: 66, height: 66)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 33))
                            .padding(.top, 40)
                        
                    })
                    
                    Spacer()
                    Button {
                        print("here......")
                        isSharePresented.toggle()
                    } label: {
                        Text("Share Code")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .frame(width: 200)
                    }
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .background(Color.accentColor)
                    .cornerRadius(8)
                    .sheet(isPresented: $isSharePresented, onDismiss: {
                        print("Dismiss")
                    }, content: {
                        let qrCode = QRGenerator.shared.getQRCodeFrom(text: QRGenerator.shared.loadUserDataAsString() ?? "")
                        ActivityViewController(activityItems: [qrCode as Any])
                    })
                }
            }
            .navigationBarTitle("QR Code")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanner.toggle()
                    } label: {
                        Text("Scan")
                    }
                    .sheet(isPresented: $isShowingScanner) {
                        CodeScannerView(codeTypes: [.qr], manualSelect: true, showViewfinder: true, manualTorch: true) { response in
                            print("QR Scanned Result", response)
                            if case let .success(result) = response {
                                isShowingScanner.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                    scannedQRCodeData = result.string
                                    qrCodeViewOpenned.toggle()
                                }
                            } else if case let .failure(error) = response {
                                print("Error occurred: \(error)")
                                
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        qrCodeViewOpenned.toggle()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(qrCodeViewOpenned: .constant(false), scannedQRCodeData: .constant(""))
    }
}
