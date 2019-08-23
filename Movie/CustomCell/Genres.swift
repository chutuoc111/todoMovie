//
//  File.swift
//  Movie
//
//  Created by TranMinhHieu on 7/24/19.
//  Copyright © 2019 TranMinhHieu. All rights reserved.
//

import Foundation

class Genres {
    var genresId : Int?
    var genresName : String = ""
    
    init() {
    }
    
    init(genresJS : JSON) {
        self.genresId  = genresJS["id"].integer
        self.genresName = genresJS["name"].string ?? ""
    }
}

