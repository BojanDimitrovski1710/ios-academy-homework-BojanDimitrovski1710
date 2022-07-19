//
//  VolumeTableViewCell.swift
//  TVShows
//

import UIKit

// Same as with our UIViewController subclass, if we want to customize our UITableViewCell
// we need custom subclass.
final class TVShowTableViewCell: UITableViewCell {

    // MARK: - Private UI

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // One of THE MOST important function in UITableViewCell
        // This method will be called before your cell gets dequeued
        // So this will give you time to "reset" the data you have in this cell
        // Failure to do so can result in wrong data in the wrong cell
        // Imagine that one cell is missing its thumbnail image,
        // and you reuse cell and you don't clean the thumbnail, you will
        // have that same thumbnail once cell is reused.

        thumbnailImageView.image = nil
        titleLabel.text = nil
    }

}

// MARK: - Configure

extension TVShowTableViewCell {

    func configure(with item: TVShowItem) {
        // Here we are using conditional unwrap, meaning if we have the image, use that, if not, fallback to placeholder image.
        thumbnailImageView.image = item.image ?? UIImage(named: "icImagePlaceholder")
        titleLabel.text = item.name
    }
}

// MARK: - Private

private extension TVShowTableViewCell {

    func setupUI() {
        thumbnailImageView.layer.cornerRadius = 20
        thumbnailImageView.layer.masksToBounds = true
    }
}
