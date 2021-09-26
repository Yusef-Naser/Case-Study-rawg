//
//  ModelGame.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//
import Foundation

struct ModelGame :  Codable , Equatable {
    static func == (lhs: ModelGame, rhs: ModelGame) -> Bool {
        return lhs.id == rhs.id
    }
    
    
//    public func encode(with coder: NSCoder) {
//
//    }
//    required public init(coder decoder: NSCoder) {
//        self.id = nil
//        self.slug = nil
//        self.backgroundImage = nil
//        self.name = nil
//        self.released = nil
//        self.metacritic = nil
//        self.genres = nil
//        self.gameDescription = nil
//    }
    
    let id: Int?
    let slug, name, released: String?
    let backgroundImage: String?
    let metacritic : Int?
    let genres: [ModelGenre]?
    let gameDescription : String?
//    let tba: Bool?
//    let rating: Double?
//    let ratingTop: Int?
//    let ratings: [Rating]?
//    let ratingsCount, reviewsTextCount, added: Int?
//    let addedByStatus: AddedByStatus?
//    let playtime, suggestionsCount: Int?
//    let updated: String?
//    let userGame: JSONNull?
//    let reviewsCount: Int?
//    let saturatedColor, dominantColor: String?
//    let platforms: [PlatformElement]?
//    let parentPlatforms: [ParentPlatform]?
//    let genres: [Genre]?
//    let stores: [Store]?
//    let clip: JSONNull?
//    let tags: [Genre]?
//    let esrbRating: EsrbRating?
//    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, metacritic ,
             genres
        case gameDescription = "description"
        case backgroundImage = "background_image"
//        case tba
//        case rating
//        case ratingTop = "rating_top"
//        case ratings
//        case ratingsCount = "ratings_count"
//        case reviewsTextCount = "reviews_text_count"
//        case added
//        case addedByStatus = "added_by_status"
//        case playtime
//        case suggestionsCount = "suggestions_count"
//        case updated
//        case userGame = "user_game"
//        case reviewsCount = "reviews_count"
//        case saturatedColor = "saturated_color"
//        case dominantColor = "dominant_color"
//        case platforms
//        case parentPlatforms = "parent_platforms"
//        case stores, clip, tags
//        case esrbRating = "esrb_rating"
//        case shortScreenshots = "short_screenshots"
    }
}

struct ModelGenre:  Codable {
    
    
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let domain: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}
