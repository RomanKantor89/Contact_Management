//
//  FriendListTableViewController.swift
//  Created by Roman Kantor on 2020-11-06.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit

class FriendList: UITableViewController, addNewFriendProtocol{
    
    // implement the addNewFriend protocol
    func addNewFriendVCDidFinish(friend: Friend) {
        myModel?.addFriend(F: friend)
        tableView.reloadData()
    }
    
    var myModel : DataModelManager?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myModel?.allFriends.count ?? 0
    }

    // populate the cells with data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // sort the friends array by family name
        myModel?.allFriends = myModel?.allFriends.sorted(){ $0.fName < $1.fName} as! [Friend]

        // cell configuration
        cell.textLabel?.text = "\(myModel?.allFriends[indexPath.row].gName ?? "")"
        cell.detailTextLabel?.text = "\( myModel?.allFriends[indexPath.row].fName ?? "")"
        cell.imageView?.image = myModel?.allFriends[indexPath.row].photo
        
        return cell
    }

    // prepare data before moving to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "newFriend"{
            let addFriendVC = segue.destination as! FriendAdd
               addFriendVC.delegate = self
        }
        else {
            // assign selected cell data to friendSceneVC var in FriendScene class to display it
            let friendSceneVC = segue.destination as! FriendScene
            friendSceneVC.friendToDisplay = myModel?.allFriends[tableView.indexPathForSelectedRow!.row]
          }
    }
    

    // Allows to delete table cells
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.myModel?.allFriends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
