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
