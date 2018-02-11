import Foundation
import Alamofire
import SwiftyJSON

protocol APIManagerProtocol {
    func getMobiles(completion: @escaping ([Mobile]?, Error?) -> Void)
    func getImages(for mobileID: Int, completion: @escaping ([MobileImage]?, Error?) -> Void)
}

class APIManager: APIManagerProtocol {
    static let shared: APIManager = APIManager()
    
    func getMobiles(completion: @escaping ([Mobile]?, Error?) -> Void) {
        Alamofire.request("https://scb-test-mobile.herokuapp.com/api/mobiles/", encoding: JSONEncoding.default)
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    let array = JSON(value)
                    var mobiles: [Mobile] = []
                    for json in array.arrayValue {
                        if let mobile = Mobile(JSON: json.dictionaryObject!) {
                            mobiles.append(mobile)
                        }
                    }
                    completion(mobiles, nil)
                case .failure(let error):
                    completion(nil , error)
                }
        }
    }
    
    func getImages(for mobileID: Int, completion: @escaping ([MobileImage]?, Error?) -> Void) {
        Alamofire.request("https://scb-test-mobile.herokuapp.com/api/mobiles/\(mobileID)/images", encoding: JSONEncoding.default)
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    let array = JSON(value)
                    var images: [MobileImage] = []
                    for json in array.arrayValue {
                        if let image = MobileImage(JSON: json.dictionaryObject!) {
                            images.append(image)
                        }
                    }
                    completion(images, nil)
                case .failure(let error):
                    completion(nil , error)
                }
        }
    }
}
