//
//  YoutubeSearchResponse.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    
    let items : [VideoElement]
    
}

struct VideoElement : Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId : String
}
