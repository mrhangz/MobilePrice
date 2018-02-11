import Foundation

class MobileDetailsViewModel {
    var mobile: Mobile!
    var mobileImages: [MobileImage] = [MobileImage]() {
        didSet {
            didSetImages?()
        }
    }
    var apiManager: APIManagerProtocol!
    var didSetImages: (() -> Void)?
    
    init(mobile: Mobile, apiManager: APIManagerProtocol = APIManager()) {
        self.mobile = mobile
        self.apiManager = apiManager
        getImages()
    }
    
    func getImages() {
        apiManager.getImages(for: mobile.id!) { [weak self] (images, error) in
            if let images = images {
                self?.mobileImages = images
            }
        }
    }
    
    func mobileName() -> String? {
        return mobile.name
    }
    
    func mobileDescription() -> String? {
        return mobile.description
    }
    
    func priceText() -> String {
        let priceText = mobile.price != nil ? String(format: "%.2f", mobile.price!) : "-"
        return "Price: $\(priceText)"
    }
    
    func ratingText() -> String {
        let ratingText = mobile.rating != nil ? String(format: "%.1f", mobile.rating!) : "-"
        return "Rating: \(ratingText)"
    }
}
