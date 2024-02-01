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
    @Binding var closeWindow: Bool
    @State private var isSharePresented: Bool = false
    @State private var isShowingScanner = false
    @State private var scannedCode: String?
    
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
                        Image("qrcode")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(12)
                            .padding(.bottom, 30)
                        
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
                            .clipShape(Circle())
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
                        ActivityViewController(activityItems: [UIImage(named: "qrcode") as Any])
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
                            if case let .success(result) = response {
                                scannedCode = result.string
                                isShowingScanner.toggle()
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        closeWindow.toggle()
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
        QRCodeView(closeWindow: .constant(false))
    }
}

/**
 codeTypes: [AVMetadataObject.ObjectType],
 scanMode: ScanMode = .once,
 manualSelect: Bool = false,
 scanInterval: Double = 2.0,
 showViewfinder: Bool = false,
 simulatedData: String = "",
 shouldVibrateOnSuccess: Bool = true,
 isTorchOn: Bool = false,
 isGalleryPresented: Binding<Bool> = .constant(false),
 videoCaptureDevice: AVCaptureDevice? = AVCaptureDevice.bestForVideo
 
 */
