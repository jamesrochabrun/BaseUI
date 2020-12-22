//
//  DiffableCollectionView.swift
//  
//
//  Created by James Rochabrun on 12/21/20.
//

import UIKit


public protocol DiffableSection: Hashable {
    associatedtype DiffableViewModel: Hashable
    var viewModels: [DiffableViewModel] { get }
}

@available(iOS 13, *)
public final class DiffableCollectionView<SectionIdentifier: DiffableSection,
                                                   CellType: BaseCollectionViewCell<SectionIdentifier.DiffableViewModel>>: BaseView, UICollectionViewDelegate {
    
    
    // MARK:- UI
    private var collectionView: UICollectionView!

    // MARK:- Type Aliases
    typealias CellViewModelIdentifier = SectionIdentifier.DiffableViewModel // represents an item in a section
    
    private typealias DiffDataSource = UICollectionViewDiffableDataSource<SectionIdentifier, CellViewModelIdentifier>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, CellViewModelIdentifier>
    
    typealias SelectedContentAtIndexPath = ((CellViewModelIdentifier, IndexPath) -> Void)
    var selectedContentAtIndexPath: SelectedContentAtIndexPath?
    
    // MARK:- Diffable Data Source
    private var dataSource: DiffDataSource?
    private var currentSnapshot: Snapshot?
    
    private weak var parent: UIViewController?
    
    // MARK:- Life Cycle
    convenience public init(layout: UICollectionViewLayout, parent: UIViewController?) {
        self.init()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(CellType.self)
        addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.collectionViewLayout = layout
        configureDataSource()
        self.parent = parent
    }
    
    // MARK:- 1: DataSource Configuration
    private func configureDataSource() {
        dataSource = DiffDataSource(collectionView: collectionView) { collectionView, indexPath, model in
            let cell: CellType = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setupWith(model , parent: self.parent)
            return cell
        }
    }
    
    // MARK:- 2: ViewModels injection and snapshot
    public func applySnapshotWith(_ sections: [SectionIdentifier]) {
        currentSnapshot = Snapshot()
        currentSnapshot?.appendSections(sections)
        sections.forEach { currentSnapshot?.appendItems($0.viewModels, toSection: $0) }
        dataSource?.apply(currentSnapshot!)
    }
    
    // MARK:- UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = dataSource?.itemIdentifier(for: indexPath) else { return }
        selectedContentAtIndexPath?(viewModel, indexPath)
    }
}
