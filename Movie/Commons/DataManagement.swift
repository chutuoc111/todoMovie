//
//  DataManagement.swift
//  Movie
//
//  Created by TranMinhHieu on 7/24/19.
//  Copyright © 2019 TranMinhHieu. All rights reserved.
//

import Foundation

final class DataManagement{
    static let share : DataManagement = DataManagement()
    var listGenres : [Genres] = []
    var listMovies : [[MovieDB]] = []
}
