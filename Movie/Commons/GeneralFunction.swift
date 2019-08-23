//
//  GeneralFunction.swift
//  Movie
//
//  Created by TranMinhHieu on 7/30/19.
//  Copyright © 2019 TranMinhHieu. All rights reserved.
//

import Foundation
import UIKit

func getImageByUrl(url: String, completeHande: @escaping (UIImage?) -> ()) {
    DispatchQueue.global(qos: .userInitiated).async {
        let catPictureURL = URL(string: url)!
        let downloadPicTask = URLSession(configuration: .default).dataTask(with: catPictureURL) { (data, response, error) in
            if let imageData = data {
                if let image = UIImage(data: imageData) {
                    completeHande(image)
                    return
                }
            }
            completeHande(nil)
        }
        downloadPicTask.resume()
    }
}
