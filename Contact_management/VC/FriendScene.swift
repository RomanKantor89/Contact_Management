//  FriendScene.swift
//  Created by Roman Kantor on 2020-11-06.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit
class FriendScene: UIViewController {
    // variable to accept the data of selected friend from FriendList
    var friendToDisplay : Friend?
    
    // all the text field connectors
    @IBOutlet weak var familyName: UITextField!
    @IBOutlet weak var givenName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var birthdayDate: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // update all the text fields with received data from FriendList
        familyName.text = friendToDisplay?.fName
        givenName.text = friendToDisplay?.gName
        gender.text = friendToDisplay?.gender
        city.text = friendToDisplay?.city
        birthdayDate.text = friendToDisplay?.bday
        photoView.image = friendToDisplay?.photo
        // call the setup method
        setUpDoubleTap()
    }

     // functionality for zooming on the photo
      func setUpDoubleTap()  {
        // Handle double taps
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(self.tapDoubleHandler))
        tapDouble.numberOfTapsRequired = 2
        photoView?.addGestureRecognizer(tapDouble)
      }

      // Handle double tap
      @objc func tapDoubleHandler() {
        // Grow the shape by 15%
          let shapeNewFrame = CGRect(x: photoView.frame.origin.x, y: photoView.frame.origin.y, width: photoView.frame.width * 1.15, height: photoView.frame.height * 1.15)
        photoView.frame = shapeNewFrame
     }
    
}
