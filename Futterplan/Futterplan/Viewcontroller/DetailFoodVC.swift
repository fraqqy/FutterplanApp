//
//  DetailFoodVC.swift
//  Futterplan
//
//  Created by Waldemar Ketterling on 30.04.20.
//  Copyright © 2020 Waldemar Ketterling. All rights reserved.
//

import UIKit

class DetailFoodVC: UIViewController {
    
    var foodName = String()
    var foodRezept = String()
    var foodZutaten = String()
    
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodZutatenText: UITextView!
    @IBOutlet weak var foodRezeptText: UITextView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodNameLabel.text = foodName
        foodZutatenText.text = foodZutaten
        foodRezeptText.text = foodRezept

    }
    



}
