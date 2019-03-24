//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import SpriteKit
import PlaygroundSupport

@objc(Book_Sources_ChapterFivePageOneViewController)
public class ChapterFivePageOneViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    lazy var backgroundImageView: UIImageView = {
        let image = UIImage(named: "field_background")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var circlePortraitView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circlePortraitView.layer.cornerRadius = circlePortraitView.frame.width / 2
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
//        view.addSubview(backgroundImageView)
        view.addSubview(circlePortraitView)
//
//        NSLayoutConstraint.activate([
//            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//
        NSLayoutConstraint.activate([
            circlePortraitView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circlePortraitView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circlePortraitView.widthAnchor.constraint(equalToConstant: 350),
            circlePortraitView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        circlePortraitView.image = UIImage(named: "thalys.jpg")
        
    }
    
    /*
     public func liveViewMessageConnectionOpened() {
     // Implement this method to be notified when the live view message connection is opened.
     // The connection will be opened when the process running Contents.swift starts running and listening for messages.
     }
     */
    
    /*
     public func liveViewMessageConnectionClosed() {
     // Implement this method to be notified when the live view message connection is closed.
     // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
     // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
     }
     */
    
    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
    }
}
