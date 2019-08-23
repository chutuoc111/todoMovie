//
//  APIRequest.swift
//  TodoMovie
//
//  Created by dang.nguyen.vu on 4/24/18.
//

import Foundation
import Alamofire

enum APIRequest: URLRequestConvertible {
    case getGenres, getMoviesGenres(String)
    
    var method: HTTPMethod {
        switch self {
        case .getGenres, .getMoviesGenres:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getGenres:
            return "genre/movie/list"
        case .getMoviesGenres :
            return "discover/movie"
        }
    }
    
    var header: Parameters? {
        return nil
    }
    
    var param: Parameters? {
        switch self {
        case .getGenres:
            return ["api_key" : "e92a7c8dae2bc932dd58632a6cb42f85","page" : "1"]
        case .getMoviesGenres(let genresId) :
            return ["api_key" : "e92a7c8dae2bc932dd58632a6cb42f85","page" : "1", "with_genres" : "\(genresId)"]
        }
    }
    
    var body: Parameters? {
        return nil
    }
    
    var defaultParam: Parameters? {
       return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseUrlString = AppConfig.APIBaseUrl + AppConfig.APIVersion
        var baseUrl = try baseUrlString.asURL()
        baseUrl.appendPathComponent(path)
        var request = URLRequest(url: baseUrl)
        request.httpMethod = method.rawValue
        request.setHeaders(header)
        request.setParams(param)
        request.setBody(body)
        return request
    }
}
