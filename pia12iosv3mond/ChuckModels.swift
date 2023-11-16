//
//  ChuckModels.swift
//  pia12iosv3mond
//
//  Created by Mohamad Hleihel on 2023-11-16.
//

import Foundation


struct Chucknorrisinfo : Codable {
    var id : String
    var created_at : String
    var value : String
}


struct ChucknorrisSearchresult : Codable {
    var total : Int
    var result : [Chucknorrisinfo]
}
