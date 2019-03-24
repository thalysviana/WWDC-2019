//#-hidden-code
import PlaygroundSupport
import SpriteKit

func detectCollisions() {
    if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
        
        controller.send(.string("detectCollisions"))
    }
}

func nullifyBallsVelocity() {
    if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
        
        controller.send(.string("nullifyBallsVelocity"))
    }
}

//#-end-hidden-code
//: ## Fixing bugs
//:
//: Awesome! Our colliders are working, but we still have a few problems to be fixed, remember?
//:
//: The ball continues to rebound in our direction, but what we want is that it stops when it crosses the goal line.
//:
//: ## How are we going to do this?
//:
//: Well, our ideia can be split up into three things: **detect collisions, ignore all forces applied to our goal line collider (We do not want the ball to retreat back) and apply physics to the ball to make it stop**.
//:
//: ## Hands on!
//:
//: We already have the first ones. The only things missing now is add ball's physics.
//:
//: We're going to do this by setting ball's velocity to null everytime it crosses the goal line. That way we can garantee that our ball will stop after we score a goal.
//: - Experiment:
//:     1. Add the method `nullifyBallsVelocity()` right above `detectCollisions()` to assign a null vector to the balls velocity.
//:     2. Click on `run code` to see what happens.
//:
detectCollisions()
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, nullifyBallsVelocity())
/*#-editable-code Tap to write your code*//*#-end-editable-code*/
//:
//: Yeah! finally things are starting to come back to normal.
//:
//: Go to the next chapter to continue our game improvement.
//:
//#-hidden-code
//#-end-hidden-code
