//
//  PopularMoviesViewController.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import UIKit
import SwiftUI
import Combine

internal final class PopularMoviesViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    //MARK: - Properties
    
    private let viewModel: PopularMoviesViewModel
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - Init
    init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
        setupViewModelObservers()
        setupNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    //MARK: - Methods
    private func setupTableView() {
        tableView.register(nib: PopularMovieTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func setupViewModelObservers() {
        viewModel.moviesProperties.sink { [weak self] value in
            self?.tableView.reloadData()
        }
        .store(in: &cancellable)
        viewModel.onLoading.sink {[weak self] value in
            guard let self else { return }
            value ? showActivityIndicator() : hideActivityIndicator()
        }
        .store(in: &cancellable)
    }
    
    private func setupNavigationBar(){
       title  = "Popular Movies"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleColor]
    }

}

extension PopularMoviesViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.moviesProperties.value.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.moviesProperties.value[section].year
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesProperties.value[section].groupedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel.moviesProperties.value[indexPath.section].groupedMovies[indexPath.row]
        let cell: PopularMovieTableViewCell = tableView.dequeue()
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieProperties = viewModel.moviesProperties.value[indexPath.section].groupedMovies[indexPath.row]
        let movieDetailsViewModel = MovieDetailsViewModel(movieProperties: movieProperties)
        let movieDetailsViewController = MovieDetailsViewController(viewModel: movieDetailsViewModel)
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        215
    }
}

extension PopularMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         let title = searchText
        if !title.isEmpty {
            viewModel.throttleSearchWith(title)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let title = searchBar.text, !title.isEmpty else { return }
        searchBar.resignFirstResponder()
        viewModel.searchMovieWith(title)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let title = searchBar.text, !title.isEmpty else { return }
        searchBar.text = ""
        viewModel.resetData()
    }
}
