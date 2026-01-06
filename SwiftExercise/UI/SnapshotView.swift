//
//  SnapshotView.swift
//  SwiftExercise
//
//  Created by eric on 2026/1/6.
//

import Foundation
import UIKit


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
            var newCell = UITableViewCell(style: .default, reuseIdentifier: cellIndentifier)
            return newCell
        }

        return cell
    }
    
    
}

extension SnapshotViewController {
    func fetchImage(url: String) async -> UIImage? {
        guard !url.isEmpty else { return nil }
        
        if let imageURL = NSURL(string: url) {
            sd_setImage(with: imageURL) { _ in
                
            }
        }
    }
}
