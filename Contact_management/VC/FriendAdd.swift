//  FriendAdd.swift
//  Created by Roman Kantor on 2020-11-06.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit

// protocol to do after new friend added
protocol addNewFriendProtocol {
    func addNewFriendVCDidFinish(friend : Friend)
}

class FriendAdd: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // all the input field connectors
    @IBOutlet weak var familyName: UITextField!
    @IBOutlet weak var givenName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var bDate: UITextField!
    // error message for the alert
    var errMsg : String?
    
    // protocol instance
    var delegate : addNewFriendProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup birthday date text field as inputView for date picker
        bDate.inputView = datePicker
        
        // load template photo
        pickedImage.image = UIImage.init(named: "pic")
        
        //Looks for single or multiple taps to close the keyboard and date picker
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
    
    // Alert Functionality Begins ---------------------------------
    
    // check for errors before saving
    func checkForErrors() -> Bool {
        var check = false
        
        if (familyName.text == "" || givenName.text == "" || gender.text == "" || city.text == "" || bDate.text == "" || pickedImage.image == nil || pickedImage.image == UIImage.init(named: "pic")){
            
            errMsg = "Please fill all the fields"
            check = true
            }
        else{
           // verification for date format
           let num =  bDate.text?.components(separatedBy:"/")
           let dateFieldCount = num?.count ?? 0
           
           if(dateFieldCount != 3){
               errMsg = "Date format is wrong!"
            check = true
           }
        }
        return check
    }
    
    // Alert setup
    @IBAction func showAlert() {
        
        // Configure the alert's button actions
        let errorAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            //do nothing
        }
        
        let successAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            self.addFriend()
        }
    
        if (checkForErrors()){
            let alert = UIAlertController(title: "Error", message: errMsg, preferredStyle: .alert)
                       
            alert.addAction(errorAction)
            self.present(alert, animated: true, completion: nil)
        }
        else{
           let alert = UIAlertController(title: "Success", message: "Friend added successfully!", preferredStyle: .alert)
           alert.addAction(successAction)
           self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // addFriend called from showAlert method if all fields are correct
     func addFriend() {
         // create a new objec with input values
         let newFriend = Friend(famN: familyName.text ?? "", givN: givenName.text ?? "", gen: gender.text ?? "", cit: city.text ?? "", ph : (pickedImage.image ?? UIImage.init(named:"pic"))!, bd : bDate.text ?? "")
         
         delegate?.addNewFriendVCDidFinish(friend: newFriend)
         navigationController?.popViewController(animated: true)
     }
    @IBAction func cancelClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // Date Picker Functionality -----------------------------------
    var datePicker: UIDatePicker {
      get {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self,
          action: #selector(onDateChanged(sender:)),
          for: .valueChanged)
        datePicker.backgroundColor = UIColor.white
        return datePicker
      }
    }
    
    // called when date is changed in the picker
    @objc func onDateChanged(sender: UIDatePicker) {
        // Format the date
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        
        // assign new date to the text field
        let newDate = formatter.string(from: sender.date)
        bDate.text = newDate
    }
    
    // Image Functionality ----------------------------------------------
    // pick image clicked
    @IBAction func pickImage(_ sender: Any) {
        let ipc = UIImagePickerController()

        // pick image either from phone camera or library
        ipc.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        ipc.delegate = self
        ipc.allowsEditing = false
        present(ipc, animated: true, completion: nil)
    }

    // check if there is image data in selected image and assign to UIImage
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

           if let image = info[.originalImage] as? UIImage {
               pickedImage.image = image
           }
           dismiss(animated: true, completion: nil)
    }

    // close photo picker if cancel clicked
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
         dismiss(animated: true, completion: nil)
     }
}
