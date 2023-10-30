

import SwiftUI

struct Meik: Codable, Hashable, Identifiable {
    var imageURL: Int
    var id: String
    var concentration: String
    var name: String
    var location: String
    var year: String
    var email: String
    var text: String
    var tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case imageURL, name, location, tags, id, concentration, text, email, year
    }
    
    static func preview() -> Meik {
        Meik(imageURL: 0,
             id: "Mw9mp1qTmlfwpKRrILbYcLFA39U2",
             concentration: "CompsSci",
             name: "Roberto Gonzales",
             location: "Peru",
             year: "'26",
             email: "r",
             text:"",
             tags: ["International", "Meiklejohn Leader", "Double Concentrating"])
    }
}

extension Meik {
    func containsTag(_ tag: String) -> Bool {
        tags.first { $0 == tag } != nil
    }
}

extension Encodable {
    func asDictionary() -> [String: Any]{
        guard let data = try? JSONEncoder().encode(self) else{
            return [:]
        }
        
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        }  catch {
            return [:]
        }
    }
}
