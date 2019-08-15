//
//  ApiManager.swift
//  CatApp
//
//  Created by Stuti on 01/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

final class ApiManager {
    static let shared = ApiManager()
    private init() {}
    
    private let session = URLSession.shared
    func fetch(request: URLRequest?, completionHandler: @escaping (Data?, Error?) -> ()) {
        guard let request = request else { return }
        let task = session.dataTask(with: request) { (data, response, error)  in
            if let data = data {
                completionHandler(data, nil)
            }
            if let error = error {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    func createRequest(url: URL?, method: HTTPMethod, data: Data? = nil) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.type
        var header = ["x-api-key": "9cabba76-28ce-4040-be72-2cc89924373a"]
        if method == .post {
            header["Content-Type"] = "application/json"
            request.httpBody = data
        }
        request.allHTTPHeaderFields = header
        return request
    }
}
