//
//  NetworkConnection.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 5/9/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import Foundation

let sessionExpiredErrorCode = "authentication.failed"

struct urlResourcePath {
    var routepath : String?
    var keyPath : String?
    var pathPattern : String?
}

public struct Resource<T>  {
    let pathPattern : String?
    
}

public enum FailureReason {
    case CouldNotParseJSON
    case NoData
    case NoSuccessStatusCode(statusCode: Int)
    case Other(NSError)
}


class ServiceRequest:NSObject, NSURLSessionDelegate{
    func doServiceRequest(request:NSURLRequest, failure: (NSDictionary?)->(), success:(NSDictionary?)->()){
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 ||
                    httpResponse.statusCode == 201  {
                    success(decodeJSON(data!))
                }else if httpResponse.statusCode == 401{
                    failure(["loginStatus":"failed"])
                }
                else {
                    failure(decodeJSON(data!))
                }
            }
            else {
                failure(decodeJSON(data!))
            }
            
        }
        task.resume()
        
    }
    
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        completionHandler(NSURLSessionAuthChallengeDisposition.PerformDefaultHandling, NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!))
        
    }
}
public typealias JSONDictionary = [String:AnyObject]

func decodeJSON(data: NSData) -> JSONDictionary {
    
    do{
        let jsonObj = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let decodedJsonObj = ["jsonData" : jsonObj]
        return decodedJsonObj
    }catch{
        
    }
    
    return [:]
}

func encodeJSON(dict: NSMutableDictionary) -> NSData? {
    do{
        return try dict.count > 0 ? NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions()) : nil
    }catch{}
    return nil
}


class UserModel:NSObject{
    var userName:String?
    var password:String?
}
