//
//  QRCodeGenerator.swift
//  SecondApp
//
//  Created by MacBook27 on 13/02/24.
//

import SwiftUI

struct QRCodeGenerator: View {
    let text: String
    
    var body: some View {
        VStack {
            Image(uiImage: QRGenerator.shared.getQRCodeFrom(text: text))
                .resizable()
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(3)
                .padding(.bottom, 30)
            
        }
    }
}

struct QRView: View {
    var body: some View {
        VStack {
            QRCodeGenerator(text: "Hello, World!....")
        }
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView()
    }
}
