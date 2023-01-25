//
//  APICaller.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import Foundation

enum GameOrdering : Int {
    case name
    case released
    case metacritic
    
    var stringValue: String {
        switch self{
        case .name:
            return "name"
        case .released:
            return "released"
        case .metacritic:
            return "metacritic"
        }
    }
}


struct Constants{
    
    static let API_KEY = "b82fd375d4a14dba9e7026510221eeb5"
    static let baseURL = "https://api.rawg.io"
    static var pageNumber = 1
    
    static let youtubeAPIKey = "key=AIzaSyCUNpNV46IHVZniRayXhrCiNwgc8rlfCUg"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    
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
    
    func getGameDescription(with query: String,completion: @escaping (Result <SearchResultGame, Error>)-> Void) {
        
         let gameIDURL = URL(string: "\(Constants.baseURL)/api/games/\(query)?key=\(Constants.API_KEY)&page=\(Constants.pageNumber)")
         guard let gameIDURL = gameIDURL else {return}
         let task = URLSession.shared.dataTask(with: URLRequest(url: gameIDURL)) { data, response, error in
             if let error = error {
                 completion(.failure(error))
             } else if let data = data {
                 do {
                     let results = try JSONDecoder().decode(SearchResultGame.self, from: data)
                     completion(.success(results))
                 } catch {
                     print(error.localizedDescription)
                 }
             }
         }
         task.resume()
     }
    
    func search(with query: String,completion: @escaping (Result<[Game], Error>) -> ()) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let searchAPIURL = URL(string: "\(Constants.baseURL)/api/games?key=\(Constants.API_KEY)&page=\(Constants.pageNumber)&search=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: searchAPIURL)) { data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                do {
                    let results = try JSONDecoder().decode(Response.self, from: data)
                    if let results = results.results {
                        completion(.success(results))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getYoutubeMovie(with query: String,completion: @escaping (Result<VideoElement, Error>) -> ()) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&\(Constants.youtubeAPIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            print(url)
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data);
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func gameOrdering(with query: String,completion: @escaping (Result<[Game], Error>) -> ()) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let orderingURL = URL(string: "\(Constants.baseURL)/api/games?key=\(Constants.API_KEY)&ordering=-\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: orderingURL)) { data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                do {
                    let results = try JSONDecoder().decode(Response.self, from: data)
                    if let results = results.results {
                        completion(.success(results))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
