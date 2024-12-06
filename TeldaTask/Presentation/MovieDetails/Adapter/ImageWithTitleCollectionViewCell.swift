//
//  ImageWithTitleCollectionViewCell.swift
//  TeldaTask
//
//  Created by Sharaf on 12/5/24.
//

import UIKit

class ImageWithTitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        self.cornerRadius(10)
    }
    
    func configure(with movie: MoviesProperties) {
        titleLabel.text = movie.title
        pictureImageView.download(imageUrl: movie.posterPath)
    }
    
    func configure(with cast: Cast) {
        titleLabel.text = cast.originalName
        pictureImageView.download(imageUrl: cast.profilePath)
    }
}
