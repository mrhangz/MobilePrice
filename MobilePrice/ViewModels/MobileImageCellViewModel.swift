import Foundation

struct MobileImageCellViewModel {
    
    var mobileImage: MobileImage!
    var imageURL: URL?
    
    init(mobileImage: MobileImage) {
        self.mobileImage = mobileImage
        var urlString = mobileImage.imageURL ?? ""
        if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://") {
            urlString = "http://\(urlString)"
        }
        imageURL = URL(string: urlString)
    }
}
