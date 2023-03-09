//
//  VideosViewController.swift
//  DiffableDataSourcesKodeco
//
//  Created by jiwon Yoon on 2023/03/09.
//

import UIKit
import SnapKit
import SafariServices

enum Section {
    case main
}

class VideosViewController: UIViewController {
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Videos"
        
        return searchController
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            VideoCollectionViewCell.self,
            forCellWithReuseIdentifier: VideoCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private var videoList = Video.allVideos
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Video>
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureNavigation()
        setupViews()
    }
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}

extension VideosViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension VideosViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return videoList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VideoCollectionViewCell.identifier,
            for: indexPath
        ) as? VideoCollectionViewCell else { return UICollectionViewCell() }

        let video = videoList[indexPath.item]
        cell.setupCell(video: video)
        return cell
    }
}

extension VideosViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let video = dataSource.itemIdentifier(for: indexPath) else { return }
        guard let link = video.link else {
            print("Invalid Link")
            return
        }
        let safariViewController = SFSafariViewController(url: link)
        present(safariViewController, animated: true)
    }
}

extension VideosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        videoList = filteredVideos(for: searchController.searchBar.text)
        collectionView.reloadData()
    }
}

private extension VideosViewController {
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Videos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureNavigation() {
        navigationItem.title = "Videos"
        navigationItem.searchController = self.searchController
        definesPresentationContext = true
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == .phone
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(isPhone ? 280: 250))
            let itemCount = isPhone ? 1 : 3
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            return section
        })
        
    }
    
    func setupViews() {
        [
            collectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func filteredVideos(for queryOrNil: String?) -> [Video] {
        let videos = Video.allVideos
        
        guard let query = queryOrNil,
              !query.isEmpty else { return videos }
        
        return videos.filter {
            $0.title.lowercased().contains(query.lowercased())
        }
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, video) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell
            cell?.setupCell(video: video)
            return cell
        })
        
        return dataSource
    }
}

