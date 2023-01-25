//
//  Extensions.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import Foundation
// NS Attributed String

public typealias StringHandler = ((String) -> Void)

extension String {
    var htmlAsAttributed: NSAttributedString? {
        
        let data = Data(self.utf8)
        
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        
    }
    
}



