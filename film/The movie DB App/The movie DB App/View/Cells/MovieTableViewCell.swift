//
//  MovieTableViewCell.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    @IBOutlet weak var frameForImageView: UIView!
    @IBOutlet weak var movieImage: CustomImageView!
    
    // MARK: Activity Indicator
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(movieDetails: MovieDetails) {
        activityIndicator.setup(view: frameForImageView)
        movieNameLabel.text = movieDetails.title
        
        let popularity: String = String(format: "%.1f", movieDetails.popularity ?? "")
        moviePopularityLabel.text = "Popularity: " + popularity
        
        if let posterPath = movieDetails.posterPath {
            loadImage(posterPath: posterPath)
        } else {
            movieImage.loadQuestionMarkImage()
        }
    }
    
    private func loadImage(posterPath: String) {
        movieImage.image = nil
        activityIndicator.startAnimating()
        
        let url = "https://image.tmdb.org/t/p/w300" + posterPath
        movieImage.loadImageUsingUrlString(urlString: url, completion: { finish in
            self.activityIndicator.stopAnimating()
        })
    }
}
