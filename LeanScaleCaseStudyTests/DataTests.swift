//
//  DataTests.swift
//  LeanScaleCaseStudyTests
//
//  Created by Yusef Naser on 25/09/2021.
//

@testable import LeanScaleCaseStudy

class DataTests {
    
    static let games = [
        ModelGame(id: 1, slug: "slug_1", name: "name_1", released: "released_1", backgroundImage: "background_1", metacritic: 1, genres: generaArray , gameDescription: "description_1") ,
        ModelGame(id: 2, slug: "slug_2", name: "name_2", released: "released_2", backgroundImage: "background_2", metacritic: 2 , genres: generaArray , gameDescription: "description_2") ,
        ModelGame(id: 3, slug: "slug_3", name: "name_3", released: "released_3", backgroundImage: "background_3", metacritic: 3 , genres: generaArray , gameDescription: "description_3")
    ]
    
    static let generaArray = [
        ModelGenre(id: 1, name: "genera_1", slug: "slug_1", gamesCount: 1, imageBackground: "background_1", domain: "domain_1", language: "language_1"),
        ModelGenre(id: 2, name: "genera_2", slug: "slug_2", gamesCount: 2, imageBackground: "background_2", domain: "domain_2", language: "language_2"),
        ModelGenre(id: 3, name: "genera_3", slug: "slug_3", gamesCount: 3, imageBackground: "background_3", domain: "domain_3", language: "language_3")
    ]
    
}
