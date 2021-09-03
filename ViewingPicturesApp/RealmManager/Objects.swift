//
//  Objects.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-09-01.
//

import Foundation
import RealmSwift

class RickAndMortyObjects: Object {
    @objc dynamic var name = ""
    @objc dynamic var status = ""
    @objc dynamic var gender = ""
    @objc dynamic var location = ""
    @objc dynamic var image = ""
}
