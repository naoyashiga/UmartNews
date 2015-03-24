//
//  XmlParserManager.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/31.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class XmlParserManager: NSObject, NSXMLParserDelegate {
    var entries:NSMutableArray!
    var tmpEntry:Entry!
    var eName: String!
    
    func initWithURL(url:NSURL) -> AnyObject {
        entries = NSMutableArray()
        tmpEntry = Entry()
        eName = String()
        startParse(url)
        return self
    }
    
    func startParse(url:NSURL){
        var parser: NSXMLParser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        eName = elementName
        
        if elementName == "item" || elementName == "entry" {
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(!data.isEmpty) {
            if eName == "title" {
                tmpEntry.title = tmpEntry.title + data
            } else if eName == "link" {
                tmpEntry.link = data
            } else if eName == "pubDate" || eName == "published" || eName == "dc:date" {
                tmpEntry.date = data
            }
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if elementName == "generator" || elementName == "channel" {
            //サイトの名前
            tmpEntry.source = tmpEntry.title
            //初期化
            tmpEntry.title = ""
        }
        
        if elementName == "item" || elementName == "entry" {
            var tmpSiteName = tmpEntry.source
            tmpEntry.date = changeDateStyle(tmpEntry.date)
            
            entries.addObject(tmpEntry)
            //初期化
            tmpEntry = Entry()
            //サイトネームは以前のまま
            tmpEntry.source = tmpSiteName
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser!) {
    }
    
    func changeDateStyle(date:String) -> String{
        //12月30日
        var monthAndDay = date.componentsSeparatedByString("T")[0]
        var monthAndDayArray = monthAndDay.componentsSeparatedByString("-")
        monthAndDay = monthAndDayArray[1] + "/" + monthAndDayArray[2]
        
        //09:00
        var hourAndMinute = date.componentsSeparatedByString("T")[1]
        var hourAndMinuteArray = hourAndMinute.componentsSeparatedByString(":")
        hourAndMinute = hourAndMinuteArray[0] + ":" + hourAndMinuteArray[1]
        
        return monthAndDay + " " + hourAndMinute
    }
}
