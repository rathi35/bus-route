//
//  DecodedArray.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import Foundation

struct DecodedArray<T: Decodable>: Decodable {
    
    typealias DecodedArrayType = [T]
    
    var array: DecodedArrayType
    
    private struct DynamicCodingKeys: CodingKey {
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var tempArray = DecodedArrayType()
        
        for key in container.allKeys {
            if let parentKey = decoder.userInfo[.parentKey] as? ParentKey {
                parentKey.identifier = key.stringValue
            }
            let decodedObject = try container.decode(T.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        array = tempArray
    }
}

extension DecodedArray: Collection {
    
    typealias Index = DecodedArrayType.Index
    typealias Element = DecodedArrayType.Element
    
    var startIndex: Index { return array.startIndex }
    var endIndex: Index { return array.endIndex }
    
    subscript(index: Index) -> Iterator.Element {
        get { return array[index] }
    }
    
    func index(after i: Index) -> Index {
        return array.index(after: i)
    }
}

final class ParentKey {
    var identifier: String?
}

extension CodingUserInfoKey {
    static let parentKey = CodingUserInfoKey(rawValue: "\(ParentKey.self)")!
}
