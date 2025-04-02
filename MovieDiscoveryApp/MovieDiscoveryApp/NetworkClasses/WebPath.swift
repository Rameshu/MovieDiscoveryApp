//
//  WebPath.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 01/04/25.
//


enum WebPath: String {
    // https://api.themoviedb.org/3/search/movie?api_key=eea80f40f3f7c9940adc13a09c89edb4&query=thor
    static let apiKey = "eea80f40f3f7c9940adc13a09c89edb4"
    static let BASE_URL = "https://api.themoviedb.org/3/"
    static let POSTER_BASE_URL = "https://image.tmdb.org/t/p/w500"
   
    case movie
    case searchMovie
    
    var endPoint: String {
        switch self {
        case.movie:
            return "discover/movie?api_key=\(WebPath.apiKey)"
        case .searchMovie:
            return "search/movie?api_key=\(WebPath.apiKey)"
        }
    }
    
    var path: String {
        return WebPath.BASE_URL + endPoint
    }
}
