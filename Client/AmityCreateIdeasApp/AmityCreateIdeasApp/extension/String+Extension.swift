//
//  String+Extension.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 18/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

extension String {
    
    /// check days given date to current date
    func daysBetweenCurrentDate() -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = ACTUAL_DATE_FORMATE
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = EXPECTED_DATE_FORMATE
        
        if let date = dateFormatterGet.date(from: self) {
            let date1 = Calendar.current.startOfDay(for: Date())
            let date2 = Calendar.current.startOfDay(for: date)
            let interval = date1 - date2
            let days = interval.day ?? 0
            if days == 0 {
                return "today"
            } else if days == 1 {
                return "\(days) day ago"
            }else {
                return "\(days) days ago"
            }
            
        } else {
            print("There was an error decoding the string")
        }
        return self
    }
    
    ///To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    ///Validate Phone Number
    var isValidPhoneNumber: Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }

    ///Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    ///Validate User Name
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }

    ///validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){

                if(self.count>=6 && self.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    func jsonStringToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
