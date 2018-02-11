import Foundation

class MobileCellViewModel {
    weak var delegate: MobileTableViewCellDelegate?
    var mobile: Mobile!
    var imageURL: URL?
    var mobileName: String!
    var mobileDescription: String!
    var mobilePrice: String!
    var mobileRating: String!
    var isFavourite: Bool!
    var hideFavourite: Bool!
    
    init(mobile: Mobile, isFavourite: Bool = false, hideFavourite: Bool = false) {
        self.mobile = mobile
        imageURL = URL(string: mobile.thumbImageURL ?? "")
        mobileName = mobile.name ?? ""
        mobileDescription = mobile.description ?? ""
        let priceText = mobile.price != nil ? String(format: "%.2f", mobile.price!) : "-"
        mobilePrice = "Price: $\(priceText)"
        let ratingText = mobile.rating != nil ? String(format: "%.1f", mobile.rating!) : "-"
        mobileRating = "Rating: \(ratingText)"
        self.isFavourite = isFavourite
        self.hideFavourite = hideFavourite
    }
    
    func addToFavourite() {
        delegate?.addToFavourite(mobileID: mobile.id!)
    }
}
