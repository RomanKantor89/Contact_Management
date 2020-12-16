//  DataModelManager.swift
//
//  Created by Roman Kantor on 2020-11-06.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import Foundation

class DataModelManager {
    var allFriends = [Friend]()
    
    // method to add a friend to allFriends array
    func addFriend(F : Friend){
        allFriends.append(F)
    }
    
}
