//
//  Entry.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/28.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class Entry: NSObject {
    var id: String!
    var title: String!
    var link: String!
    var date: String!
    var source: String!
    
    override init(){
        super.init()
        title = String()
    }
   
}
