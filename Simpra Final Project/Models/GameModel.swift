//
//  GameModel.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import Foundation


// MARK: - Response
struct Response: Decodable {
    //let count: Int?
    //let next: String?
    //let previous: NSNull?
    let results: [Game]?
    //let seoTitle, seoDescription, seoKeywords, seoH1: String?
    //let noindex, nofollow: Bool?
    //let description: String?
    //let filters: Filters?
    //let nofollowCollections: [String]?
}

// MARK: - Result
struct Game: Decodable {
    let id: Int?
    let name: String?
    let released: String?
    //let tba: Bool?
    let background_image: String?
    let rating: Double?
    let ratingTop: Int?
    //let ratings: [Rating]?
    //let ratingsCount, reviewsTextCount, added: Int?
    //let addedByStatus: AddedByStatus?
    //let metacritic, playtime, suggestionsCount: Int?
    //let updated: String?
    //let userGame: NSNull?
    //let reviewsCount: Int?
    //let saturatedColor, dominantColor: Color?
    //let platforms: [PlatformElement]?
    //let parentPlatforms: [ParentPlatform]?
    //let genres: [Genre]?
    //let stores: [Store]?
    //let clip: NSNull?
    //let tags: [Genre]?
    //let esrbRating: EsrbRating?
    //let shortScreenshots: [ShortScreenshot]?
}



/*
 
 // MARK: - Filters

 struct Filters {
     let years: [FiltersYear]?
 }

 // MARK: - FiltersYear
 struct FiltersYear {
     let from, to: Int?
     let filter: String?
     let decade: Int?
     let years: [YearYear]?
     let nofollow: Bool?
     let count: Int?
 }

 // MARK: - YearYear
 struct YearYear {
     let year, count: Int?
     let nofollow: Bool?
 }
 
 
 // MARK: - AddedByStatus
 struct AddedByStatus {
     let yet, owned, beaten, toplay: Int?
     let dropped, playing: Int?
 }
 
 // MARK: - EsrbRating
 struct EsrbRating {
     let id: Int?
     let name, slug: String?
 }
 
 enum Color {
     case the0F0F0F
 }
 
 enum Domain {
     case appsAppleCOM
     case epicgamesCOM
     case gogCOM
     case marketplaceXboxCOM
     case microsoftCOM
     case nintendoCOM
     case playGoogleCOM
     case storePlaystationCOM
     case storeSteampoweredCOM
 }

 enum Language {
     case eng
 }
 
 
 // MARK: - Genre
 struct Genre {
     let id: Int?
     let name, slug: String?
     let gamesCount: Int?
     let imageBackground: String?
     let domain: Domain?
     let language: Language?
 }
 
 
 // MARK: - ParentPlatform
 struct ParentPlatform {
     let platform: EsrbRating?
 }

 // MARK: - PlatformElement
 struct PlatformElement {
     let platform: PlatformPlatform?
     let releasedAt: String?
     let requirementsEn, requirementsRu: Requirements?
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
     let title: Title?
     let count: Int?
     let percent: Double?
 }

 enum Title {
     case exceptional
     case meh
     case recommended
     case skip
 }
 
 
 
 // MARK: - ShortScreenshot
 struct ShortScreenshot {
     let id: Int?
     let image: String?
 }
 
 // MARK: - Store
 struct Store {
     let id: Int?
     let store: Genre?
 }
 
 */
