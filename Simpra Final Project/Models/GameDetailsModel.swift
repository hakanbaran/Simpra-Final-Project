//
//  GameDetailsModel.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import Foundation


/*
 struct GameDetailResponse: Decodable {
     let gameItem : [GameDescription]
 }
 struct GameDescription: Decodable {
     let description: Int
 }
 */

struct SearchResultGame: Decodable {
    
    let id: Int?
    let description: String?
}



/*
 // MARK: - SearchResultGame
 struct SearchResultGame {
     let id: Int?
     let slug, name, nameOriginal, description: String?
     let metacritic: Int?
     let metacriticPlatforms: [MetacriticPlatform]?
     let released: String?
     let tba: Bool?
     let updated: String?
     let backgroundImage, backgroundImageAdditional: String?
     let website: String?
     let rating: Double?
     let ratingTop: Int?
     let ratings: [Rating]?
     let reactions: [String: Int]?
     let added: Int?
     let addedByStatus: AddedByStatus?
     let playtime, screenshotsCount, moviesCount, creatorsCount: Int?
     let achievementsCount, parentAchievementsCount: Int?
     let redditURL: String?
     let redditName, redditDescription, redditLogo: String?
     let redditCount, twitchCount, youtubeCount, reviewsTextCount: Int?
     let ratingsCount, suggestionsCount: Int?
     let alternativeNames: [String]?
     let metacriticURL: String?
     let parentsCount, additionsCount, gameSeriesCount: Int?
     let userGame: NSNull?
     let reviewsCount: Int?
     let saturatedColor, dominantColor: String?
     let parentPlatforms: [ParentPlatform]?
     let platforms: [PlatformElement]?
     let stores: [Store]?
     let developers, genres, tags, publishers: [Developer]?
     let esrbRating: EsrbRating?
     let clip: NSNull?
     let descriptionRaw: String?
 }

 // MARK: - AddedByStatus
 struct AddedByStatus {
     let yet, owned, beaten, toplay: Int?
     let dropped, playing: Int?
 }

 // MARK: - Developer
 struct Developer {
     let id: Int?
     let name, slug: String?
     let gamesCount: Int?
     let imageBackground: String?
     let domain: String?
     let language: Language?
 }

 enum Language {
     case eng
 }

 // MARK: - EsrbRating
 struct EsrbRating {
     let id: Int?
     let name, slug: String?
 }

 // MARK: - MetacriticPlatform
 struct MetacriticPlatform {
     let metascore: Int?
     let url: String?
     let platform: MetacriticPlatformPlatform?
 }

 // MARK: - MetacriticPlatformPlatform
 struct MetacriticPlatformPlatform {
     let platform: Int?
     let name, slug: String?
 }

 // MARK: - ParentPlatform
 struct ParentPlatform {
     let platform: EsrbRating?
 }

 // MARK: - PlatformElement
 struct PlatformElement {
     let platform: PlatformPlatform?
     let releasedAt: String?
     let requirements: Requirements?
 }

 // MARK: - PlatformPlatform
 struct PlatformPlatform {
     let id: Int?
     let name, slug: String?
     let image, yearEnd: NSNull?
     let yearStart: Int?
     let gamesCount: Int?
     let imageBackground: String?
 }

 // MARK: - Requirements
 struct Requirements {
     let minimum, recommended: String?
 }

 // MARK: - Rating
 struct Rating {
     let id: Int?
     let title: String?
     let count: Int?
     let percent: Double?
 }

 // MARK: - Store
 struct Store {
     let id: Int?
     let url: String?
     let store: Developer?
 }

 */
