//
//  NetworkService.swift
//  WiproTests
//
//  Created by hb on 19/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import Foundation

class NetworkService {
    
    var session: URLSession!
    
    func getFacts(completion: @escaping (FactsModel?, Error?) -> Void) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
          else { fatalError() }
        session.dataTask(with: url) { (data, response, error) in
          guard error == nil else {
            completion(nil, error)
            return
          }
          guard let data = data else {
           completion(nil, NSError(domain: "no data", code: 10, userInfo: nil))
           return
          }
          let decodedValue = try! JSONDecoder().decode(FactsModel.self, from: data)
          completion(decodedValue, nil)
        }.resume()
    }
}

class NetworkTask: URLSessionDataTask {
  let data: Data?
  let urlResponse: URLResponse?
  let networkError: Error?

  var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
  init(data: Data?, urlResponse: URLResponse?, error: Error?) {
    self.data = data
    self.urlResponse = urlResponse
    self.networkError = error
  }
  override func resume() {
    DispatchQueue.main.async {
        self.completionHandler?(self.data, self.urlResponse, self.networkError)
    }
  }
}

class NetworkSession: URLSession {
    
    private let task: NetworkTask
    var url: URL?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        task = NetworkTask(data: data, urlResponse: urlResponse, error:
            error)
    }
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        task.completionHandler = completionHandler
        return task
    }
}
