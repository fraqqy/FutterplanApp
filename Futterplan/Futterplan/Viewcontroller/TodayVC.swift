//
//  TodayVC.swift
//  Futterplan
//
//  Created by Waldemar Ketterling on 13.04.20.
//  Copyright © 2020 Waldemar Ketterling. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TodayVC: UIViewController {
    
    @IBOutlet weak var essenNameLabel: UILabel!
    @IBOutlet weak var essenZutatenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loadEssen(_ sender: UIButton) {
        let url = "http://192.168.100.2/futterplan/api/getfood.php"
        let parameters: [String: Any] = [
            "aufwand" : 1,
            "mode" : "random"
        ]
        AF.cancelAllRequests()
        
        AF.request(url, method:.post, parameters: parameters) .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.essenNameLabel.text = json["name"].stringValue
                self.essenZutatenLabel.text = json["zutaten"].stringValue
//
//                print(json["name"])
//                print("---------")
//
//
//
//                debugPrint(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
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
