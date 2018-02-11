import Foundation

enum MobileSortingType {
    case priceHighToLow
    case priceLowToHigh
    case rating
}

class MobileListViewModel {
    var mobiles: [Mobile]?
    var favouriteIDs: [Int] = [Int]()
    var displayingMobiles: [Mobile] = [Mobile]() {
        didSet {
            didUpdateMobiles?()
        }
    }
    var apiManager: APIManager!
    
    var didUpdateMobiles: (() -> Void)?
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
        getMobiles()
    }
    
    func getMobiles() {
        apiManager.getMobiles { [weak self] (mobiles, error) in
            if let mobiles = mobiles {
                self?.mobiles = mobiles
                self?.displayingMobiles = mobiles
            }
        }
    }
    
    func sortMobiles(by type: MobileSortingType) {
        switch type {
        case .priceHighToLow:
            displayingMobiles = displayingMobiles.sorted(by: { (m1, m2) -> Bool in
                m1.price ?? 0 > m2.price ?? 0
            })
        case .priceLowToHigh:
            displayingMobiles = displayingMobiles.sorted(by: { (m1, m2) -> Bool in
                m1.price ?? 0 < m2.price ?? 0
            })
        case .rating:
            displayingMobiles = displayingMobiles.sorted(by: { (m1, m2) -> Bool in
                m1.rating ?? 0 > m2.rating ?? 0
            })
        }
    }
    
    func addMobileToFavourite(mobileID: Int) {
        favouriteIDs.append(mobileID)
        print("\(favouriteIDs.count)")
    }
    
    func isFavourite(index: Int) -> Bool {
        return favouriteIDs.contains(displayingMobiles[index].id!)
    }
}
