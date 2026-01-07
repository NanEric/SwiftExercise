//
//  ImageViewCell.swift
//  SwiftExercise
//
//  Created by eric on 2026/1/6.
//

import Foundation
import UIKit
import SDWebImage

class ImageViewCell: UITableViewCell {
    
    private var imageViewItem: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // reset the cell state
        imageViewItem.image = nil
        imageViewItem.sd_cancelCurrentImageLoad()
    }
    private func setupUI() {
        contentView.addSubview(imageViewItem)
    }

    func configuration(with imageUrl: String) {
        // imageViewItem.image = image
        let imgLoader = SnapshotDownloader()
        
        // MARK1: - download image & update UI
        Task {
            let image = try await imgLoader.fetchImage(url: imageUrl)
            DispatchQueue.main.async {
                self.imageViewItem.image = image
            }
        }
        
//        imgLoader.startFetchImage()

        // MARK2: - download image & update UI
//        imgLoader.fetchImage(url: imageUrl) { image in
//            DispatchQueue.main.async {
//                self.imageViewItem.image = image
//            }
//        }
        imgLoader.startFetchImage { image in
            DispatchQueue.main.async {
                self.imageViewItem.image = image
            }
        }

        // MARK3: - download image & update UI
//        let task = imgLoader.fetchImage(url: imageUrl)
//        Task {
//            if let image = try await task.value {
//                DispatchQueue.main.async {
//                    self.imageViewItem.image = image
//                }
//            }
//        }
        let task = imgLoader.startFetchImage()
        Task {
            if let image = try await task.value {
                DispatchQueue.main.async {
                    self.imageViewItem.image = image
                }
            }
        }
        
    }
}
