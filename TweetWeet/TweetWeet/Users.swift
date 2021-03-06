//
//  Users.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/22/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

class Users: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    

    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as String?
    }
}
