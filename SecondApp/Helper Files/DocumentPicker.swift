//
//  DocumentPicker.swift
//  SecondApp
//
//  Created by MacBook27 on 11/01/24.
//

import UIKit
import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    
    @Binding var fileContent: URL?
    
    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator(fileContent: $fileContent)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let controller: UIDocumentPickerViewController
        controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text, .pdf, .folder, .jpeg, .png, .gif, .exe, .data], asCopy: true)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }
}


class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    
    @Binding var fileContent: URL?
    
    init(fileContent: Binding<URL?>) {
        _fileContent = fileContent
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
  
//        guard url.startAccessingSecurityScopedResource() else {
//            // Handle denied access
//            return
//        }
//        defer { url.stopAccessingSecurityScopedResource() }
        
        let fileURL = url
        print("url: \(fileURL)")
        
        fileContent = fileURL
    }
}
