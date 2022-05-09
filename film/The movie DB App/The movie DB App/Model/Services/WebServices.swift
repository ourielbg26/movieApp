//
//  WebServices.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import Foundation

class WebServices: ApiClient {
    
    // MARK: Properties
    let apiKey: String = Constants.WebServices.apiKey
    let baseUrl = "https://api.themoviedb.org/3/"
    var previousUrlString: String?
    
    func getMovies(byPageNumber pageNumber: Int, query: String?, completion: @escaping (Movies?) -> Void) {
        var urlString = baseUrl
        if let query = query {
            if let previous = previousUrlString {
                cancelTaskWithUrl(URL(string: previous))
            }
            
            urlString += "search/movie?api_key=" + apiKey + "&language=en-US&query=" + query + "&page=" + String(pageNumber) + "&include_adult=false"
            previousUrlString = urlString
        } else {
            urlString += "movie/popular?api_key=" + apiKey + "&language=en-US&page=" + String(pageNumber)
        }
        
        guard let url = URL(string: urlString) else { return }
        fetch(with: url) { (result: Result<Movies>) in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getMovieProperties(byMovieId id: Int, completion: @escaping (MovieProperties?) -> Void) {
        let urlString = baseUrl + "movie/" + String(id) + "?api_key=" + apiKey + "&language=en-US"
        
        guard let url = URL(string: urlString) else { return }
        fetch(with: url) { (result: Result<MovieProperties>) in
            switch result {
            case .success(let movieProperties):
                completion(movieProperties)
            case .failure:
                completion(nil)
            }
        }
    }
    
    // cancel previous task request
    func cancelTaskWithUrl(_ url: URL?) {
        if let url = url {
            URLSession.shared.getAllTasks { tasks in
                tasks
                    .filter { $0.state == .running }
                    .filter { $0.originalRequest?.url == url }.first?
                    .cancel()
            }
        }
    }
}
