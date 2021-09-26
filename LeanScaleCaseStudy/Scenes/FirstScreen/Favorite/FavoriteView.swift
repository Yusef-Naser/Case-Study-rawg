//
//  FavoriteView.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 22/09/2021.
//VC

import UIKit


class FavoriteView : UIView {
    
    let tableView : UITableView = {
        let l = UITableView()
        l.register(CellGameTable.self , forCellReuseIdentifier: CellGameTable.getIdentifier())
        l.tableFooterView = UIView()
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews () {
        addViews()
    }
    
    private func addViews () {
        addSubview(tableView)
        tableView.anchor(top: topAnchor , leading: leadingAnchor , bottom: bottomAnchor , trailing: trailingAnchor )
    }
    
    func setDelegate (delegate : FavoriteVC?) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
    
}
