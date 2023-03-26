//
//  ViewController.swift
//  SpotifyDesignChallenge5
//
//  Created by Edwin Cardenas on 3/25/23.
//

import UIKit

class ViewController: UIViewController {
    
    var stackView: UIStackView
    let playerView: PlayerView
    
    var bottomAnchorConstraint = NSLayoutConstraint()
    
    init() {
        stackView = Factory.makeStackView(withOrientation: .vertical)
        playerView = PlayerView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForOrientationChanges()
        setupViews()
    }
}

extension ViewController {
    
    func registerForOrientationChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // MARK: - Rotation
    @objc func rotated() {
        playerView.adjustForOrientation()
        
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
            bottomAnchorConstraint.isActive = true
        } else {
            stackView.axis = .vertical
            bottomAnchorConstraint.isActive = false
        }
    }
    
    func setupViews() {
        stackView.addArrangedSubview(makeAlbumImageView())
        stackView.addArrangedSubview(makePlayerStackView())
        
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        // only active if orientation == landscape
        bottomAnchorConstraint = stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
    }
    
    // MARK: Factory methods
    func makeAlbumImageView() -> UIImageView {
        let albumImage = Factory.makeImageView(named: "rush")
        let heightAnchorConstraint = albumImage.heightAnchor.constraint(equalTo: albumImage.widthAnchor)
        heightAnchorConstraint.priority = .defaultHigh
        heightAnchorConstraint.isActive = true
        
        return albumImage
    }
    
    func makePlayerStackView() -> UIStackView {
        let stackView = Factory.makeStackView(withOrientation: .vertical)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        stackView.addArrangedSubview(playerView)
        
        return stackView
    }
}
