//
//  PDFViewer.swift
//  SecondApp
//
//  Created by MacBook27 on 22/01/24.
//

import SwiftUI
import PDFKit

struct PDFBubble: View {
    let pdfURL: URL
    @State var showPDFViewer: Bool = false

    var body: some View {
        VStack {
            ZStack {
                PDFKitView(pdfURL: pdfURL)
                    .frame(width: 250,height: 60)
                Rectangle()
                    .frame(width: 250,height: 60)
                    .opacity(0.5)
                Button {
                    print("Clicked...")
                } label: {
                    Image("cloud-download")
                        .resizable()
                        .frame(width: 46,height: 46)
                        .foregroundColor(.white)
                }
            }
            HStack {
                Image("pdf")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                Text("PDF File Click to View")
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            showPDFViewer.toggle()
        }
        .sheet(isPresented: $showPDFViewer) {
            PDFKitView(pdfURL: pdfURL)
        }
    }
}

struct PDFViewer: View {
    let pdfURL: URL

    var body: some View {
        PDFKitView(pdfURL: pdfURL)
            .navigationBarTitle("PDF Viewer", displayMode: .inline)
    }
}

struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        let localURL = Bundle.main.url(forResource: "jokes1", withExtension: "pdf")!
        return PDFBubble(pdfURL: localURL)
    }
}

struct PDFKitView: UIViewRepresentable {
    let pdfURL: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let document = PDFDocument(url: pdfURL) {
            uiView.document = document
        }
    }
}
