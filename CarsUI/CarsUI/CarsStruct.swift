//
//  CarsStruct.swift
//  CarsUI
//
//  Created by Владислав Баранов on 08.07.2024.
//

import Foundation

struct Company : Identifiable, Codable {
    var id: Int?
    let car : String?
    let carModels : [Models]?
}


struct Models : Codable, Identifiable {
    
    var id: Int?
    let name : String?
    var info : String?
    var imageName : String?
    
}
