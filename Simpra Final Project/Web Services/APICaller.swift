//
//  APICaller.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import Foundation

struct Constants{
    
    static let API_KEY = "b82fd375d4a14dba9e7026510221eeb5"
    static let baseURL = "https://api.rawg.io"
    static var pageNumber = 1
    
    
    var APIURL = URL(string: "\(baseURL)/api/games?key=\(API_KEY)&page=\(pageNumber)")
    
}

class APICaller {
    
    
    static let shared = APICaller()
    
    
    public func getGames(completion: @escaping (Result <[Game], Error>)-> Void) {
        
        let APIURL = URL(string: "\(Constants.baseURL)/api/games?key=\(Constants.API_KEY)&page=\(Constants.pageNumber)")
        
        guard let url = APIURL else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                    do {
                        let results = try JSONDecoder().decode(Response.self, from: data)
                        completion(.success(results.results!))
                    } catch {
                        completion(.failure(error))
                    }
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
}
