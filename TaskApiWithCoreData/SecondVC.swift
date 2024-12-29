//
//  SecondVC.swift
//  TaskApiWithCoreData
//
//  Created by Hiren Masaliya on 29/12/24.
//

import UIKit
import CoreData

class SecondVC: UIViewController {

    @IBOutlet weak var etPunchline: UITextField!
    @IBOutlet weak var etSetup: UITextField!
    @IBOutlet weak var etType: UITextField!
    @IBOutlet weak var etId: UITextField!
    
    var selectedJoke : JokeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        etId.text = String(selectedJoke.id)
        etType.text = selectedJoke.type
        etSetup.text = selectedJoke.setup
        etPunchline.text = selectedJoke.punchline
        
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        
        let id = Int32(etId.text!)!
        let type = etType.text!
        let setup = etSetup.text!
        let punchline = etPunchline.text!
        
        updateData(jokeObj: JokeModel(id: Int(id), type: type, setup: setup, punchline: punchline))
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func updateData(jokeObj : JokeModel){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let manageContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        fetchRequest.predicate = NSPredicate(format: "id == %d", jokeObj.id)
        
        do {
            let res = try manageContext.fetch(fetchRequest)
            
            let obj = res[0] as! NSManagedObject
            obj.setValue(jokeObj.type, forKey: "type")
            obj.setValue(jokeObj.setup,forKey: "setup")
            obj.setValue(jokeObj.punchline,forKey: "punchline")
            
            try manageContext.save()
            debugPrint("Joke Data Update Successfully!")
            
            
        } catch let err as NSObject {
            debugPrint(err)
        }
        
        
    }
    

}
