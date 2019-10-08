//
//  ReadPropertyList.swift
//  TableView_Test
//
//  Created by LeeX on 6/13/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
protocol ReadPList {
    var resource: String { get }
    var type: String { get }
    func read()
}

class PListReader: ReadPList {
    
    var resource: String
    var type: String
    lazy private var data = {
        return NSDictionary()
    }()
    
    init(resource: String, type: String) {
        self.resource = resource
        self.type = type
    }
    
    func read() {
        guard let path = Bundle.main.path(forResource: resource, ofType: type)
            , let nsDict = NSDictionary(contentsOfFile: path)
            else { return }
        self.data = nsDict
    }
    
    fileprivate func loadNames() -> [String] {
        if let names = data.value(forKey: resource.lowercased()) as? [String] {
            return names
        }
        return []
    }
}

struct PropertyList {
    static func loadNames(by reader: ReadPList) -> [String] {
        reader.read()
        if let pListReader = reader as? PListReader {
            return pListReader.loadNames()
        }
        return []
    }
}
