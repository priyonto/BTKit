//
//  MainViewController.swift
//  BTKitTester
//
//  Created by Rinat Enikeev on 6/9/19.
//  Copyright © 2019 Rinat Enikeev. All rights reserved.
//

import UIKit
import BTKit

class MainViewController: UITableViewController {

    private var ruuviTags: [RuuviTag] = [RuuviTag]()
    private var ruuviTagsSet: Set<RuuviTag> = Set<RuuviTag>()
    private var scanToken: ObservationToken?
    private let cellReuseIdentifier = "MainTableViewCellReuseIdentifier"
    private var reloadingTimer: Timer?
    
    deinit {
        scanToken?.invalidate()
        reloadingTimer?.invalidate()
    }
}

// MARK: - View lifecycle
extension MainViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startObserving()
        startReloading()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopObserving()
        stopReloading()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ruuviTags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MainTableViewCell
        let tag = ruuviTags[indexPath.row]
        configure(cell: cell, tag: tag)
        return cell
    }
    
    private func configure(cell: MainTableViewCell, tag: RuuviTag) {
        cell.uuidOrMacLabel.text = tag.mac ?? tag.uuid
        cell.accessoryType = tag.isConnectable ? .detailDisclosureButton : .none
    }
}

// MARK: - UITableViewDelegate
extension MainViewController {
    
}

// MARK: - Observing & Reloading
extension MainViewController {
    private func startObserving() {
        scanToken = BTKit.scanner.scan(self) { [weak self] (observer, device) in
            if let tag = device.ruuvi?.tag {
                self?.ruuviTagsSet.update(with: tag)
            }
        }
    }
    
    private func stopObserving() {
        scanToken?.invalidate()
    }
    
    private func startReloading() {
        reloadingTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { [weak self] _ in
            if let set = self?.ruuviTagsSet {
                self?.ruuviTags = set.sorted(by: { $0.rssi > $1.rssi })
                self?.tableView.reloadData()
            }
        })
    }
    
    private func stopReloading() {
        reloadingTimer?.invalidate()
        reloadingTimer = nil
    }
}