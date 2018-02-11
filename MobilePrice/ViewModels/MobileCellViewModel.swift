import Foundation

struct MobileCellViewModel {
    
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
        let priceText = mobile.price != nil ? String(format: "%.02f", mobile.price!) : "-"
        mobilePrice = "Price: $\(priceText)"
        let ratingText = mobile.rating != nil ? String(format: "%.01f", mobile.rating!) : "-"
        mobileRating = "Rating: \(ratingText)"
        self.isFavourite = isFavourite
        self.hideFavourite = hideFavourite
    }
}
