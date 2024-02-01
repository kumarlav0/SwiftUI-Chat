//
//  CameraController.swift
//  SecondApp
//
//  Created by MacBook27 on 10/01/24.
//

import UIKit
import SwiftUI
import PhotosUI

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        print("updateUIViewController.....")
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePickerCordinator {
        return ImagePickerCordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
}

class ImagePickerCordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    init(isShown : Binding<Bool>, image: Binding<UIImage?>) {
        _isShown = isShown
        _image   = image
    }
    
    //Selected Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image = uiImage
        isShown = false
    }
    
    //Image selection got cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image)
    }
}

struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView(showImagePicker: .constant(false), image: .constant(UIImage(named: "")))
    }
}

struct CustomSize {
    var width: CGFloat
    var height: CGFloat
}

extension UIImage {
    var aspectRatio: CGFloat {
        return self.size.width / self.size.height
    }
    
    var calculatedImageSize: CustomSize { // (width x height)
        if aspectRatio == 1 {
            return CustomSize(width: 300, height: 300)
        } else if aspectRatio > 1 {
            return CustomSize(width: 300, height: 300/aspectRatio)
        } else {
            return CustomSize(width: 300*aspectRatio, height: 300)
        }
    }
}
 // 2:3, 5:8, 8:3, 1:1
// 5 / 8 =  0.625
// 2 / 3 = 0.666
// 8 / 3 = 2.6666
// 1 / 1 = 1

// height  = 200 x 0.625 , height x aspectRation
// width  = 125
// width = height x aspectRation


// width = 200 / 2.6666 , width / aspectRation
// height = 75.0015
// height = width / aspectRation
