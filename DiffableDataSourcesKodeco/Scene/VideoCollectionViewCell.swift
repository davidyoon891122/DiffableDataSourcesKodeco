//
//  VideoCollectionViewCell.swift
//  DiffableDataSourcesKodeco
//
//  Created by jiwon Yoon on 2023/03/09.
//

import UIKit
import SnapKit

final class VideoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoCollectionViewCell"

    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
       
        [
            thumbnailView,
            titleLabel,
            subtitleLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        thumbnailView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.height.equalTo(212.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailView.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        subtitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return view
    }()
    
    private var video: Video? {
        didSet {
            thumbnailView.image = video?.thumbnail
            titleLabel.text = video?.title
            subtitleLabel.text = "\(video?.lessonCount ?? 0) lessons"
        }
    }
    
    func setupCell(video: Video) {
        self.video = video
        setupViews()
    }
}

private extension VideoCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
