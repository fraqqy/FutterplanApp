//
//  CalenderFood.swift
//  Futterplan
//
//  Created by Waldemar Ketterling on 29.04.20.
//  Copyright © 2020 Waldemar Ketterling. All rights reserved.
//

import Foundation


class CalendarFood {
    
    
    var montag = ""
    var dienstag = ""
    var mittwoch = ""
    var donnerstag = ""
    var freitag = ""
    var samstag = ""
    var sonntag = ""
    
    var montagDate = ""
    var dienstagDate = ""
    var mittwochDate = ""
    var donnerstagDate = ""
    var freitagDate = ""
    var samstagDate = ""
    var sonntagDate = ""
    
    var montagId = ""
    var dienstagId = ""
    var mittwochId = ""
    var donnerstagId = ""
    var freitagId = ""
    var samstagId = ""
    var sonntagId = ""
    
    var foodArr = [String]()
    var dateArr = [String]()
    var idArr = [String]()
    let dateStringArr = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
    
    func getFoodArr() {
        
        if foodArr.count == 0 {
            foodArr.append(montag)
            foodArr.append(dienstag)
            foodArr.append(mittwoch)
            foodArr.append(donnerstag)
            foodArr.append(freitag)
            foodArr.append(samstag)
            foodArr.append(sonntag)
        }
        
        
    }
    
    func getDateArr() {
        
        if dateArr.count == 0 {
            dateArr.append(montagDate)
            dateArr.append(dienstagDate)
            dateArr.append(mittwochDate)
            dateArr.append(donnerstagDate)
            dateArr.append(freitagDate)
            dateArr.append(samstagDate)
            dateArr.append(sonntagDate)
        }
        
        
    }
    
    func getIdArr() {
        idArr.removeAll()
        
        idArr.append(montagId)
        idArr.append(dienstagId)
        idArr.append(mittwochId)
        idArr.append(donnerstagId)
        idArr.append(freitagId)
        idArr.append(samstagId)
        idArr.append(sonntagId)

        
        
    }
    
    func deleteAll() {
        montag = ""
        dienstag = ""
        mittwoch = ""
        donnerstag = ""
        freitag = ""
        samstag = ""
        sonntag = ""
        
        montagDate = ""
        dienstagDate = ""
        mittwochDate = ""
        donnerstagDate = ""
        freitagDate = ""
        samstagDate = ""
        sonntagDate = ""
        
        montagId = ""
        dienstagId = ""
        mittwochId = ""
        donnerstagId = ""
        freitagId = ""
        samstagId = ""
        sonntagId = ""
    }
}
