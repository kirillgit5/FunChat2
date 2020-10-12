//
//  Extension + Bundle.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 02.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else { fatalError("Bad name") }
        guard let data = try? Data(contentsOf: url) else { fatalError("Bad data")}
        let jsonDecoder = JSONDecoder()
        guard let object = try? jsonDecoder.decode(type.self, from: data) else { fatalError("Bad decode")}
        return object
        
    }
}

