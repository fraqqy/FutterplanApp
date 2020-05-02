//
//  CalendarVC.swift
//  Futterplan
//
//  Created by Waldemar Ketterling on 29.04.20.
//  Copyright © 2020 Waldemar Ketterling. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CalendarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var weekTable: UITableView!
    @IBOutlet weak var lastWeekButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var nextWeekButtonOutlet: UIBarButtonItem!
    
    
    
    var week = CalendarFood()
    var refreshControl: UIRefreshControl!
    var nextweek = 1
    var choosenId = ""
    var choosenName = ""
    var choosenRezept = ""
    var choosenZutaten = ""

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekTable.delegate = self
        weekTable.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Aktualisieren...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        weekTable.addSubview(refreshControl)

        
        loadWeek(today: nextweek)
        

        lastWeekButtonOutlet.isEnabled = false

        
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        week.getFoodArr()
        week.getDateArr()
        
        
        if indexPath.row == 1 {
            if week.foodArr.count > 0 {
                cell.textLabel?.text = week.foodArr[indexPath.section]
                } else {
                    cell.textLabel?.text = "-"

                }
        } else {
            if week.dateArr.count > 0 {
                cell.textLabel?.text = week.dateStringArr[indexPath.section] + " " + week.dateArr[indexPath.section]
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
            } else {
                cell.textLabel?.text = "-"

            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            week.getIdArr()
            choosenId = week.idArr[indexPath.section]
            
            if choosenId != "" {
                loadFood(id: choosenId)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)

            }
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
          if segue.identifier == "segueToDetail" {
         guard let detailVC = segue.destination as? DetailFoodVC else { return }
         detailVC.foodName = self.choosenName
            detailVC.foodRezept = self.choosenRezept
            detailVC.foodZutaten = self.choosenZutaten

            
            
        }
    }
    
    @objc
     func refresh(sender:AnyObject) {
        loadWeek(today: nextweek)
         refreshControl.endRefreshing()
         
     }
    
    func loadFood(id: String) {
        let url = "http://192.168.100.2/futterplan/api/getdetail.php"
        let parameters: [String: Any] = [
            "id" : id
        ]
        AF.cancelAllRequests()
        
        AF.request(url, method:.post, parameters: parameters) .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                for item in json.arrayValue {
                    self.choosenRezept = item["rezept"].stringValue
                    self.choosenZutaten = item["zutaten"].stringValue
                    self.choosenName = item["name"].stringValue
                }
                
                self.performSegue(withIdentifier: "segueToDetail", sender: "foodData")
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    
    func loadWeek(today: Int) {
        
        let url = "http://192.168.100.2/futterplan/api/getweek.php"
        let parameters: [String: Any] = [
            "mode" : today
        ]
        AF.cancelAllRequests()
        self.week.deleteAll()
        self.week.foodArr.removeAll()
        self.week.dateArr.removeAll()

        
        AF.request(url, method:.post, parameters: parameters) .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                
                for item in json.dictionary! {
                    switch item.key {
                    case "mo":
                        let temp = item.value
                        self.week.montag = temp["food"].stringValue
                        self.week.montagDate = temp["day"].stringValue
                        self.week.montagId = temp["id"].stringValue
                        
                    case "di":
                        let temp = item.value
                        self.week.dienstag = temp["food"].stringValue
                        self.week.dienstagDate = temp["day"].stringValue
                        self.week.dienstagId = temp["id"].stringValue

                    case "mi":
                        let temp = item.value
                        self.week.mittwoch = temp["food"].stringValue
                        self.week.mittwochDate = temp["day"].stringValue
                        self.week.mittwochId = temp["id"].stringValue

                    case "do":
                        let temp = item.value
                        self.week.donnerstag = temp["food"].stringValue
                        self.week.donnerstagDate = temp["day"].stringValue
                        self.week.donnerstagId = temp["id"].stringValue

                    case "fr":
                        let temp = item.value
                        self.week.freitag = temp["food"].stringValue
                        self.week.freitagDate = temp["day"].stringValue
                        self.week.freitagId = temp["id"].stringValue
                        
                    case "sa":
                        let temp = item.value
                        self.week.samstag = temp["food"].stringValue
                        self.week.samstagDate = temp["day"].stringValue
                        self.week.samstagId = temp["id"].stringValue

                    case "so":
                        let temp = item.value
                        self.week.sonntag = temp["food"].stringValue
                        self.week.sonntagDate = temp["day"].stringValue
                        self.week.sonntagId = temp["id"].stringValue

                    default:
                        print("error")
                    }
                    self.weekTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.weekTable.reloadData()

        }
        
    }
    
    @IBAction func nextWeekButtons(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        
        if sender.tag == 1 {
            nextWeekButtonOutlet.isEnabled = true
            nextweek = 1
            loadWeek(today: nextweek)

        } else {
            lastWeekButtonOutlet.isEnabled = true
            nextweek = 2
            loadWeek(today: nextweek)

        }
        
    }
    
    
    
}
