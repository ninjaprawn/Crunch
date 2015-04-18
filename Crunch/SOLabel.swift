
//
//  SOLabel.swift
//  Crunch
//
//  Created by George Dan on 17/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

enum VerticalAlignment {
    case Top // default
    case Middle
    case Bottom
}

class SOLabel: UILabel {

    var verticalAlignment: VerticalAlignment
    
    override init(frame: CGRect) {
        verticalAlignment = VerticalAlignment.Top
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setVerticalAlignment(alignment: VerticalAlignment) {
        self.verticalAlignment = alignment
        self.setNeedsDisplay()
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
        var result: CGRect
        switch self.verticalAlignment {
            case VerticalAlignment.Top:
                result = CGRectMake(bounds.origin.x, bounds.origin.y, rect.size.width, rect.size.height);
                break
            
            case VerticalAlignment.Middle:
                result = CGRectMake(bounds.origin.x, bounds.origin.y + (bounds.size.height - rect.size.height) / 2, rect.size.width, rect.size.height);
                break
            
            case VerticalAlignment.Bottom:
                result = CGRectMake(bounds.origin.x, bounds.origin.y + (bounds.size.height - rect.size.height), rect.size.width, rect.size.height);
                break
            
            default:
                result = bounds
                break
        }
        return result
    }
    
    override func drawTextInRect(rect: CGRect) {
        var r = self.textRectForBounds(rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawTextInRect(r)
    }
    
}
