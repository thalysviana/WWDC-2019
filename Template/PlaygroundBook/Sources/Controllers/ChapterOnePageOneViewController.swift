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

@objc(Book_Sources_ChapterOnePageOneViewController)
public class ChapterOnePageOneViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    private var gameView: SKView!
    private var scene: WallScene!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        
//        if let view = view as? SKView {
//            scene = WallScene(size: view.frame.size)
//            scene.scaleMode = .aspectFill
//
//            view.ignoresSiblingOrder = true
//            view.showsPhysics = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//
//            view.presentScene(scene)
//
//        }
        gameView = SKView(frame: view.frame)
        view = gameView
        
//        let scene = InitialScene(size: view.frame.size)
//        let scene = GoalkeeperScene(size: view.frame.size)
        scene = WallScene(size: view.frame.size)
        scene.scaleMode = .aspectFill

        gameView.ignoresSiblingOrder = true
        gameView.showsPhysics = false
        gameView.showsFPS = false
        gameView.showsNodeCount = false
        
        gameView.presentScene(scene)
        
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
