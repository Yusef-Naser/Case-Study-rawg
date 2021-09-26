//
//  GameDetailsInteractor.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//VC


class GameDetailsInteractor {
    
    func getGame (id : Int , completion : @escaping CompletionHandler<ModelGame>) {
        ApiClient<ModelGame>.performRequest(route: .getGame(id: id )) { result , statusCode in
            switch result {
            case .success(let data) :
                completion(data , nil, statusCode , nil )
                return
            case .error(let error) :
                completion(nil, error, statusCode , nil )
                return
            }
        }
    }
    
}
