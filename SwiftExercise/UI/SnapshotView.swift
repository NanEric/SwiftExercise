//
//  SnapshotView.swift
//  SwiftExercise
//
//  Created by eric on 2026/1/6.
//

import Foundation
import UIKit
import SDWebImage

class SnapshotViewController: UIViewController {
    
    private var tableView: UITableView = UITableView(frame: CGRectZero, style: .plain)
//    private var snapshotImgView: UIImageView
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "snapshot view"
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
    }
}


extension SnapshotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier = "snapshot"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier) else {
            var newCell = ImageViewCell(style: .default, reuseIdentifier: cellIndentifier)
            return newCell
        }

        return cell
    }
    
    
}

class SnapshotDownloader {
    // MARK: - directly download image & return image
    func startFetchImage() async -> UIImage? {
        return await fetchImage(url: "https://example.com/image.jpg")
    }
    
    // MARK: - directly download image & call completion
    func startFetchImage(completion: @escaping (UIImage?)->Void) {
        Task {
            let image = try await fetchImage(url: "https://example.com/image.jpg")
            completion(image)
        }
    }
    
    // MARK: - directly download image & return Task
    func startFetchImage() -> Task<UIImage?, Error> {
        return Task {
            return try await fetchImage(url: "https://example.com/image.jpg")
        }
    }

    func fetchImage(url: String) async -> UIImage? {
        guard !url.isEmpty, let imageURL = URL(string: url) else { return nil }
        
        return await withCheckedContinuation { continuation in
            SDWebImageManager.shared.loadImage(
                with: imageURL,
                options: .highPriority,
                progress: nil) { image, data, error, cacheType, finished, _  in
                if let error = error {
                    print("图片下载失败: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                    return
                }
                continuation.resume(returning: image)
            }
        }        
    }

    func fetchImageView(url: String) -> UIImageView? {
        guard !url.isEmpty, let imageURL = URL(string: url) else { return nil }
        
        var imgView = UIImageView()
        imgView.sd_setImage(with: imageURL) {_,_,_,_ in 
        }

        return imgView
                    
    }
}
