//
//  BaseCollectionViewCell.swift
//  
//
//  Created by James Rochabrun on 12/21/20.
//

import UIKit

// MARK:-  Generic Collectionview cell
public class BaseCollectionViewCell<V>: UICollectionViewCell {
    
    var viewModel: V? {
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
    func setupSubviews() {
    }
    
    // To be overriden. Super does not need to be called.
    func setupWith(_ viewModel: V) {
    }
    
    /// Swift UI
    func setupWith(_ viewModel: V, parent: UIViewController?) {
        
    }
}
