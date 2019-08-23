//
//  DetailViewController.swift
//  Movie
//
//  Created by TranMinhHieu on 8/17/19.
//  Copyright © 2019 TranMinhHieu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie : MovieDB?
    
    @IBOutlet weak var imgMovie: UIImageView!
    
    @IBOutlet weak var lblNameMovie: UILabel!
    @IBOutlet weak var lblRealseDate: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieDb = movie else {
            return
        }
        lblNameMovie.text = movieDb.title
        lblVote.text = "Vote count : \(movieDb.voteCount)"
        lblRealseDate.text = "Release date : \(movieDb.releaseDate)"
        lblOverview.text = movieDb.overview
        imgMovie.image = movieDb.imagePosterPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

