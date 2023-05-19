//
//  Data.swift
//  2021a0519
//
//  Created by hokyun Kim on 2023/05/19.
//

import Foundation

struct Data :Codable{
    var chartList : [Chart]
}

struct Chart :Codable{
    let id : Int
    let rank : Int
    let title : String
    let singer : String
    let imageUrl : String
}

struct DataDetail : Codable{
    let chart : ChartDetail
}
struct ChartDetail :Codable{
    let id : Int
    let title : String
    let singer : String
    let melodizer : String
    let lyricist : String
    let genre : String
}

/*
 
 {
   "chart": {
     "id": 1,
     "title": "Celebrity",
     "singer": "아이유",
     "melodizer": "Ryan S.Jhun, Jeppe London Bilsby, Lauritz Emil Christiansen, 아이유(IU), Chloe Latimer, Celine Svanback",
     "lyricist": "아이유",
     "genre": "댄스"
   }
 }
 */
