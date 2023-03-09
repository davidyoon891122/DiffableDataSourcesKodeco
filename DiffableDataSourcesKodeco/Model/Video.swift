//
//  Video.swift
//  DiffableDataSourcesKodeco
//
//  Created by jiwon Yoon on 2023/03/09.
//

import UIKit

class Video {
    var id = UUID()
    var title: String
    var thumbnail: UIImage?
    var lessonCount: Int
    var link: URL?
    
    init(title: String, thumbnail: UIImage? = nil, lessonCount: Int, link: URL?) {
        self.title = title
        self.thumbnail = thumbnail
        self.lessonCount = lessonCount
        self.link = link
    }
}

extension Video {
    static let allVideos = [
        Video(
          title: "SwiftUI",
          thumbnail: UIImage(named: "swiftui"),
          lessonCount: 37,
          link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
        ),
        Video(
          title: "Data Structures & Algorithms in Swift",
          thumbnail: UIImage(named: "datastructures"),
          lessonCount: 29,
          link: URL(string: "https://www.raywenderlich.com/977854-data-structures-algorithms-in-swift")
        ),
        Video(
          title: "Beginning ARKit",
          thumbnail: UIImage(named: "arkit"),
          lessonCount: 46,
          link: URL(string: "https://www.raywenderlich.com/737368-beginning-arkit")
        ),
        Video(
          title: "Fastlane for iOS",
          thumbnail: UIImage(named: "fastlane"),
          lessonCount: 44,
          link: URL(string: "https://www.raywenderlich.com/1259223-fastlane-for-ios")
        ),
        Video(
          title: "Machine Learning in iOS",
          thumbnail: UIImage(named: "machinelearning"),
          lessonCount: 15,
          link: URL(string: "https://www.raywenderlich.com/1320561-machine-learning-in-ios")
        ),
        Video(
          title: "Beginning RxSwift",
          thumbnail: UIImage(named: "rxswift"),
          lessonCount: 39,
          link: URL(string: "https://www.raywenderlich.com/4743-beginning-rxswift")
        ),
        Video(
          title: "Demystifying Views in iOS",
          thumbnail: UIImage(named: "views"),
          lessonCount: 26,
          link: URL(string: "https://www.raywenderlich.com/4518-demystifying-views-in-ios")
        ),
        Video(
          title: "Push Notifications",
          thumbnail: UIImage(named: "notifications"),
          lessonCount: 33,
          link: URL(string: "https://www.raywenderlich.com/1258151-push-notifications")
        ),
        Video(
          title: "Reproducing Popular iOS Controls",
          thumbnail: UIImage(named: "controls"),
          lessonCount: 31,
          link: URL(string: "https://www.raywenderlich.com/5298-reproducing-popular-ios-controls")
        )
    
    ]
}
