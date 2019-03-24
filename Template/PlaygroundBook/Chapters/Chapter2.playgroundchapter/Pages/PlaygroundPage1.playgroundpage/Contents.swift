//#-hidden-code
import PlaygroundSupport
import SpriteKit

func addCollisions(){
    if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
        
        controller.send(.string("addCollisions"))
    }
}
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
//:Interesting. Now the ball reacts to something. We just can't see it 😅.
//: ## The secret
//: ![alt text](collisions_explanation.jpeg)
//:
//:
//:Actually what is happening is that we have colliders in the edges of the goal and right behind the goal line. These colliders are important to identify if the ball hit the post or if it crossed the goal line.
//:
//: - Note:
//: The image above represent both the post and goal line colliders.
//:
//: But is all fine. We're gonna fix this in the next page.
//:
//: [Next: Bug fix](@next)
