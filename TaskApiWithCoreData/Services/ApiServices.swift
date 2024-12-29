//
//  ApiServices.swift
//  TaskApiWithCoreData
//
//  Created by Hiren Masaliya on 29/12/24.
//

import Foundation
import Alamofire

class ApiServices {
    
    func apiCall(cv: @escaping(Result<[JokeModel],Error>)->Void){
        let urlstr = "https://official-joke-api.appspot.com/jokes/random/25"
        
        AF.request(urlstr).responseDecodable(of: [JokeModel].self) { res in
            switch res.result {
            case .success(let data):
                cv(.success(data))
            case .failure(let error):
                cv(.failure(error))
            }
        }
    }
}
