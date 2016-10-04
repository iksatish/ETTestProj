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
    case couldNotParseJSON
    case noData
    case noSuccessStatusCode(statusCode: Int)
    case other(NSError)
}


class ServiceRequest:NSObject, URLSessionDelegate{
    func doServiceRequest(_ request:URLRequest, failure: @escaping (NSDictionary?)->(), success:@escaping (NSDictionary?)->()){
            let task = Foundation.URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 ||
                    httpResponse.statusCode == 201  {
                    success(decodeJSON(data!) as NSDictionary?)
                }else if httpResponse.statusCode == 401{
                    failure(["loginStatus":"failed"])
                }
                else {
                    failure(decodeJSON(data!) as NSDictionary?)
                }
            }
            else {
                failure(decodeJSON(data!) as NSDictionary?)
            }
            
        })
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(Foundation.URLSession.AuthChallengeDisposition.performDefaultHandling, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        
    }
}
public typealias JSONDictionary = [String:AnyObject]

func decodeJSON(_ data: Data) -> JSONDictionary {
    
    do{
        let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
        let decodedJsonObj = ["jsonData" : jsonObj]
        return decodedJsonObj as JSONDictionary
    }catch{
        
    }
    
    return [:]
}

func encodeJSON(_ dict: NSMutableDictionary) -> Data? {
    do{
        return try dict.count > 0 ? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions()) : nil
    }catch{}
    return nil
}


class UserModel:NSObject{
    var userName:String?
    var password:String?
}
