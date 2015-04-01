//
//  URL.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/04/01.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

//let api = "https://keiba-news-api.herokuapp.com/"
enum URL:String{
    case MATOME = "https://keiba-news-api.herokuapp.com/matome"
    case PREDICT = "https://keiba-news-api.herokuapp.com/predict"
    case SPONAVI = "http://m.sports.yahoo.co.jp/keiba/schedule/list/"
    case MOVIE = "https://www.google.co.jp/search?hl=ja&q=%E7%AB%B6%E9%A6%AC&lr=lang_ja&gws_rd=ssl#q=%E7%AB%B6%E9%A6%AC&lr=lang_ja&hl=ja&tbs=lr:lang_1ja,qdr:d,srcf:H4sIAAAAAAAAANOuzC8tKU1K1UvOz1XLy0zOL8tMSc3XyypQy03MBPIzMkHsosTs0pLUPKAiEM8kPTE3tUgvL7VELSUxM6cSKgwAr8rCCEsAAAA&tbm=vid"
    case REALTIME = "http://realtime.search.yahoo.co.jp/search?fr=sfp_as&p=%E7%AB%B6%E9%A6%AC&ei=UTF-8&rkf=1"
    case NEWS = "https://www.google.co.jp/search?q=%E7%AB%B6%E9%A6%AC&lr=lang_ja&hl=ja&gl=jp&authuser=0&tbas=0&tbs=lr:lang_1ja,qdr:d&tbm=nws&source=lnt&sa=X&ei=LvAXVZ-NHYWomgXDroHYCw&ved=0CBMQpwU&biw=320&bih=568&dpr=2"
}