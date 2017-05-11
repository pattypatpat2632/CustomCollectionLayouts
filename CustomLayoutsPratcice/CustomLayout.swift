//
//  CustomLayout.swift
//  CustomLayoutsPratcice
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Foundation

class CustomLayout: UICollectionViewLayout {
    
    var cellAttributes = [UICollectionViewLayoutAttributes]()
    let numberOfColumns = 2
    var contentSize = CGSize()
    
    
    
    override func prepare() {
        guard let collectionView = collectionView else {return}
        
        if cellAttributes.isEmpty {
            // 1
            var contentHeight: CGFloat = 0.0
            let contentWidth: CGFloat = collectionView.bounds.width
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            
            
            //2
            var xOffset = [CGFloat]()
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            var column = 0
            
            
            //3
            for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
                
                //4
                let indexPath = IndexPath(item: item, section: 0)
                
                let itemHeight = CGFloat((arc4random_uniform(399) + 100))
                let itemWidth = columnWidth
                let itemXlocation = xOffset[column]
                let itemYlocation = yOffset[column]
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: itemXlocation, y: itemYlocation, width: itemWidth, height: itemHeight)
                cellAttributes.append(attributes)
                
                //5
                yOffset[column] = yOffset[column] + itemHeight
                column = column < numberOfColumns - 1 ? column + 1 : 0
            }
            
            //6
            yOffset = yOffset.sorted{$0 < $1}
            if let height = yOffset.last {
                contentHeight = height
            }
            
            contentSize = CGSize(width: contentWidth, height: contentHeight)
        }
    }
    
    override open var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttributes
    }
    
}
