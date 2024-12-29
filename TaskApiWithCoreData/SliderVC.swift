//
//  SliderVC.swift
//  TaskApiWithCoreData
//
//  Created by Hiren Masaliya on 29/12/24.
//

import UIKit

class SliderVC: UIViewController {

    @IBOutlet weak var UiView: UIView!
    @IBOutlet weak var s4: UISlider!
    @IBOutlet weak var s3: UISlider!
    @IBOutlet weak var s2: UISlider!
    @IBOutlet weak var s1: UISlider!
    
    var r : CGFloat!
    var g : CGFloat!
    var b : CGFloat!
    var o : CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func changeColor(r:CGFloat,g:CGFloat,b:CGFloat,o:CGFloat){
        UiView.backgroundColor = UIColor(red: r/255, green: g/255, blue: b/255, alpha: o)
        
        self.view.backgroundColor = UIColor(red: r/255, green: g/255, blue: b/255, alpha: o)
    }
    

    @IBAction func s1Action(_ sender: Any) {
        r = CGFloat(s1.value)
        g = CGFloat(s2.value)
        b = CGFloat(s3.value)
        o = CGFloat(s4.value)
        
        changeColor(r: r, g: g, b: b, o: o)
    }
    
    @IBAction func s2Action(_ sender: Any) {
        r = CGFloat(s1.value)
        g = CGFloat(s2.value)
        b = CGFloat(s3.value)
        o = CGFloat(s4.value)
        
        changeColor(r: r, g: g, b: b, o: o)
    }
    
    @IBAction func s3Action(_ sender: Any) {
        r = CGFloat(s1.value)
        g = CGFloat(s2.value)
        b = CGFloat(s3.value)
        o = CGFloat(s4.value)
        
        changeColor(r: r, g: g, b: b, o: o)
    }
    
    
    @IBAction func s4Action(_ sender: Any) {
        r = CGFloat(s1.value)
        g = CGFloat(s2.value)
        b = CGFloat(s3.value)
        o = CGFloat(s4.value)
        
        changeColor(r: r, g: g, b: b, o: o)
    }
}
