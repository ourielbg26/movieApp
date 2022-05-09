//
//  ApiClient.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(value: T)
    case failure
}

protocol ApiClient: class {
    var session: URLSession { get }
    func fetch<T: Codable>(with url: URL, completion: @escaping (Result<T>) -> ())
}

extension ApiClient {
    var session: URLSession {
        return URLSession(configuration: .default)
    }
    
    func fetch<T: Codable>(with url: URL, completion: @escaping (Result<T>) -> ()) {
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode),
                    let data = data
                    else {
                        print("Error fetching data: \(error?.localizedDescription ?? "")")
                        completion(.failure)
                        return
                }
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(value: decodedObject))
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                    completion(.failure)
                }
            }
        }
        
        task.resume()
    }
}
