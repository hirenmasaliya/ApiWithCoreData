//
//  JokeModel.swift
//  TaskApiWithCoreData
//
//  Created by Hiren Masaliya on 29/12/24.
//

import Foundation


struct JokeModel : Codable{
    var id : Int
    var type : String
    var setup : String
    var punchline : String
}
