//
//  WeekVC.swift
//  Futterplan
//
//  Created by Waldemar Ketterling on 28.04.20.
//  Copyright © 2020 Waldemar Ketterling. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeekVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    
    
  
    @IBOutlet weak var weekTable: UITableView!
    
    
    let checkBoxSelected = UIImage(systemName: "checkmark.circle.fill")
      let checkBoxUnselected = UIImage(systemName: "circle")
    var wocheArray = ["MO", "DI", "MI", "DO", "FR", "SA", "SO"]
    var wocheEssenArray = ["-","-","-","-","-","-","-"]
    var wocheEssenIdArray = ["-","-","-","-","-","-","-"]

    override func viewDidLoad() {
        super.viewDidLoad()
        weekTable.delegate = self
        weekTable.dataSource = self

        // Do any additional setup after loading the view.
        
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(WeekVC.longPress(_:)))
           longPressGesture.minimumPressDuration = 1.0 // 1 second press
           longPressGesture.delegate = self
           self.weekTable.addGestureRecognizer(longPressGesture)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wocheEssenArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = wocheArray[indexPath.row]

        cell.detailTextLabel?.text = wocheEssenArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let url = "http://192.168.100.2/futterplan/api/getfood.php"
                let parameters: [String: Any] = [
//                    "aufwand" : 1,
                    "mode" : "random"
                ]
                AF.cancelAllRequests()

                AF.request(url, method:.post, parameters: parameters) .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)

                        self.wocheEssenArray[indexPath.row] = json["name"].stringValue
                        self.wocheEssenIdArray[indexPath.row] = json["id"].stringValue
                        self.weekTable.reloadData()


                    case .failure(let error):
                        print(error.localizedDescription)
                    }

                }
    }
    
    // MARK: Long Press
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {

        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            let touchPoint = longPressGestureRecognizer.location(in: self.weekTable)
            if let indexPath = weekTable.indexPathForRow(at: touchPoint) {
                self.wocheEssenArray[indexPath.row] = "-"
                self.wocheEssenIdArray[indexPath.row] = "-"
                self.weekTable.reloadData()
                ///////works but erratic responses//////////
            }
        }
    }
    
    
    // MARK: Buttons
    
    @IBAction func weekButtons(_ sender: UIButton) {
        
        if sender.currentImage == checkBoxSelected {
            sender.setImage(checkBoxUnselected, for: .normal)
            
        } else {
            sender.setImage(checkBoxSelected, for: .normal)
        }
        
        if sender.tag == 8 {
            let allOn = !(sender.currentImage == checkBoxSelected)
            
            for i in 1...7 {
                let tmpButton = self.view.viewWithTag(i) as? UIButton
                if allOn {
                    tmpButton!.setImage(checkBoxUnselected, for: .normal)
                } else {
                    tmpButton!.setImage(checkBoxSelected, for: .normal)
                }
                

            }
            
        } else {
            let tmpButton = self.view.viewWithTag(8) as? UIButton
            tmpButton!.setImage(checkBoxUnselected, for: .normal)
        }
        
    }
    
    @IBAction func resumeButton(_ sender: UIButton) {

        
        
        for i in 1...7 {
            self.wocheEssenArray[i-1] = "-"
            self.wocheEssenIdArray[i-1] = "-"
            let tmpButton = self.view.viewWithTag(i) as? UIButton
            if tmpButton?.currentImage == checkBoxSelected {
                
                        let url = "http://192.168.100.2/futterplan/api/getfood.php"
                        let parameters: [String: Any] = [
//                            "aufwand" : 1,
                            "mode" : "random"
                        ]
//                        AF.cancelAllRequests()
                        
                        AF.request(url, method:.post, parameters: parameters) .responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                self.wocheEssenArray[i-1] = json["name"].stringValue
                                self.wocheEssenIdArray[i-1] = json["id"].stringValue
                                self.weekTable.reloadData()

                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                            
                        }
            }
        }
        
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let url = "http://192.168.100.2/futterplan/api/setfood.php"
        
         var returnDic:[String:String] = [:]
         
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)

        
        for i in 0...wocheEssenIdArray.count-1 {
            let keyString = wocheArray[i]
            returnDic[keyString] = wocheEssenIdArray[i] as String
        }
         
         
         var parameters: [String: Any] = [
             "date" : formattedDate,
             "ids" : [
                 "Mo" : "Test"
             ],
         ]
         
         parameters["ids"] = returnDic

         
         AF.request(url, method:.post, parameters: parameters,encoding: JSONEncoding.default) .response { (response) in
             switch response.result {
             case .success(.some(_)):
                 print("success")
             case .failure( _):
                  print("fail")
             case .success(.none):
                  print("success")
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
