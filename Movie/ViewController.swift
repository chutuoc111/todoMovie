//
//  ViewController.swift
//  Movie
//
//  Created by TranMinhHieu on 7/28/19.
//  Copyright © 2019 TranMinhHieu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewGenres: UITableView!
    var listGenres : [Genres] {
        return DataManagement.share.listGenres
    }
    var listMovies : [[MovieDB]] {
        return DataManagement.share.listMovies
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewGenres.register(UINib.init(nibName: "GenresTableViewCell", bundle: nil), forCellReuseIdentifier: "GenresTableViewCell")
        tableViewGenres.tableFooterView = UIView()
        callService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callService() {
        API.getGenres { status in
            if status {
                API.getMovies { status in
                    if status {
                        self.tableViewGenres.reloadData()
                    }
                }
            }else {}
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGenres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewGenres.dequeueReusableCell(withIdentifier: "GenresTableViewCell", for: indexPath) as! GenresTableViewCell
        cell.labelNameGenres.text = listGenres[indexPath.row].genresName
        cell.imgViewGenres.image = listMovies[0][indexPath.row].imageBackdropPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListMoviesViewController") as! ListMoviesViewController
        vc.indexGenres = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
