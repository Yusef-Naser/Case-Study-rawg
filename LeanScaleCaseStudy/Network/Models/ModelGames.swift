//
//  ModelGames.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//

struct ModelGames : Codable {
    let count: Int?
    let next, previous: String?
    let results: [ModelGame]?
//    let seoTitle, seoDescription, seoKeywords, seoH1: String?
//    let noindex, nofollow: Bool?
//    let modelGamesDescription: String?
//    let filters: Filters?
//    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
//        case seoTitle = "seo_title"
//        case seoDescription = "seo_description"
//        case seoKeywords = "seo_keywords"
//        case seoH1 = "seo_h1"
//        case noindex, nofollow
//        case modelGamesDescription = "description"
//        case filters
//        case nofollowCollections = "nofollow_collections"
    }
}
