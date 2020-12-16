//
//  DataModelClasses.swift
//  Created by Roman Kantor on 2020-11-06.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import Foundation
import UIKit

class Friend {
    var fName : String = ""
    var gName : String = ""
    var gender : String = ""
    var city : String = ""
    var photo : UIImage?
    var bday : String = ""
    
    init(famN : String, givN : String, gen : String, cit : String, ph : UIImage, bd : String) {
        fName = famN
        gName = givN
        gender = gen
        city = cit
        photo = ph
        bday = bd
    }
    
}
