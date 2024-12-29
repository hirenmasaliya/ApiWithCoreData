//
//  CoreDataService.swift
//  TaskApiWithCoreData
//
//  Created by Hiren Masaliya on 29/12/24.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {
    
    func saveData(jokeObject : JokeModel){
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let manageContext = delegate.persistentContainer.viewContext
        
        guard let jokeEntity = NSEntityDescription.entity(forEntityName: "Jokes", in: manageContext) else{return}
        
        let joke = NSManagedObject(entity: jokeEntity, insertInto: manageContext)
        
        joke.setValue(jokeObject.id, forKey: "id")
        joke.setValue(jokeObject.type, forKey: "type")
        joke.setValue(jokeObject.setup, forKey: "setup")
        joke.setValue(jokeObject.punchline, forKey: "punchline")
        
        do {
            try manageContext.save()
            debugPrint("Data Save Successfully")
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
}
