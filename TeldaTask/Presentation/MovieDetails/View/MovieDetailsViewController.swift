//
//  MovieDetailsViewController.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import UIKit
import Combine

internal final class MovieDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var directorCollectionView: UICollectionView!
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var favoriteButtonView: UIView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var revenueLabel: UILabel!
    @IBOutlet weak private var overViewLabel: UILabel!
    @IBOutlet weak private var locationValueLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak private var statusView: UIView!
    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak private var backButtonView: UIView!
    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - Properties
    private let viewModel: MovieDetailsViewModel
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit\(Self.self)")
    }
    
    //MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationController(isHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModelObservers()
        setupCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        setupNavigationController(isHidden: false)
    }
    
    private func setupCollectionView() {
        setupCollectionView(collectionView: moviesCollectionView)
        setupCollectionView(collectionView: actorsCollectionView)
        setupCollectionView(collectionView: directorCollectionView)
    }
    private func setupCollectionView(collectionView: UICollectionView) {
        collectionView.register(nib: ImageWithTitleCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    //MARK: - Methods
    
    private func setupView() {
        backButtonView.circular()
        favoriteButtonView.circular()
        characterImageView.cornerRadius(25)
        statusView.cornerRadius(15)
    }
    
    private func setupViewModelObservers() {
        viewModel.moviePropertiesShown.sink { [weak self] movie in
            guard let movie = movie else { return }
            self?.configureUI(movie: movie)
        }
        .store(in: &cancellable)
        
        viewModel.similarMovies.sink { [weak self] value in
            self?.moviesCollectionView.reloadData()
        }
        .store(in: &cancellable)
        
        viewModel.crewOfMovies.sink { [weak self] value in
            self?.actorsCollectionView.reloadData()
            self?.directorCollectionView.reloadData()
        }
        .store(in: &cancellable)
    }
    private func configureUI(movie: MoviesProperties) {
        let url = URL(string: movie.posterPath)
        characterImageView.kf.setImage(with: url)
        statusLabel.text = movie.status
        nameLabel.text = movie.title
        overViewLabel.text = movie.overView
        revenueLabel.text = movie.revenue + "$"
        releaseDateLabel.text = "Release date:  \(movie.releaseDate.convertFormat())"
        taglineLabel.text = movie.tagLine
        favoriteButton.setImage(UIImage(systemName: viewModel.movieProperties.addToWashList ? "heart.fill":"heart"), for: .normal)
    }
    
    private func setupNavigationController(isHidden: Bool) {
        navigationController?.isNavigationBarHidden = isHidden
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        viewModel.movieProperties.addToWashList.toggle()
        let isFavorite = viewModel.movieProperties.addToWashList
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill":"heart"), for: .normal)
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesCollectionView {
            return min(viewModel.similarMovies.value.count, 5)
        } else if collectionView == actorsCollectionView {
            return min(viewModel.crewOfMovies.value?.actors.count ?? 0, 5)
        } else {
            return min(viewModel.crewOfMovies.value?.directors.count ?? 0, 5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageWithTitleCollectionViewCell = collectionView.dequeue(indexPath: indexPath)
        if collectionView == moviesCollectionView {
            let movie = viewModel.similarMovies.value[indexPath.row]
            cell.configure(with: movie)
            return cell
        } else if collectionView == actorsCollectionView {
            guard let actors = viewModel.crewOfMovies.value?.actors[indexPath.row] else { return UICollectionViewCell() }
            cell.configure(with: actors)
            return cell
        } else {
            guard let directors = viewModel.crewOfMovies.value?.directors[indexPath.row] else { return UICollectionViewCell() }
            cell.configure(with: directors)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
}
