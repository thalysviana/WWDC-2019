//#-hidden-code
import PlaygroundSupport
import SpriteKit

enum time: Double {
    case halfSecond = 0.5
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
//: ## A not so smart goalkeeper...
//:
//: Look who showed up! We have a goalkeeper in our game now. However he doesn't do much yet. Except for standing still in the middle of the goal 😆.
//:
//: But once more, this is not a problem for us. Soon we will fix it.
//:
//: ## Artificial intelligence
//:
//: Nowadays is it very common for games to adopt some kind of Artifitial Inteligence (AI). The reason is because it makes our games more fun and challenging.
//:
//: After all, what would be the fun of playing a game without a challenge?
//:
//: In our game this is no different. It's still very easy to make goals. Therefore, what we're going to do now is add some intelligence to our goalkeeper.
//:
//: ## Actions
//:
//: Our intelligence will be based on actions. Actions can be many things like, for example, moving, hiding, following a path, repeating some other action... Anyway, I think you've got the ideia.
//:
//: For our goalkeeper we will initially create a very simple action. He will walk a path from one end of the goal to the other.
//:
//: ## Time to action!
//:
//: Our path is already set up to us. Leaving only the movement duration to be set.
//:
//: - Experiment:
//:     1. Try some of the default values in the `moveGoalkeeper(duration:)` method below to see how actions can impact his movements.
//:     2. Click on `run code` to see what happens.
moveGoalkeeper(duration: /*#-editable-code*/.halfSecond/*#-end-editable-code*/)
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, .halfSecond, .oneSecond, .twoSecond)
//:
//: Haha! Our goalkeeper now moves by itself! Although it still not so hard to score... What shall we do then? 🧐
//#-hidden-code
//#-end-hidden-code
