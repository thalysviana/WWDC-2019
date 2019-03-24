//#-hidden-code
import PlaygroundSupport
import SpriteKit

enum time: Double {
    case halfSecond = 0.5
    case playable = 0.6
    case oneSecond = 1.0
    case twoSecond = 2.0
}

func moveGoalkeeper(duration: time) {
    if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
        
        controller.send(.floatingPoint(duration.rawValue))
    }
}
//#-end-hidden-code
//:
//: ## Math is the answer!
//:
//: Ok, it's time to make our goalkeeper smarter!
//:
//: This time we're going to use math and trigonometry to help us move our character. The idea now is to make our goalkeeper "guess" on which direction our shoot will go.
//:
//: _"Hey, but if he knows where we're shooting, we ain't gonna be able to score a goal!"_
//:
//: Exactly! 😁 It's because of that we're going to use a little hack.
//:
//: After all. we don't want an impossible game, do we?
//:
//: ## Swipe shift
//:
//: ![alt text](swipe_graphic.png)
//:
//: Well, our goalkeeper only moves on the horizontal axe. So, to make it intercept the ball, we just have to know on which point of its "imaginary movement line" the ball is going to pass.
//:
//: All of this may sound too much complex, but actually we just have to calculate the horizontal distance of our swipe's starting point and ending point. Just like the image above shows.
//:
//: ## Exercise time!
//:
//: Alright! For this practice some calculations were already done for us. So let's jump right into the fun part.
//:
//:
//: - Experiment:
//:     1. Try some of the default values in the `moveGoalkeeper(duration:)` method below to see how our goalkeeper has changed.
//:     2. Click on `run code` to see what happens.
moveGoalkeeper(duration: /*#-editable-code*/.halfSecond/*#-end-editable-code*/)
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, .halfSecond, .oneSecond, .twoSecond, .playable)
//:
//: - Note:
//: You may have notice that depending on the duration selected our game can be very difficult. The trick is to shoot the ball near the goal edges. Give it a try!
//:
//: Wow! so many things! But there's just one more. Go to the next page and let's finish this game.

