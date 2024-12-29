//
//  ViewController.swift
//  TaskApiWithCoreData
//
//  Created by Hiren Masaliya on 29/12/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var segview: UISegmentedControl!
    
    @IBOutlet weak var table2: UITableView!
    @IBOutlet weak var table1: UITableView!
    
    var jokes : [JokeModel] = []
    var coreJoke : [JokeModel] = []
    
    var joke : JokeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        setupTableView()
        table2.isHidden = true
        
        fetchData()
        
        
        UserDefaults.standard.set("Hiren Masaliya", forKey: "Name")
        
        var name = UserDefaults.standard.string(forKey: "Name")
        print(name ?? "Hello")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if jokes.isEmpty {
            ApiServices().apiCall { res in
                switch res {
                case .success(let data):
                    self.jokes.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self.table1.reloadData()
                    }
                    
                case .failure(let failure):
                    debugPrint(failure)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableReload()
        }
        
        
    }

    @IBAction func segmentTab(_ sender: Any) {
        
        if(segview.selectedSegmentIndex == 0){
            table1.isHidden = false
            table2.isHidden = true
            table1.reloadData()
        }else if (segview.selectedSegmentIndex == 1){
            table1.isHidden = true
            table2.isHidden = false
            tableReload()
        }
        
    }
    
    func tableReload(){
        coreJoke.removeAll()
        fetchData()
        self.table2.reloadData()
    }
    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setupTableView(){
        table1.dataSource = self
        table1.delegate = self
        
        table2.dataSource = self
        table2.delegate = self
        
        table1.register(UINib(nibName: "TVCell", bundle: nil), forCellReuseIdentifier: "TVCell")
        table2.register(UINib(nibName: "TVCell", bundle: nil), forCellReuseIdentifier: "TVCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == table1 {
            return jokes.count
        } else if tableView == table2 {
            return coreJoke.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TVCell

        if tableView == table1{
            
            cell.txt1.text = jokes[indexPath.row].setup
            cell.txt2.text = jokes[indexPath.row].punchline
            
        }else if tableView == table2{
           
            cell.txt1.text = coreJoke[indexPath.row].setup
            cell.txt2.text = coreJoke[indexPath.row].punchline
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        joke = jokes[indexPath.row]
        CoreDataService().saveData(jokeObject: joke)
        
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == table2 {
            let delete = UIContextualAction.init(style: .normal, title: "Delete") { (action, view, nil) in
                let id = self.coreJoke[indexPath.row].id
                self.deleteData(id: Int32(id))
                self.removeInArray(index: indexPath)
            }
            
            delete.backgroundColor = .red
            
            let config = UISwipeActionsConfiguration(actions: [delete])
            tableView.reloadRows(at: [indexPath], with: .none)
            return config
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == table2 {
            let update = UIContextualAction.init(style: .normal, title: "Update") { (action,view,nil) in
                self.joke = self.coreJoke[indexPath.row]
                self.performSegue(withIdentifier: "secondVC", sender: self)
            }
            
            let config = UISwipeActionsConfiguration(actions: [update])
            
            
            return config
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondVC"{
            if let data = segue.destination as? SecondVC{
                data.selectedJoke = joke
            }
        }
    }
    
    
    func fetchData(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let manageContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        do {
            let res = try manageContext.fetch(fetchRequest)
            
            for data in res as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! Int32
                let type = data.value(forKey: "type") as! String
                let setup = data.value(forKey: "setup") as! String
                let punchline = data.value(forKey: "punchline") as! String
                
                coreJoke.append(JokeModel(id: Int(id), type: type, setup: setup, punchline: punchline))
            }
            
            
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func deleteData(id : Int32){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let manageContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Jokes")
        
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let res = try manageContext.fetch(fetchRequest)
            
            let object = res[0];
            
            manageContext.delete(object)
            try manageContext.save()
            debugPrint("Record is Delete")
            
        } catch let err as NSError {
            debugPrint(err)
        }
    }
    
    func removeInArray(index: IndexPath){
        coreJoke.remove(at: index.row)
        DispatchQueue.main.async {
            self.table2.reloadData()
        }
    }
    
    
}



