//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import SpriteKit
import PlaygroundSupport

/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
public func instantiateLiveView() -> PlaygroundLiveViewable {
    
    let view = SKView(frame: CGRect(x: 0, y: 0, width: 512, height: 768))
    let scene = WallScene(size: CGSize(width: 512, height: 768))
    
    scene.scaleMode = .aspectFill
    view.presentScene(scene)
    
    return view
    
//    let storyboard = UIStoryboard(name: "LiveView", bundle: nil)
//
//    guard let viewController = storyboard.instantiateInitialViewController() else {
//        fatalError("LiveView.storyboard does not have an initial scene; please set one or update this function")
//    }
//
//    guard let liveViewController = viewController as? LiveViewController else {
//        fatalError("LiveView.storyboard's initial scene is not a LiveViewController; please either update the storyboard or this function")
//    }
//
//    return liveViewController
}

