import XCTest
@testable import MobilePrice

class MockAPIManager: APIManagerProtocol {
    var getMobilesIsCalled = false
    var getImagesIsCalled = false
    
    func getMobiles(completion: @escaping ([Mobile]?, Error?) -> Void) {
        let mobiles = [
            Mobile(name: "test name 1", price: 100, thumbImageURL: "http://www.test.com/image.jpg", id: 1, brand: "test brand", rating: 4, description: "test description 1"),
            Mobile(name: "test name 2", price: 200.5, thumbImageURL: "www.test.com/image.jpg", id: 2, brand: "test brand", rating: 5, description: "test description 2"),
            Mobile(name: "test name 3", price: 300, thumbImageURL: "https://www.test.com/image.jpg", id: 3, brand: "test brand", rating: 3.5, description: "test description 3")
        ]
        getMobilesIsCalled = true
        completion(mobiles, nil)
    }
    func getImages(for mobileID: Int, completion: @escaping ([MobileImage]?, Error?) -> Void) {
        let images = [
            MobileImage(mobileID: 1, imageURL: "http://www.test.com/image1.jpg", id: 1),
            MobileImage(mobileID: 1, imageURL: "http://www.test.com/image2.jpg", id: 2),
            MobileImage(mobileID: 1, imageURL: "http://www.test.com/image3.jpg", id: 3)
        ]
        getImagesIsCalled = true
        completion(images, nil)
    }
}

class MobilePriceTests: XCTestCase {
    var mobileListViewModel: MobileListViewModel!
    var apiManager: MockAPIManager!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMobileListViewModelShouldCallGetMobiles() {
        // given
        apiManager = MockAPIManager()
        
        // when
        mobileListViewModel = MobileListViewModel(apiManager: apiManager)
        
        // then
        XCTAssert(apiManager.getMobilesIsCalled)
    }
    
    func testGetMobilesShouldReturnCorrectList() {
        // given
        apiManager = MockAPIManager()
        
        // when
        mobileListViewModel = MobileListViewModel(apiManager: apiManager)
        
        // then
        XCTAssertEqual(mobileListViewModel.displayingMobiles.count, 3)
        XCTAssertEqual(mobileListViewModel.displayingMobiles[0].name, "test name 1")
    }
    
    func testChangeListTypeShouldReturnFavouriteList() {
        // given
        apiManager = MockAPIManager()
        mobileListViewModel = MobileListViewModel(apiManager: apiManager)
        mobileListViewModel.favouriteIDs = [2]
        mobileListViewModel.listType = .All
        
        // when
        mobileListViewModel.changeListType(type: .Favourite)
        
        // then
        XCTAssertEqual(mobileListViewModel.displayingMobiles.count, 1)
        XCTAssertEqual(mobileListViewModel.displayingMobiles[0].name, "test name 2")
    }
    
    func testSortMobilesShouldReturnCorrectOrder() {
        // given
        apiManager = MockAPIManager()
        mobileListViewModel = MobileListViewModel(apiManager: apiManager)
        
        // when
        mobileListViewModel.sortMobiles(by: .priceHighToLow)
        
        // then
        XCTAssertEqual(mobileListViewModel.displayingMobiles[0].id, 3)
        XCTAssertEqual(mobileListViewModel.displayingMobiles[1].id, 2)
        XCTAssertEqual(mobileListViewModel.displayingMobiles[2].id, 1)
        
        // when
        mobileListViewModel.sortMobiles(by: .rating)
        
        // then
        XCTAssertEqual(mobileListViewModel.displayingMobiles[0].id, 2)
        XCTAssertEqual(mobileListViewModel.displayingMobiles[1].id, 1)
        XCTAssertEqual(mobileListViewModel.displayingMobiles[2].id, 3)
    }
}
