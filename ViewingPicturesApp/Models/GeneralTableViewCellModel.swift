//
//  GeneralTableViewCellModel.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-09-02.
//

import Foundation

struct GeneralTableViewCellModel {
    let name: String
    let status: String
    let gender: String
    let location: String
    let image: String
    
    init(response: Result) {
        self.name = response.name
        self.status = response.status.rawValue
        self.gender = response.gender.rawValue
        self.location = response.location.name
        self.image = response.image
    }
    
    init(name: String, status: String, gender: String, location: String, image: String) {
        self.name = name
        self.status = status
        self.gender = gender
        self.location = location
        self.image = image
    }
}
