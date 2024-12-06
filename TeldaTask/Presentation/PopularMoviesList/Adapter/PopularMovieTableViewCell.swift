//
//  PopularMovieTableViewCell.swift
//  TeldaTask
//
//  Created by Sharaf on 12/5/24.
//

import UIKit
import Kingfisher

class PopularMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var washListButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewMovieLabel: UILabel!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var posterMovieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        releaseDateLabel.cornerRadius(10)
        containerView.cornerRadius(10)
    }
    
    func configure(with: MoviesProperties) {
        titleMovieLabel.text = with.title
        overviewMovieLabel.text = with.overView
        releaseDateLabel.text = with.releaseDate.convertFormat()
        posterMovieImageView.download(imageUrl: with.posterPath)
        washListButton.setImage(UIImage(systemName: with.addToWashList ? "heart.fill" : "heart"), for: .normal)
    }
}

extension UIImageView {
    func download(imageUrl: String) {
        let placeholderImage = UIImage(systemName: "photo")
        let url = URL(string: imageUrl)!
        self.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options:[.transition(.fade(0.2)),
                     .cacheOriginalImage
            ]
        )
    }
}
