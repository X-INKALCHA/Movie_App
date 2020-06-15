//
//  MovieDetailViewController.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

import SDWebImage

enum MovieDetailCellType : Int, CaseIterable {
    case image = 0
    case title
    case ratingNplot
    case credits
}

class MovieDetailViewController: UIViewController {
    
    var movieDetailTableView : UITableView = {
        var tableView : UITableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MovieDetailPosterTableViewCell.self, forCellReuseIdentifier: MovieDetailPosterTableViewCell.identifierValue)
        tableView.register(MovieDetailTitleTableViewCell.self, forCellReuseIdentifier: MovieDetailTitleTableViewCell.identifierValue)
        tableView.register(MovieDetailRatingnPlotTableViewCell.self, forCellReuseIdentifier: MovieDetailRatingnPlotTableViewCell.identifierValue)
        tableView.register(MovieDetailCreditsTableViewCell.self, forCellReuseIdentifier: MovieDetailCreditsTableViewCell.identifierValue)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    let movieDetailLoadingActivityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var selectedMovie : FullMovie = FullMovie()
    var movieImageView : UIImageView = UIImageView()
    var selectedMovieIMDBID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addAllSubviews()
        self.title = "Movie Detail"
        guard let movieID = selectedMovieIMDBID else {
            return
        }
        getMovieWithID(movieID: movieID)
    }
    
    fileprivate func addAllSubviews() {
        self.view.addSubview(self.movieDetailTableView)
        self.view.addSubview(movieDetailLoadingActivityIndicator)
        applyAutolayoutToMovieDetailTableView()
        applyAutolayoutToActivityIndicator()
    }
    
    fileprivate func applyAutolayoutToMovieDetailTableView() {
        movieDetailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        movieDetailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        movieDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        movieDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func applyAutolayoutToActivityIndicator() {
        movieDetailLoadingActivityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        movieDetailLoadingActivityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    fileprivate func getMovieWithID(movieID: String) {
        DispatchQueue.main.async {
            self.movieDetailLoadingActivityIndicator.startAnimating()
        }
        NetworkManager.sharedManager.getMovieWithID(movieID: movieID) { (movie, error) in
            DispatchQueue.main.async {
                self.movieDetailLoadingActivityIndicator.stopAnimating()
            }
            if (error == nil) {
                guard  let fullMovie = movie else {
                    return
                }
                self.selectedMovie = fullMovie
                DispatchQueue.main.async {
                    self.movieDetailTableView.dataSource = self
                    self.movieDetailTableView.delegate = self
                    self.movieDetailTableView.reloadData()
                }
                guard let imageURL = URL(string: fullMovie.poster ?? "") else {return}
                self.movieImageView.sd_setImage(with: imageURL) { (image, error, SDImageCacheType, url) in
                    self.movieImageView.image = image
                    let refreshImageIndex = IndexPath(row: 0, section: 0)
                    DispatchQueue.main.async {
                        self.movieDetailTableView.reloadRows(at: [refreshImageIndex], with: .automatic)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController.init(title: "Error!", message: error, preferredStyle: .alert)
                    let alertCancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    let alertRetryAction = UIAlertAction.init(title: "Retry", style: .default) { (action) in
                        guard let movieID = self.selectedMovieIMDBID else {
                            return
                        }
                        self.getMovieWithID(movieID: movieID)
                    }
                    alert.addAction(alertCancelAction)
                    alert.addAction(alertRetryAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension MovieDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieDetailCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType : MovieDetailCellType = MovieDetailCellType(rawValue: indexPath.row) ?? MovieDetailCellType.credits
        
        switch cellType {
        case .image:
            guard let cell : MovieDetailPosterTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailPosterTableViewCell.identifierValue, for: indexPath) as? MovieDetailPosterTableViewCell
                else {
                    fatalError("Unable to retrieve alarm table view cell")
            }
            cell.prepareCellWithMovie(movie: self.selectedMovie)
            cell.movieImageView.image = self.movieImageView.image ?? #imageLiteral(resourceName: "noImage.png")
            return cell
        
        case .title:
            guard let cell : MovieDetailTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTitleTableViewCell.identifierValue, for: indexPath) as? MovieDetailTitleTableViewCell
                else {
                    fatalError("Unable to retrieve alarm table view cell")
            }
            cell.prepareCellWithMovie(movie: self.selectedMovie)
            return cell
        
        case .ratingNplot:
            guard let cell : MovieDetailRatingnPlotTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailRatingnPlotTableViewCell.identifierValue, for: indexPath) as? MovieDetailRatingnPlotTableViewCell
                else {
                    fatalError("Unable to retrieve alarm table view cell")
            }
            cell.prepareCellWithMovie(movie: self.selectedMovie)
            return cell
        
        case .credits:
            guard let cell : MovieDetailCreditsTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCreditsTableViewCell.identifierValue, for: indexPath) as? MovieDetailCreditsTableViewCell
                else {
                    fatalError("Unable to retrieve alarm table view cell")
            }
            cell.prepareCellWithMovie(movie: self.selectedMovie)
            return cell
        }
    }
}

extension MovieDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

