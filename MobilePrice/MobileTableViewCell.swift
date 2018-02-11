import UIKit
import SDWebImage

class MobileTableViewCell: UITableViewCell {
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var favouriteButton: UIButton!
    
    func displayCell(viewModel: MobileCellViewModel) {
        thumbnailView.sd_setImage(with: viewModel.imageURL)
        nameLabel.text = viewModel.mobileName
        descriptionLabel.text = viewModel.mobileDescription
        priceLabel.text = viewModel.mobilePrice
        ratingLabel.text = viewModel.mobileRating
        favouriteButton.isSelected = viewModel.isFavourite
        favouriteButton.isHidden = viewModel.hideFavourite
    }
}
