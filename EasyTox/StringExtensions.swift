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
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do{
                return try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? AnyObject
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
    
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

}
