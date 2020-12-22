//
//  BaseCollectionViewCell.swift
//  
//
//  Created by James Rochabrun on 12/21/20.
//

import UIKit

// MARK:-  Generic Collectionview cell
open class BaseCollectionViewCell<V>: UICollectionViewCell {
    
    public var viewModel: V? {
        didSet {
            guard let viewModel = viewModel else { return }
            setupWith(viewModel)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSubviews()
    }
    
    // To be overriden. Super does not need to be called.
    open func setupSubviews() {
    }
    
    // To be overriden. Super does not need to be called.
    open func setupWith(_ viewModel: V) {
    }
    
    /// Swift UI
    open func setupWith(_ viewModel: V, parent: UIViewController?) {
        
    }
}
