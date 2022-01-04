//
//  PhotoPicker.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/3/22.
//

import Foundation
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var profileImage: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.3),
                      let compressedImage = UIImage(data: data) else {
                          // implement error
                          return
                      }
                photoPicker.profileImage = compressedImage
            } else {
                // implement error handling
            }
            picker.dismiss(animated: true)
        }
        
    }
    
}
