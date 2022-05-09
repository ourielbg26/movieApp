//
//  ViewController.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
        
    // MARK: Properties
    private let webService = WebServices()
    private var selectedIndex: Int = 0
    private var pageToLoad: Int = 1
    private var query: String? = nil
    private var movies: Movies? {
        didSet {
            moviesDidSet()
        }
    }
    
    lazy private var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = true
        return tapGesture
    }()
    
    // MARK: Activity Indicator
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureActivityIndicator()
        configureNavigationBar()
        configureSearchBar()
        loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar
        navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    private func moviesDidSet() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.setup(view: view)
        activityIndicator.startAnimating()
    }
    
    private func configureSearchBar() {
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func configureNavigationBar() {
        self.title = "Popular movies"
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8754802346, green: 0.8756273389, blue: 0.8754608035, alpha: 1)
    }
    
    private func loadMovies() {
        webService.getMovies(byPageNumber: pageToLoad, query: query, completion: { movies in
            if let movies = movies {
                self.setMovies(movies: movies)
            } else {
                self.showGenericError()
            }
        })
    }
    
    private func setMovies(movies: Movies) {
        if self.movies == nil {
            self.movies = movies
        } else {
            self.movies?.moviesDetails += movies.moviesDetails
        }
        
        self.pageToLoad += 1
    }
    
    @objc func handleTap() {
        view.endEditing(true)
        view.removeGestureRecognizer(tapGesture)
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.moviesDetails.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        if let movies = movies {
            
            // check if we need to load another page (count - 10 ==> to make the scrolling smoothly)
            if indexPath.row == movies.moviesDetails.count - 10 && pageToLoad <= Constants.Page.maxNumberOfPagesToDisplay {
                self.loadMovies()
            }
            
            cell.configureCell(movieDetails: movies.moviesDetails[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: Constants.Segue.movieDetailsSegue, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailsViewController {
            destination.movieId = movies?.moviesDetails[selectedIndex].id
            destination.movieName = movies?.moviesDetails[selectedIndex].title
            destination.posterPath = movies?.moviesDetails[selectedIndex].posterPath
        }
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        view.addGestureRecognizer(tapGesture)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            query = String(searchText.map {
                $0 == " " ? "+" : $0
            })
        } else {
            query = nil
        }
        
        resetData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    private func resetData() {
        pageToLoad = 1
        movies = nil
        loadMovies()
    }
}
