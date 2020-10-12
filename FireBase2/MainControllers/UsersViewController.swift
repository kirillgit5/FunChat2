//
//  UsersViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 02.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let users = [UserInformation]()
    private var dataSource: UICollectionViewDiffableDataSource<Section, UserInformation>!
    
    enum Section: Int, CaseIterable {
        case users
        
        func getTextForFooter() -> String {
            switch self {
            case .users:
                return "People :)"
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .getWhiteColorForMain()
        setupCollectionView()
        setupSearchBar()
//        createDataSource()
//        reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidDisappear), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInformation>()
        snapshot.appendSections([.users])
        snapshot.appendItems(users, toSection: .users)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func sortUsers(with symbols: String) {
        let filtredUsers = users.filter{ (user) -> Bool in
            user.containsSubLine(subLine: symbols)
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInformation>()
        snapshot.appendSections([.users])
        snapshot.appendItems(filtredUsers, toSection: .users)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .getWhiteColorForMain()
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionView.register(ChatSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: ChatSectionHeader.reuseId)
        
        view.addSubview(collectionView)
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
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[unowned self] (sectionIndex, layoutEnviroment ) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { fatalError("Unknow section kind") }
            switch section {
            case .users:
                return self.createUsersLayout()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createUsersLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSise = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSise, subitem: item, count: 2)
        group.interItemSpacing = .fixed(20)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                           elementKind: UICollectionView.elementKindSectionHeader,
                                                           alignment: .top)
    }
    
    @objc func keyboardDidAppear(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        var contentInset = self.collectionView.contentInset
        contentInset.bottom = keyboardFrameSize.height
        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height , right: 0)
        
    }
    
    @objc func keyboardDidDisappear() {
        let contentInset = UIEdgeInsets.zero
        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    
}

//MARK: - UISearchBarDelegate
extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortUsers(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        reloadData()
    }
}



//MARK: - DataSource
extension UsersViewController {
    
    
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, UserInformation>(collectionView: collectionView, cellProvider: { [unowned self] (collectionView, indexPath, userInform) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("uknow type section") }
            switch section {
            case .users:
                return self.configure(collectionView: collectionView, cellType: UserCell.self, with: userInform, for: indexPath)
            }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, type, IndexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: type,
                                                                                      withReuseIdentifier: ChatSectionHeader.reuseId ,
                                                                                      for: IndexPath) as? ChatSectionHeader else { fatalError("Error dequeueReusableSupplementaryView") }
            guard let section = Section(rawValue: IndexPath.section) else { fatalError("Unknow Section Kind")}
            sectionHeader.configure(text: section.getTextForFooter(), font: UIFont.getFontAvenir26(), textColor: .label)
            return sectionHeader
        }
    }
}

