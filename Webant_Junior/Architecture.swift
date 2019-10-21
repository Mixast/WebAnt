import Foundation
import Alamofire
import SwiftyJSON

struct Profile { // Структура Аnime
    var previewImageData: Data
    var fullImageData: Data
    var description: String

    init() {
        self.previewImageData = Data()
        self.fullImageData = Data()
        self.description = ""
    }
}

class ImageProfile: Any {         // Структура профиля друга Singleton
    var colectionImageData = [Profile]()
    var colectionImageUrl = [String]()
    
    func fillingUrlImage(order: Int, page: Int, limit: Int, completioHandler : (() ->Void)?) {
        let url = "http://gallery.dev.webant.ru/api/photos"
        let parameters : [String: String] = [ "limit" : String(limit),
                                              "new" : "true" ,
                                              "order" :  String(order),
                                              "page" : String(page),
                                              "popular" : "true" ]
        request(url,  method: .get, parameters: parameters).validate(contentType: ["application/json"]).responseJSON() { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.colectionImageUrl.removeAll()
                self.colectionImageData.removeAll()
                for (_, subJson):(String, JSON) in json["data"] {
                    let url = subJson["image"]["contentUrl"].stringValue
                    let descriptor = subJson["description"].stringValue
                    self.colectionImageUrl.append(url)
                    var profile = Profile()
                    profile.description = descriptor
                    self.colectionImageData.append(profile)
                    
                }
                completioHandler?()
            case .failure(let error):
                let arres = error.localizedDescription
                print(arres)
                completioHandler?()
            }
            
        }
        
    }

    private init() {}
    static let instance = ImageProfile()
}



func designFor(image: UIImageView) {  // Кастамизирую кнопку
    image.layer.borderWidth = 1
    image.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    image.layer.cornerRadius = 10
    image.backgroundColor = .clear
    image.layer.shadowOffset = CGSize(width: 3, height: 3)
    image.layer.shadowColor = UIColor.black.cgColor
    image.layer.shadowOpacity = 0.6
}

