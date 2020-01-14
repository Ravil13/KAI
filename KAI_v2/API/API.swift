//
//  API.swift
//  KAI
//
//  Created by Ravil Vildanov on 03.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

typealias ErrorClouser = (NSError) -> Void

protocol Endpoint {
    var urlComponents: URLComponents? { get }
    var parameters: [String: String]? { get }
}

enum API {
    
    // MARK: - Private Methods
    
    /// Generic request method
    static func request<T: Decodable>(endpoint: Endpoint,
                                      additionalParameters: [String: String]? = nil,
                                      success: @escaping (T) -> Void,
                                      failure: @escaping ErrorClouser) {
        
        guard var urlComponents = endpoint.urlComponents else { return }
        
        var parameters = endpoint.parameters ?? [:]
        parameters.merge(additionalParameters ?? [:]) { (_, new) in new }
        
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else { return }
        
        print("REQUEST: \(url.absoluteString)")
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
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
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let object = try jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    print(object)
                    success(object)
                }
            } catch(let error as NSError) {
                DispatchQueue.main.async {
                    print("PARSE ERROR: \(error.localizedDescription)")
                    failure(error)
                }
            }
        }
        
        task.resume()
    }
}
