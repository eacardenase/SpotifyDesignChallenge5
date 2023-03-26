//
//  PlayerView.swift
//  SpotifyDesignChallenge5
//
//  Created by Edwin Cardenas on 3/25/23.
//

import UIKit

class PlayerView: UIView {
    
    var topSpacer: UIView
    var bottomSpacer: UIView
    
    init() {
        
        topSpacer = Factory.makeSpacerView(height: 100)
//        topSpacer.backgroundColor = .red
        bottomSpacer = Factory.makeSpacerView(height: 100)
//        bottomSpacer.backgroundColor = .blue
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 200)
    }
}

extension PlayerView {
    func setupViews() {
        let stackView = Factory.makeStackView(withOrientation: .vertical)
        stackView.distribution = .fillProportionally
        
        let trackLabel = Factory.makeTrackLabel(withText: "Tom Sawyer")
        let albumLabel = Factory.makeAlbumLabel(withText: "Rush • Moving Pictures (2011 Remaster)")
        let progressView = ProgressView()
        let spotifyButtonView = makeSpotifyButtonCustomView()
        
        stackView.addArrangedSubview(topSpacer)
        stackView.addArrangedSubview(trackLabel)
        stackView.addArrangedSubview(albumLabel)
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(spotifyButtonView)
        stackView.addArrangedSubview(bottomSpacer)

        addSubview(stackView)
        
        topSpacer.heightAnchor.constraint(equalTo: bottomSpacer.heightAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // this custom view centers the button and allows to size itself
    func makeSpotifyButtonCustomView() -> UIView {
        let spotifyButton = Factory.makeSpotifyButton(withText: "PLAY ON SPOTIFY")
        
        let container = UIView()
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        container.addSubview(spotifyButton)
        
        NSLayoutConstraint.activate([
            spotifyButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            spotifyButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            spotifyButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        return container
    }
    
    func adjustForOrientation() {
        if UIDevice.current.orientation.isLandscape {
            topSpacer.isHidden = false
            bottomSpacer.isHidden = false
        } else {
            topSpacer.isHidden = true
            bottomSpacer.isHidden = true
        }
    }
}
