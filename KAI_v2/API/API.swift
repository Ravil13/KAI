//
//  API.swift
//  KAI
//
//  Created by Ravil Vildanov on 03.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation
import SwiftSoup

typealias ErrorClouser = (NSError) -> Void

protocol Endpoint {
    var urlComponents: URLComponents? { get }
    var parameters: [String: String] { get }
}

enum API {
    
    // MARK: - Private Methods
    
    private static func request(endpoint: Endpoint,
                                additionalParameters: [String: String]? = nil,
                                success: @escaping (Data) -> Void,
                                failure: @escaping ErrorClouser)  {
        
        guard var urlComponents = endpoint.urlComponents else {
            failure(WebError.somethingWentWrong)
            return
        }
        
        var parameters = endpoint.parameters
        parameters.merge(additionalParameters ?? [:]) { (_, new) in new }
        
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            failure(WebError.somethingWentWrong)
            return
        }
        
        print("REQUEST: \(url.absoluteString)")
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            DispatchQueue.main.async {
                if let error = error as NSError? {
                    print("ERROR: \(error.localizedDescription)")
                    failure(error)
                    return
                }
                
                guard let data = data else {
                    print("NO DATA")
                    failure(WebError.somethingWentWrong)
                    return
                }
                
                success(data)
            }
        }
        
        task.resume()
    }
    
    /// Generic request method
    static func request<T: Decodable>(endpoint: Endpoint,
                                      additionalParameters: [String: String]? = nil,
                                      success: @escaping (T) -> Void,
                                      failure: @escaping ErrorClouser) {
        
        self.request(endpoint: endpoint, success: { data in
            let jsonDecoder = JSONDecoder()
            
            do {
                let object = try jsonDecoder.decode(T.self, from: data)
                print(object)
                success(object)
            } catch(let error as NSError) {
                print("PARSE ERROR: \(error.localizedDescription)")
                failure(error)
            }
        }, failure: failure)
    }
    
    static func requestHTML(endpoint: Endpoint,
                            additionalParameters: [String: String]? = nil,
                            success: @escaping (String) -> Void,
                            failure: @escaping ErrorClouser) {
        
        request(endpoint: endpoint, success: { data in
            if let html = String(data: data, encoding: .utf8) {
                success(html)
            } else {
                print("Data doesn't contains a string value")
                failure(WebError.badResponse)
            }
        }, failure: failure)
    }
}
