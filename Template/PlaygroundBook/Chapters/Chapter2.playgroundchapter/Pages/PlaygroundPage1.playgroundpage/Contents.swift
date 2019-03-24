//#-hidden-code
import PlaygroundSupport
import SpriteKit

func addCollisions(){
    if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
        
        controller.send(.string("addCollisions"))
    }
}
//#-end-hidden-code

//#-end-hidden-code
//: ## Before we start, take a look at our game
//:
//: _"Huh? What happened? The ball is crossing the goal and when it hit the post nothing happens!"._
//:
//: Calm down, young Padawan, in fact, what happened was quite simple. **The colliders of our game were removed**.
//:
//: ## Colliders
//:
//: Colliders are nothing more than components that define the physical form of an object. The object, in our case, would be the goal. And since there is no collider, the ball simply reacts to nothing.
//:
//: ## Ok, enough talk and let's practice!
//: - Experiment:
//: Add the method `addCollsiions()` below and click on run code to see what happens.
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, addCollisions())
/*#-editable-code Tap to write your code*//*#-end-editable-code*/
//:
//:Interesting, isn't it? Now the ball reacts to the other objects in our game.
//:
//: However, you may have noticed a new problem. The ball is bouncing in our direction every time we throw it towards the goal.
//:
//: But no problem, we'll fix this in the next page 🙂
//#-hidden-code
//#-end-hidden-code
