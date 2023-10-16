//
//  Reqresync
//

import Foundation

struct StaticJSONMapper {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        // Gets the path and the data of the fil
        guard let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContets
        }
        
        // Decodes the data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
        
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContets
    }
}
