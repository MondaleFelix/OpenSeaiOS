//
//  NetworkingManager.swift
//  OpenSeaiOS
//
//  Created by Mondale on 7/29/21.
//

import UIKit

class NetworkManager {
    
    // Creates singleton
    static let shared = NetworkManager()
    private init(){}
    

    let cache = NSCache<NSString, UIImage>()

    let baseURL = "https://api.opensea.io/api/v1/assets"
    
    
    func getTokens(for owner: String, completed: @escaping(Result<[Token], ErrorMessage>) -> Void){
        
        let endpoint = baseURL + "?owner=\(owner)&order_direction=desc&offset=0&limit=20"
        
        
        // Returns if URL is invalid
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
    
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Returns if error exists
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            // Returns if response is not successful status code
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            // Returns if data is invalid
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // Tries to decode data, throws failure if invalid
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TokenList.self, from: data)
                let tokens = response.assets

                completed(.success(tokens))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}
