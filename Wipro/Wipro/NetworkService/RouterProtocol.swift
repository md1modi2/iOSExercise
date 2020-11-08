//
//  RouterProtocol.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import Foundation
import Alamofire

public protocol RouterProtocol: URLRequestConvertible {

    var method: HTTPMethod { get }
    var baseUrlString: String { get }

    var path: String { get }
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var headers: [String: String]? { get }
    var arrayParameters: [Any]? { get }
}

public extension RouterProtocol {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.baseUrlString) else {
            throw(NSError.customError(with: 300, message: MessageConstants.URLError)!)
        }
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = self.headers
        request.timeoutInterval = 30.0
        do {
            let req = try URLEncoding.default.encode(request as URLRequestConvertible, with: parameters)
            return req
        } catch let error {
            print("error occured \(error)")
        }
        return request
    }
    
    var arrayParameters: [Any]? {
        return nil
    }
}

public class WSResponse: Codable {
    
    init() {
        
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
    
    required public init(from decoder: Decoder) throws {
        
    }
}
