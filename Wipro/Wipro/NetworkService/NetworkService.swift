//
//  NetworkService.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    private init() {}
    
    static let boundaryConstant = "aRandomBoundary2637542"
    
    private static let manager: SessionManager = { () -> SessionManager in
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    static func dataRequest<Model: Codable>(with inputRequest: RouterProtocol, completionHandler: @escaping (Model?, Error?) -> Void) {
        do {
            _ = try inputRequest.asURLRequest()
        } catch {
            completionHandler(nil, NSError.customError(with: 300, message: MessageConstants.NetworkError))
            return
        }
                
        manager.upload(multipartFormData: { (multiPartData) in
            let reqParam = inputRequest.parameters ?? [String: Any]()
            for (key, value) in reqParam {
                print("\(key) :: \(value)")
                multiPartData.append(((value as? String)?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!)!, withName: key)
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, with: inputRequest) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseData(completionHandler: { (response) in
                    let result = response.result
                    let error = result.error as NSError?
                    
                    if let data = response.data {
                        print("Response :: ", String(data: data, encoding: .utf8) ?? "")
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
                })
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
