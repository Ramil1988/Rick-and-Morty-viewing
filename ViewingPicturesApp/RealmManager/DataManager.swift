//
//  DataManager.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-09-01.
//

import Foundation
import RealmSwift

class DataManager  {
    let realm  = try! Realm()
    
    func saveData(name: String, status: String, gender: String, location: String, image: String) {
        let data = RickAndMortyObjects()
        data.name = name
        data.status = status
        data.gender = gender
        data.location = location
        data.image = image
  
        try? realm.write {
            realm.add(data)
        }
    }
    
    func getData() -> [GeneralTableViewCellModel] {
        let savedData = realm.objects(RickAndMortyObjects.self)
        var models = [GeneralTableViewCellModel]()
        
        for result in savedData {
            let name = result.name
            let status = result.status
            let gender = result.gender
            let location = result.location
            let image = result.image
            
            let model = GeneralTableViewCellModel(name: name, status: status, gender: gender, location: location, image: image)
            models.append(model)
            
        }
        
        return models
    }
}


