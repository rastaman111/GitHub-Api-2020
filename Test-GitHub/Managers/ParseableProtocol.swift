//
//  ParseableProtocol.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 29.10.2020.
//

import Foundation

// Protocol for types that available for JSON Parse/Encode
protocol Parseable {
    
    // MARK: - Assissiated type for codable type
    associatedtype ParseableType: Codable
    
    /// Decode from data
    ///
    /// - Parameter data: data
    /// - Returns: Parsed object/scruct of assosiated type
    static func decodeFromData(data: Data) -> ParseableType?
    
    static func decodeFromDataArray(data: Data) -> [ParseableType]?
    
    /// Encode self to string
    ///
    /// - Returns: Data
    static func encode(fromEncodable encodable: ParseableType) -> Data?
}

// MARK: - Default protocol implementation
extension Parseable {
    static func decodeFromData(data: Data) -> ParseableType? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        var decodedData: ParseableType?
        
        do {
            decodedData = try decoder.decode(ParseableType.self, from: data)
        
        } catch (let error) {
            print(error.localizedDescription)
            return nil
        }
        return decodedData
    }
    
    static func decodeFromDataArray(data: Data) -> [ParseableType]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        var decodedData: [ParseableType]?
        
        do {
            decodedData = try decoder.decode([ParseableType].self, from: data)
        } catch (let error) {
            print(error.localizedDescription)
            return nil
        }
        return decodedData
    }
    static func encode(fromEncodable encodable: ParseableType) -> Data? {
        let encoder = JSONEncoder()
        var encodedData: Data
        
        do {
            encodedData = try encoder.encode(encodable)
        } catch (let error) {
            print(error.localizedDescription)
            return nil
        }
        return encodedData
    }
}

