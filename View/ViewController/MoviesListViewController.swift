//
//  MoviesListViewController.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

import SDWebImage

class MoviesListViewController: UIViewController {
    var movieSearchString : String = ""
    var pagesLoaded : Int = 1
    var shortMoviesArray : [ShortMovie] = []
    let placeholderImage = UIImage.init(named: "noImage")
    
    //UIElements
    var moviesListCollectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let iconsCollectionView:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        iconsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        iconsCollectionView.backgroundColor = .white
        iconsCollectionView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: MoviesListCollectionViewCell.identifierValue)
        return iconsCollectionView
    }()
    let movieSearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter min 3 letters to begin search"
        searchBar.searchBarStyle = .prominent
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    let movieListLoadingActivityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    let noResultsLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "No Results Found"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let userProfileButton : UIButton = {
        let button = UIButton()
        let image = UIImage(named: "userProfile")
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Film List"
        prepareUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        viewWillTransition(to: size, with: coordinator)
        moviesListCollectionView.reloadData()
    }

    fileprivate func prepareUI() {
        let barButton = UIBarButtonItem(customView: userProfileButton)
        DispatchQueue.main.async {
            self.addAllSubviews()
            self.navigationItem.titleView = self.movieSearchBar
            self.navigationItem.rightBarButtonItem = barButton
            self.movieSearchBar.delegate = self
        }
    }
    
    fileprivate func addAllSubviews() {
        view.addSubview(self.moviesListCollectionView)
        view.addSubview(movieListLoadingActivityIndicator)
        view.addSubview(noResultsLabel)
        addAutolayoutToAllView()
    }
    
    fileprivate func addAutolayoutToAllView() {
        applyAutolayoutToCollectionView()
        applyAutolayoutToMovieListLoadingActivityIndicator()
        applyAutolayoutToNoResultsLabel()
    }
    
    fileprivate func applyAutolayoutToCollectionView() {
        moviesListCollectionView.dataSource = self
        moviesListCollectionView.delegate = self
        moviesListCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        moviesListCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        moviesListCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        moviesListCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
    }
    
    fileprivate func applyAutolayoutToMovieListLoadingActivityIndicator() {
        movieListLoadingActivityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        movieListLoadingActivityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    fileprivate func applyAutolayoutToNoResultsLabel() {
        noResultsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        noResultsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
        noResultsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    fileprivate func getListOfMoviesForStringFromRemoteURL(_ searchString: String) {
        DispatchQueue.main.async {
            self.movieListLoadingActivityIndicator.startAnimating()
            self.noResultsLabel.isHidden = true
        }
        NetworkManager.sharedManager.getMoviesListByName(enteredString: searchString, page: pagesLoaded) { (shortMovieResponse, error) in
            DispatchQueue.main.async {
                self.movieListLoadingActivityIndicator.stopAnimating()
            }
            if (error == nil){
                guard let movies = shortMovieResponse?.Search else {
                    self.shortMoviesArray = []
                    DispatchQueue.main.async {
                        self.noResultsLabel.isHidden = false
                        self.moviesListCollectionView.reloadData()
                    }
                    return
                }
                self.shortMoviesArray.append(contentsOf: movies)
                DispatchQueue.main.async {
                    self.noResultsLabel.isHidden = true
                    self.moviesListCollectionView.reloadData()
                    self.pagesLoaded += 1
                }
            }else {
                DispatchQueue.main.async {
                    self.noResultsLabel.isHidden = true
                    let alert = UIAlertController.init(title: "Error!", message: error, preferredStyle: .alert)
                    let alertCancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
                    let alertRetryAction = UIAlertAction.init(title: "Retry", style: .default) { (action) in
                        self.getListOfMoviesForStringFromRemoteURL(self.movieSearchString)
                    }
                    alert.addAction(alertCancelAction)
                    alert.addAction(alertRetryAction)
                
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

//MARK: UICollection View Datasource
extension MoviesListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shortMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell : MoviesListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListCollectionViewCell.identifierValue, for: indexPath) as? MoviesListCollectionViewCell else {
            fatalError("Unable to retrieve Collection View Cell")
        }
        let shortMovie : ShortMovie = self.shortMoviesArray[indexPath.row]
        movieCell.movieNameLabel.text = shortMovie.title
        guard let posterUrl = URL(string: shortMovie.poster ?? "") else {
            return movieCell
        }
        movieCell.movieImageView.sd_setImage(with: posterUrl, placeholderImage: placeholderImage, options: .continueInBackground, context: .none)
        return movieCell
    }
}

//MARK: UICollectionview Delegate
extension MoviesListViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.shortMoviesArray[indexPath.row]
        guard let selectedMovieID = selectedMovie.imdbID else {
            return
        }
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.selectedMovieIMDBID = selectedMovieID
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //Checking if the scrolling has reached bottom
        if (indexPath.row == self.shortMoviesArray.count - 1)
        {
            self.getListOfMoviesForStringFromRemoteURL(movieSearchString)
        }
    }
}

//MARK: UICollectionView Delegate Flow Layout
extension MoviesListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getHomeIconCellSize()
    }
    
    func getHomeIconCellSize() -> CGSize{
        let orientation = UIDevice.current.orientation
        var cellWidth : CGFloat = 0.0
        switch orientation {
        case .portrait, .portraitUpsideDown:
            cellWidth = (self.view.safeAreaLayoutGuide.layoutFrame.size.width/2) - 5
        default:
            cellWidth = (self.view.safeAreaLayoutGuide.layoutFrame.size.width/3) - 5
        }
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

extension MoviesListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.movieSearchString = searchText
        self.pagesLoaded = 1
        if (searchText.count >= 3) {
            emptyMovieListCollectionView()
            self.getListOfMoviesForStringFromRemoteURL(searchText)
        }else {
            emptyMovieListCollectionView()
        }
    }
    
    fileprivate func emptyMovieListCollectionView() {
        self.shortMoviesArray = []
        DispatchQueue.main.async {
            self.noResultsLabel.isHidden = false
            self.moviesListCollectionView.reloadData()
        }
    }
}
