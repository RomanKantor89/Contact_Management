//
//  ImagePicker.swift
//  Midterm_Test
//
//  Created by Eden Giterman on 2020-11-06.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import UIKit

class ImagePicker: UIImageView, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    let vc : UIViewController? = nil

    func viewDidLoad() {
           
       // load template photo
       self.image = UIImage.init(named: "pic")
           
    }
    
    
    // pick image clicked
       @IBAction func pickImage(_ sender: Any) {
           let ipc = UIImagePickerController()
           
           // pick image either from phone camera or library
           ipc.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
           ipc.delegate = self
           ipc.allowsEditing = false
        vc?.present(ipc, animated: true, completion: nil)
       }
       
       // check if there is image data in selected image and assign to UIImage
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
              
              if let image = info[.originalImage] as? UIImage {
                  self.image = image
              }
        vc?.dismiss(animated: true, completion: nil)
       }
       
       // close photo picker if cancel clicked
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        vc?.dismiss(animated: true, completion: nil)
        }
}
