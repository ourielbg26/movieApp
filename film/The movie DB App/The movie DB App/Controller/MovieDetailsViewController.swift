//
//  MoviesDetailsViewController.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var frameForImageView: UIView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieImage: CustomImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var movieId: Int?
    var movieName: String?
    var posterPath: String?
    
    private var movieProperties: MovieProperties? {
        didSet {
            moviePropertiesDidSet()
        }
    }
    
    // MARK: Activity Indicator
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie details"
        
        if let movieName = movieName {
            movieNameLabel.text = movieName
        }
        
        hideComponents()
        configureActivityIndicator()
        loadMovieProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageViewHeightConstraint.constant = view.bounds.height * 0.4
    }
    
    private func moviePropertiesDidSet() {
        tableView.reloadData()
        loadImage(posterPath: posterPath ?? "")
    }
    
    private func configureActivityIndicator() {
        activityIndicator.setup(view: view)
        activityIndicator.startAnimating()
    }
    
    private func loadMovieProperties() {
        if let movieId = movieId {
            WebServices().getMovieProperties(byMovieId: movieId, completion: { movieProperties in
                if let movieProperties = movieProperties {
                    self.movieProperties = movieProperties
                } else {
                    self.showGenericError()
                }
            })
        }
    }
        
    private func loadImage(posterPath: String) {
        let url = "https://image.tmdb.org/t/p/w500" + posterPath
        movieImage.loadImageUsingUrlString(urlString: url, completion: { finish in
            self.unhideComponents()
        })
    }
    
    private func showData() {
        activityIndicator.stopAnimating()
        unhideComponents()
    }
    
    private func hideComponents() {
        movieNameLabel.isHidden = true
        frameForImageView.isHidden = true
        tableView.isHidden = true
    }
    
    private func unhideComponents() {
        if movieImage.image == nil {
            movieImage.loadQuestionMarkImage()
        }
        
        activityIndicator.stopAnimating()
        movieNameLabel.isHidden = false
        frameForImageView.isHidden = false
        tableView.isHidden = false
    }
}

extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell") as! MovieDetailsTableViewCell
        if let movieProperties = movieProperties {
            cell.configureCell(movieProperties: movieProperties)
        }
        
        return cell
    }
}
