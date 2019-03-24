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

@objc(Book_Sources_ChapterThreePageTwoViewController)
public class ChapterThreePageTwoViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    private var gameView: SKView!
    var scene: GoalkeeperScenePage2!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    lazy var mylabel: UILabel = {
        let label = UILabel()
        label.text = "Scene is nil"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        
        view.addSubview(mylabel)
        
        NSLayoutConstraint.activate([
            mylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mylabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        //        let scene = InitialScene(size: view.frame.size)
        let scene = GoalkeeperScenePage2(size: view.frame.size)
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
        let scene = gameView.scene as! GoalkeeperScenePage2
        let goalkeeperNode = scene.goalkeeper.spriteComponent.node

        switch message {
        case .floatingPoint(let value):
//            mylabel.text = "\(value)"
//            mylabel.isHidden = false
            goalkeeperNode.removeAllActions()
            scene.moveGoalkeeper(duration: value)
        default:
//            mylabel.text = "No value"
            goalkeeperNode.removeAllActions()
            scene.moveGoalkeeper(duration: 1.0)
        }
    }
}
