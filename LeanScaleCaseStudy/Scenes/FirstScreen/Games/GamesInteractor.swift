//
//  GamesInteractor.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 23/09/2021.
//VC


class GamesInteractor {
    
    func getGames (page : Int, search : String? , completion : @escaping CompletionHandler<ModelGames>) {
        ApiClient<ModelGames>.performRequest(route: .getGames(page: page, search : search )) { result , statusCode in
            switch result {
            case .success(let data) :
                completion(data , nil, statusCode, page)
                return
            case .error(let error) :
                completion(nil, error, statusCode, page)
                return
            }
        }
    }
    
}
