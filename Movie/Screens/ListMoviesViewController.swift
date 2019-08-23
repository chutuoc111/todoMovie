//
//  ListMoviesViewController.swift
//  Movie
//
//  Created by TranMinhHieu on 7/30/19.
//  Copyright © 2019 TranMinhHieu. All rights reserved.
//

import UIKit

class ListMoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    var indexGenres : Int?
    
    var listGenres : [Genres] {
        return DataManagement.share.listGenres
    }
    
    var listMovie : [MovieDB] = []
    
    private struct Constant {
        static var spaceBetweenCell: CGFloat = 0
        static var spaceBetweenLine: CGFloat = 0
        static var itemsPerRow: Int = 2
        static var sectionInsets: UIEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 1,
            bottom: 0,
            right: 1
        )
        static var headerHeight: CGFloat = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        collectionViewMovies.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        //        collectionViewMovies.register(cellType: myCell.self)
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionViewMovies?.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        callService()
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        
    }
    
    func callService() {
        API.getMovie(index: self.indexGenres!) { (movieDB) in
            self.listMovie = movieDB
            self.collectionViewMovies.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ListMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Constant.headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let COLLECTION_HEIGHT: CGFloat = 197.0
        let screenSize = UIScreen.main.bounds
        let paddingSpace = Constant.sectionInsets.left
            + Constant.sectionInsets.right
            + CGFloat(Constant.itemsPerRow - 1) * Constant.spaceBetweenCell
        let availableWidth = screenSize.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(Constant.itemsPerRow)
        return CGSize(width: widthPerItem, height: COLLECTION_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constant.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.spaceBetweenLine
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.spaceBetweenCell
    }
}

extension ListMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCell = collectionViewMovies.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        videoCell.imgMovies.image = listMovie[indexPath.row].imagePosterPath
        return videoCell
        
    }
}

extension ListMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.movie = listMovie[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

