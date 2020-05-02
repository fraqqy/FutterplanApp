//
//  StartscreenVC.swift
//  Futterplan
//
//  Created by Waldemar Ketterling on 13.04.20.
//  Copyright © 2020 Waldemar Ketterling. All rights reserved.
//

import UIKit

class StartscreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func todayButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            performSegue(withIdentifier: "segueToToday", sender: nil)
        case 1:
            performSegue(withIdentifier: "segueToWeek", sender: nil)
        case 2:
            performSegue(withIdentifier: "segueToCalendar", sender: nil)
        default:
            print("Error performing Segue")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
