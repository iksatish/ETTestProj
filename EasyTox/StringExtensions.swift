//
//  StringExtensions.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 5/10/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import Foundation

extension String{
    var parseJSONString: AnyObject?  {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do{
                return try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
            }catch{
                return nil
            }
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
    func stripBadJson() ->String {
        var newString = self.replace("\\\"", replacement: "\"")
        newString = newString.replace("\n", replacement: "")
        
        return newString
    }
    
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }

}