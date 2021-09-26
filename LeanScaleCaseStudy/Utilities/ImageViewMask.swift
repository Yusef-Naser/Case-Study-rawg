//
//  ImageViewMask.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//

import UIKit

class ImageViewMask : UIImageView {
    
    private lazy var viewMask : UIView = {
       let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2036333476)
        return v
    }()
    
    public init() {
        super.init(frame: .zero)
        addMask()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder )
    }
    
    private func addMask () {
        self.addSubview(viewMask)
        viewMask.anchor(top: topAnchor , leading: leadingAnchor , bottom: bottomAnchor , trailing: trailingAnchor )
    }
}
