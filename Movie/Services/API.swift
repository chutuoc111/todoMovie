//
//  API.swift
//  TodoMovie
//
//  Created by dang.nguyen.vu on 4/24/18.
//

import Foundation
import Alamofire

class API {
    
    class func getGenres(completeHandle :@escaping (Bool)-> Void) {
        let apiRequest = APIRequest.getGenres
        do {
            let urlRequest = try apiRequest.asURLRequest()
            API.request(urlRequest, success: { (dataSucces) in
                if let results = JSON(dataSucces)["genres"].array {
                    DataManagement.share.listGenres = results.map({Genres(genresJS: $0)})
                    completeHandle(true)
                }
            }, fail: { error in
                completeHandle(false)
            })
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    class func getMovies(completeHandle :@escaping (Bool)-> Void) {
        
        getMovie(index: 0, completeHandle: { (movieDB) in
            if movieDB.count > 0 {
                DataManagement.share.listMovies.append(movieDB)
                completeHandle(true)
            } else {
                completeHandle(false)
            }
        })
    }
    
    class func getMovie(index : Int, completeHandle :@escaping ([MovieDB])-> Void) {
        let genresID = String(describing: DataManagement.share.listGenres[index].genresId!)
        let apiRequest = APIRequest.getMoviesGenres(genresID)
        do {
            let urlRequest = try apiRequest.asURLRequest()
            var listMovies : [MovieDB] = []
            API.request(urlRequest, success: { (dataSucces) in
                if let results = JSON(dataSucces)["results"].array {
                    listMovies = results.map({MovieDB(movieJS: $0)})
                }
                completeHandle(listMovies)
            }, fail: { error in
                completeHandle([])
            })
        } catch  {
            print(error.localizedDescription)
        }
    }
}

extension API {
    private class func request(_ request: URLRequestConvertible, success: (([String: Any]) -> Void)?, fail: ((Error) -> Void)?) {
        Alamofire.request(request).responseJSON { responseJson in
            switch responseJson.result {
            case .success(let value):
                guard let json = value as? [String: Any] else {
                    return
                }
                success?(json)
            case .failure(let error):
                fail?(error)
            }
        }
    }
}

