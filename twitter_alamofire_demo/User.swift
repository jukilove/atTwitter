//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    //Add Properties for a given user - displaying a Tweet (Name&Screen Name)
    var name: String
    var screenName: String
    var profileImage: URL?
    
    static var currentUser: User?
    
    //create initializer with dictionary
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        profileImage = URL(string: dictionary["profile_image_url_https"] as! String)
        
        //Initialize any other properties
    }
    
}

