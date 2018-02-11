import UIKit

class MobileImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    func displayCell(viewModel: MobileImageCellViewModel) {
        imageView.sd_setImage(with: viewModel.imageURL)
    }
}
