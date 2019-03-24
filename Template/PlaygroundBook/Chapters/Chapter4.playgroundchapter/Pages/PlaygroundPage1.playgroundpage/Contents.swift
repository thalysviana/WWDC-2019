//#-hidden-code
import PlaygroundSupport
import SpriteKit

func setWallPosition() {
    if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
        
        controller.send(.string("setWallPosition"))
    }
}

//#-end-hidden-code
//: ## Last step
//:
//: Ok, it's finally time to finish our game. There is only one thing missing: _the wall_.
//:
//: In soccer, during free kicks we always have the wall to make it difficult to score a goal. In our game we're gonna have a wall of two to four players. And their position will be decided randomly.
//:
//: ## Adding the wall
//:
//: ![alt text](the_wall.png)
//:
//: The random position generation of the wall is a very easy to do thing. But we must take care with it.
//:
//: The place where we put the wall is a key thing in our game. Depending on the number of players it might be impossible to score a goal.
//:
//: So what we usually do is treat that random generation in a way that is always possible to score a goal.
//:
//: Luckyly, we already have this done for us!
//:
//: ## Practice time!
//: - Experiment:
//:     Time to finish the game!
//:     1. Set wall position using `setWallPosition()` 
//:     3. Click on `run code` to see what happens.
//:
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, setWallPosition())
/*#-editable-code Tap to write your code*//*#-end-editable-code*/
//: # **Congratulations! You've just made a brand new game!**
//: I hope you enjoyed and had fun during our journey. WWDC 19 is almost there and I'm very excited to see what awesome ideas we're gonna have this year.
//:
//: See you soon, my friend!
//:
//: [Next: About me](@next)

