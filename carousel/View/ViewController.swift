//
//  ViewController.swift
//  carousel
//
//  Created by Sho Yasuda on 2021/09/28.
//

import UIKit

enum Section: Int, CaseIterable {
    case carousel
    case normal
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    
    private var snapshot: Snapshot!
    private var dataSource: DataSource!
    
    static let prevElementKind = "prev-element-kind"
    static let nextElementKind = "next-element-kind"
    
    private let carousels: [String] = ["carousel1", "carousel2", "carousel3", "carousel4", "carousel5"]
    private let items: [String] = ["item1", "item2", "item3", "item4", "item5"]
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, env) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch sectionIndex {
            case Section.carousel.rawValue:
                return self.createCarouselSection()
            case Section.normal.rawValue:
                return self.createNormalSection()
            default: return nil
            }
        }
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.registerCustomCell(CarouselViewCell.self)
        collectionView.registerCustomCell(NormalViewCell.self)
        collectionView.registerCustomReusableFooterView(CarouselFooterView.self)
        collectionView.registerCustomReusableView(CarouselLeftButtonView.self, kind: ViewController.prevElementKind)
        collectionView.registerCustomReusableView(CarouselRightButtonView.self, kind: ViewController.nextElementKind)
        collectionView.collectionViewLayout =  compositionalLayout
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, element: String) -> UICollectionViewCell? in
            switch indexPath.section {
            case Section.carousel.rawValue:
                let cell = collectionView.dequeueReusableCustomCell(with: CarouselViewCell.self, indexPath: indexPath)
                cell.set(title: element)
                return cell
            case Section.normal.rawValue:
                let cell = collectionView.dequeueReusableCustomCell(with: NormalViewCell.self, indexPath: indexPath)
                cell.set(title: element)
                return cell
            default:
                return nil
            }
        })
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            switch indexPath.section {
            case Section.carousel.rawValue:
                if kind == UICollectionView.elementKindSectionFooter {
                    let footer = collectionView.dequeueReusableCustomFooterView(with: CarouselFooterView.self, indexPath: indexPath)
                    return footer
                }
                if kind == ViewController.prevElementKind {
                    let prev = collectionView.dequeueReusableCustomView(with: CarouselLeftButtonView.self, indexPath: indexPath, kind: kind)
                    return prev
                }
                if kind == ViewController.nextElementKind {
                    let next = collectionView.dequeueReusableCustomView(with: CarouselRightButtonView.self, indexPath: indexPath, kind: kind)
                    return next
                }
            default:
                return nil
            }
            return nil
        }
        dataSource.apply(snapshot(carousels: carousels, items: items))
    }
    
    private func snapshot(carousels: [String] = [], items: [String] = []) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(carousels, toSection: .carousel)
        snapshot.appendItems(items, toSection: .normal)
        return snapshot
    }
    
    private func createCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let sideInset: CGFloat = 5.5
        item.contentInsets = .init(
            top: 0,
            leading: sideInset,
            bottom: 0,
            trailing: sideInset)
        let groupWidth = collectionView.bounds.width * 0.86
        let groupHeight = groupWidth * 179 / 323
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(groupWidth),
            heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let sectionSideInset = (collectionView.bounds.width - groupWidth) / 2
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: sectionSideInset,
            bottom: 0,
            trailing: sectionSideInset)
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
                                                
            heightDimension: .absolute(50))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom)
        let prevSize = NSCollectionLayoutSize(
            widthDimension: .absolute(22),
            heightDimension: .absolute(22))
        let prevAnchor = NSCollectionLayoutAnchor(
            edges: [.leading],
            absoluteOffset: CGPoint(x: -((collectionView.bounds.width - groupWidth) / 2),
                                    y: 0))
        let prev = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: prevSize,
            elementKind: ViewController.prevElementKind,
            containerAnchor: prevAnchor)
        let nextSize = NSCollectionLayoutSize(
            widthDimension: .absolute(22),
            heightDimension: .absolute(22))
        let nextAnchor = NSCollectionLayoutAnchor(
            edges: [.trailing],
            absoluteOffset: CGPoint(x: ((collectionView.bounds.width - groupWidth) / 2),
                                    y: 0))
        let next = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: nextSize,
            elementKind: ViewController.nextElementKind,
            containerAnchor: nextAnchor)
        section.boundarySupplementaryItems = [prev, next, footer]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createNormalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupWidth = collectionView.bounds.width
        let groupHeight = groupWidth * 60 / 375
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(groupWidth),
            heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

