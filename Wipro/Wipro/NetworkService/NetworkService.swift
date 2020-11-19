//
//  NetworkService.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import Foundation

struct NetworkState {
    var isInternetAvailable:Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}

class NetworkService {
    
    static let shared: NetworkService = NetworkService()
    
    func sendRequestWithUrl<Model: WSResponse>(url: String, method: String = "GET", param: [String: Any]? = nil, headers: [String: String]? = nil, completionHandler: @escaping (Model?, Error?) -> Void) {
        
        guard let requestUrl = URL(string: url) else {
            completionHandler(nil, nil)
            return
        }
        
        var request = URLRequest(url: requestUrl,timeoutInterval: 60)
        var components = URLComponents(url: requestUrl, resolvingAgainstBaseURL: false)!
        
        if let requestParam = param {
            for key in requestParam.keys {
                components.queryItems?.append(URLQueryItem(name: key, value: requestParam[key] as? String ?? ""))
            }
            let query = components.url!.query
            request.httpBody = Data(query!.utf8)
        }
        
        if let requestHeaders = headers {
            for key in requestHeaders.keys {
                request.addValue(requestHeaders[key] ?? "", forHTTPHeaderField: key)
            }
        }
        
        request.httpMethod = method
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let responseData = data else {
                completionHandler(nil, error)
                return
            }
            if let ascii = String(data: responseData, encoding: .ascii), let data = ascii.data(using: .utf8) {
                print("Response :: ", ascii)
                do {
                    let decoder = JSONDecoder()
                    let decodedValue = try decoder.decode(Model.self, from: data)
                    completionHandler(decodedValue, nil)
                } catch let parsingError {
                    completionHandler(nil, parsingError)
                }
            } else {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
