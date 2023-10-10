//
//  PhotoSelectView.swift
//  lesson3
//
//  Created by Jack Xia on 10/10/2023.
//

import SwiftUI

// Extracting the selected image out from this View
struct PhotoSelectView: UIViewControllerRepresentable {
    
    var didPickImage: ( (UIImage) -> Void )?
    
    // Coordinator is a API from Apple to delegate data to other Views via Controllers
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var didPickImage: ( (UIImage) -> Void )?
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // If the image was selected
            if let image = info[.originalImage] as? UIImage {
                
                print(image)
                didPickImage?(image)
            }
        }
    }
    
    // Source type - we can select the picture source from Camera or Photolibrary
    let sourceType: UIImagePickerController.SourceType
    init(sourceType: UIImagePickerController.SourceType) {
        self.sourceType = sourceType
    }
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIImagePickerController()
        viewController.sourceType = sourceType
        
        // Our struct "Image picker" needs to provide coordinator from Context to handle the communication between Views, this via Controller delegate from PhotoSelectView
        viewController.delegate = context.coordinator
        
        context.coordinator.didPickImage = {image in
            didPickImage?(image)
        }
        
        return viewController
    }
    
    func makeCoordinator() -> Coordinator {
        print("Hello from Coordinator")
        return Coordinator()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct PhotoSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSelectView(sourceType: .photoLibrary)
    }
}
