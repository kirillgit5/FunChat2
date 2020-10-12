//
//  MessengerViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 02.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit



class MessengerViewController: UIViewController {
    
    //MARK: - Private Property
    private var collectionView: UICollectionView!
    private let activeChats = [UserChat]()
    private let waitingChats = [UserChat]()
    private var dataSource: UICollectionViewDiffableDataSource<Section , UserChat>!
    
    enum Section: Int, CaseIterable {
        case waitingChats
        case activeChat
        
        func getTextForFooter() -> String {
            switch self {
            case .waitingChats:
                return "Waiting chats"
            case .activeChat:
                return "Active chats"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
//        createDataSource()
//        reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserChat>()
        snapshot.appendSections([.waitingChats, .activeChat])
        snapshot.appendItems(activeChats, toSection: .activeChat)
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .getWhiteColorForMain()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .getWhiteColorForMain()
        collectionView.register(WaitingCell.self, forCellWithReuseIdentifier: WaitingCell.reuseId)
        collectionView.register(ActiveChatsCell.self, forCellWithReuseIdentifier: ActiveChatsCell.reuseId)
        collectionView.register(ChatSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: ChatSectionHeader.reuseId)
        view.addSubview(collectionView)
    }
    
    
    
    
}



//MARK: - UISearchBarDelegate
extension MessengerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("2qdqd")
    }
}

//MARK: - CollectionViewCompositionalLayout
extension MessengerViewController {
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[unowned self] (sectionIndex, layoutEnviroment ) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { fatalError("Unknow section kind") }
            switch section {
            case .activeChat:
                return  self.createActiveChats()
            case .waitingChats:
                return self.createWaitingChats()
            }
        }
        return layout
    }
    
    private func createActiveChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(76))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 16, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    private func createWaitingChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(view.bounds.size.width / 4.7), heightDimension: .absolute(view.bounds.size.width / 4.7 + 20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 18
        section.contentInsets = .init(top: 16, leading: 20, bottom: 16, trailing: 20)
        
       
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
         let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                           elementKind: UICollectionView.elementKindSectionHeader,
                                                           alignment: .top)
    }
}

//MARK: - DataSource
extension MessengerViewController {
//    private func configure<T: ConfiguringCell, U: Hashable>(cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
//        guard   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("errror dequeueReusableCell") }
//        cell.configure(with: value)
//        return cell
//    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, UserChat>(collectionView: collectionView, cellProvider: { [unowned self] (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknow section kind") }
            switch section {
                
            case .activeChat:
                return self.configure(collectionView: collectionView, cellType: ActiveChatsCell.self, with: chat, for: indexPath)
            case .waitingChats:
                return self.configure(collectionView: collectionView, cellType: WaitingCell.self, with: chat, for: indexPath)
            }
            
        })
        
        dataSource.supplementaryViewProvider = { collectionView, type, IndexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: type,
                                                                                      withReuseIdentifier: ChatSectionHeader.reuseId ,
                                                                                      for: IndexPath) as? ChatSectionHeader else { fatalError("Error dequeueReusableSupplementaryView") }
            guard let section = Section(rawValue: IndexPath.section) else { fatalError("Unknow Section Kind")}
            sectionHeader.configure(text: section.getTextForFooter(), font: UIFont.getFontlaoSangamMN20(), textColor: .systemGray)
            return sectionHeader
        }
    }
}
