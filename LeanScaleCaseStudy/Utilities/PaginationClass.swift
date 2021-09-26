//
//  PaginationClass.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//

class PaginationClass <T> {
    
    public var currentPage : Int = 0
    public var totalCount : Int = 1
    public var paginate : Bool = false
    public var listData : [T] = []
    private var firstLoad = true
    
    public var refreshValue = false
    
    public init() {}
    
    public func resetData() {
        listData = []
        currentPage = 0
        paginate = false
    }
    
    
    public func beforeCallService () -> Bool  {
        if listData.count >= totalCount {
            return false
        }
        if paginate {
            return false
        }
        paginate = true
        currentPage += 1
        firstLoad = false
        return true
    }
    
    public func isFirstLoad () -> Bool {
        
        return firstLoad
    }
    
    public func setDataPagination (listData : [T] , currentPage : Int , totalCount : Int ) {
        self.currentPage = currentPage
        self.totalCount = totalCount
        self.paginate = false
        self.listData += listData
        firstLoad = false
    }
    
    
    public func allowPagination (index : Int ) -> Bool {

        if listData.count >= totalCount {
            return false
        }
        if paginate {
            return false
        }

        if index == listData.count - 1 {
            return true
        }
        return false
    }
    
    
}
