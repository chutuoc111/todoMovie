//
//  MovieDB.swift
//  Movie
//
//  Created by TranMinhHieu on 7/24/19.
//  Copyright © 2019 TranMinhHieu. All rights reserved.
//

import Foundation
import UIKit

class MovieDB {
    var voteCount : Int?
    var id : String = ""
    var video : Bool = true
    var voteAverage : Int?
    var title : String = ""
    var popularity : String = ""
    var posterPath : String = ""
    var originalLanguage : String = ""
    var originalTitle : String = ""
    var listGenresId : [String] = []
    var backdropPath : String = ""
    var adult : Bool?
    var overview : String = ""
    var releaseDate : String = ""
    var imageBackdropPath : UIImage? = #imageLiteral(resourceName: "Img1")
    var imagePosterPath : UIImage? = #imageLiteral(resourceName: "Img1")
    
    init() {}
    
    init(movieJS : JSON){
        self.voteCount = movieJS["vote_count"].integer
        self.id = movieJS["id"].string ?? ""
        self.video = movieJS["video"].bool ?? false
        self.voteAverage = movieJS["vote_average"].integer
        self.title = movieJS["title"].string ?? ""
        self.popularity = movieJS["popularity"].string ?? ""
        self.posterPath = movieJS["poster_path"].string ?? ""
        self.originalLanguage = movieJS["original_language"].string ?? ""
        self.originalTitle = movieJS["original_title"].string ?? ""
        if let production_companies = movieJS["genre_ids"].array {
            self.listGenresId = production_companies.flatMap({$0.string ?? ""})
        }
        self.backdropPath = movieJS["backdrop_path"].string ?? ""
        self.adult = movieJS["adult"].bool ?? false
        self.overview = movieJS["overview"].string ?? ""
        self.releaseDate = movieJS["release_date"].string ?? ""
        getImage(url: posterPath) { imageResult in
            self.imagePosterPath = imageResult
        }
        getImage(url: backdropPath) { imageResult in
            self.imageBackdropPath = imageResult
        }
    }
    
    func getImage(url: String, completeHandle:@escaping (UIImage?)->()) {
        DispatchQueue.global(qos: .userInitiated).async {
            if !url.isEmpty {
                getImageByUrl(url: AppConstants.PATH_IMAGE + url, completeHande: completeHandle)
            }
        }
    }
}
