//
//  JsonParserManager.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/03/24.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

//class JsonParserManager: NSObject {
//    var entries:NSMutableArray!
//    var tmpEntry:Entry!
//    var eName: String!
//    
//    func initWithURL() -> AnyObject {
//        entries = NSMutableArray()
//        tmpEntry = Entry()
//        eName = String()
////        startParse(url)
//        return self
//    }
//    
//    func startParse(url:NSURL,completion: (() -> Void)) -> (){
//        let json = JSON(nsurl:url)
//        
//        for(_,feed) in json {
////            println("-------------")
////            println(i)
//            
//            for (key, value) in feed {
////                println("\(key): \(value)")
//                
//                switch("\(key)"){
//                    case "title":
//                        tmpEntry.title = value.asString
//                    case "source":
//                        tmpEntry.source = value.asString
//                    case "link":
//                        tmpEntry.link = value.asString
//                    case "pubDate":
//                        tmpEntry.date = value.asString
//                    default:
//                        print("error feed")
//                }
//            }
//            
//            entries.addObject(tmpEntry)
//            //初期化
//            tmpEntry = Entry()
//        }
//        
//        completion()
//    }
//}