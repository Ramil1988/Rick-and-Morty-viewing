//
//  NetworkServiceVC.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-08-31.
//

import Foundation
import Alamofire

final class NetworkService: NSObject {

    private let jsonUrl = "https://rickandmortyapi.com/api/character"
    
    func getCharacterFromAF(completion: @escaping (CharacterModel) -> Void)  {
        AF.request(jsonUrl, method: .get).responseJSON { response in
            guard let data = response.data else { return }
            
            do {
                let resultJsonModel = try JSONDecoder().decode(CharacterModel.self, from: data)
                completion(resultJsonModel)
            }
            catch {
                print("Ошибка парсинга данных")
            }
        }
    }
}




