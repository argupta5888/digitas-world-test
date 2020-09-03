//
//  RemoteClient.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation
import Moya
import os
import Reachability



enum DResult<T> {
    case success([T])
    case failure(CustomError)
}

class RemoteClient {
    
    static let provider = MoyaProvider<ResourceType>()
    
    static func request<K:Decodable>(of: K.Type, target: ResourceType, success successCallBack: @escaping (DResult<K>) -> Void, error errorCallBack: @escaping (CustomError) -> Void, failure failureCallBack: @escaping (CustomError) -> Void) {
          
        if !(NetworkManager.sharedInstance.reachability.connection == .unavailable) {
            provider.request(target) { (result) in
                
                switch result {
                case .success(let response):
                    print("SERVICE URL: \(response.request?.url?.absoluteString ?? "BLANK URL")")
                    if response.statusCode >= 200 && response.statusCode <= 300 {
                        do {
                           
                                let strJson = String(data: response.data, encoding: .utf8)
                                print("RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
                            
                            os_log("Response: %s", log: Log.networking, type: .info, strJson!)
                                let decoder = JSONDecoder()
                            let object: [K] = try decoder.decode([K].self, from: response.data)
                            successCallBack(.success(object))
                        }
                        catch {
                            os_log("Parsing error occured", log: Log.networking, type: .error)
                            errorCallBack(CustomError.ParsingError)
                        }
                    }
                    else if response.statusCode >= 400 && response.statusCode <= 499 {
                        
                        os_log("Server error!", log: Log.networking)
                        let error = NSError(domain: Constant.kDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Error from server" ])
                            errorCallBack(CustomError.HTTPError(err: error))
                    }
                    else {
                        errorCallBack(CustomError.ServerError)
                    }
                case .failure(let error):
                    print("FAILED:  \(MoyaError.underlying(error, nil))")
                    
                    switch error {
                    case .underlying(let err as NSError, _):
                        if err.code == 1009 {
                            os_log("No network!", log: Log.networking)
                            failureCallBack(CustomError.NoNetwork)
                        }
                        else if err.code == 2102 {
                            os_log("Request time out!", log: Log.networking)
                            failureCallBack(CustomError.TimeOut)
                        }
                        else if err.code == 1004 || err.code == 1005 {
                            os_log("Connection failed!", log: Log.networking)
                            failureCallBack(CustomError.UnableToConnect)
                        }
                        else {
                            os_log("Something went wrong, network failure!!", log: Log.networking)
                            failureCallBack(CustomError.BadRequest)
                        }
                        
                    default:
                        os_log("Something went wrong, network failure!!", log: Log.networking)
                        failureCallBack(CustomError.BadRequest)
                    }
                }
            }
        }
        else {
            failureCallBack(CustomError.NoNetwork)
        }
        }
}
