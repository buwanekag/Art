//
//  NetworkManager.swift
//  Art
//
//  Created by Buwaneka Galpoththawela on 6/15/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    

    
    static let sharedInstance = NetworkManager()
    var serverReach: Reachability?
    var serverAvailable = false
    
    func reachabilityChanged(note: NSNotification) {
        let reach = note.object as! Reachability
        serverAvailable = !(reach.currentReachabilityStatus().rawValue == NotReachable.rawValue)
        if serverAvailable {
            print("changed: server available")
        }else {
            print("changed: server not available")
        }


    }

}
