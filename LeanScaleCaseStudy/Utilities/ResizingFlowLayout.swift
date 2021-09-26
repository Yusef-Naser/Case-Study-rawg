//
//  ResizingFlowLayout.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 25/09/2021.
//

import UIKit

public class ResizingFlowLayout : UICollectionViewFlowLayout {
    public var cellsPerRow = 2
    public var height : CGFloat = 100
    public init(insets : UIEdgeInsets) {
       super.init()
       self.sectionInset = insets
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
       super.prepare()
       guard let collectionView = collectionView else { return }
       setItemSize(collectionView: collectionView)
   }
   //    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
   //        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
   //        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
   //        return context
   //    }
    
    
    public func setItemSize (collectionView : UICollectionView) {
        var marginsAndInsets : CGFloat = 0
        if #available(iOS 11.0, *) {
            marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        } else {
            // Fallback on earlier versions
            marginsAndInsets = sectionInset.left + sectionInset.right +  minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        }
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        itemSize = CGSize(width: itemWidth, height: height )
    }
    
}


