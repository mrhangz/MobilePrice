import Foundation
import ObjectMapper

struct MobileImage: Mappable {
    
    var mobileID: Int?
    var imageURL: String?
    var id: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        mobileID <- map["mobile_id"]
        imageURL <- map["url"]
        id <- map["id"]
    }
}
