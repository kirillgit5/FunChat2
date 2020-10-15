//
//  MessengerViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 02.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class MessengerViewController: UIViewController, UICollectionViewDelegate {
    
    //MARK: - Private Property
    private var collectionView: UICollectionView!
    private var activeChats = [UserChat]()
    private let currentUser: UserInformation
    private var activeChatsListener: ListenerRegistration?
    
    
    private var dataSource: UICollectionViewDiffableDataSource<Section , UserChat>!
    
    enum Section: Int, CaseIterable {
        case activeChat
        
        func getTextForFooter() -> String {
            switch self {
            case .activeChat:
                return "Active chats"
            }
        }
    }
    
    init(currentUser: UserInformation) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        title = currentUser.username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData()
        
        activeChatsListener = ListenerService.shared.activeChatsObserve(chats: activeChats, completion: {[unowned self] (result) in
            switch result {
            case .success(let chats):
                self.activeChats = chats
                self.reloadData()
            case .failure(let error):
                self.showAlert(title: "Error!", message: "System Error")
            }
        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userChat = activeChats[indexPath.item]
        let chatVC = ChatInMessengerVC(senderhUser: currentUser, receiverUser: userChat)
        navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserChat>()
        snapshot.appendSections([.activeChat])
        snapshot.appendItems(activeChats, toSection: .activeChat)
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

        collectionView.register(ActiveChatsCell.self, forCellWithReuseIdentifier: ActiveChatsCell.reuseId)
        collectionView.register(ChatSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: ChatSectionHeader.reuseId)
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    deinit {
        activeChatsListener?.remove()
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
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
         let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                           elementKind: UICollectionView.elementKindSectionHeader,
                                                           alignment: .top)
    }
}

//MARK: - DataSource
extension MessengerViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, UserChat>(collectionView: collectionView, cellProvider: { [unowned self] (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknow section kind") }
            switch section {
                
            case .activeChat:
                return self.configure(collectionView: collectionView, cellType: ActiveChatsCell.self, with: chat, for: indexPath)
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

