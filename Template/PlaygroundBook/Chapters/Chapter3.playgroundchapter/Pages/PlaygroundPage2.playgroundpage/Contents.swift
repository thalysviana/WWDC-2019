//#-hidden-code
import PlaygroundSupport
import SpriteKit

//#-end-hidden-code
/*:
 ## Math is the answer!

Ok, it's time to make our goalkeeper even smarter!
 
This time we're going to use math and trigonometry to help us move our character. The idea now is to make our goalkeeper "guess" on which direction our shoot will go.
 
 _"Hey, but if he knows where we're shooting, we ain't gonna be able to score a goal!"_
 
Exactly and well noticed by the way! 😁 It's because of that we're going to use a little hack.
 
After all. we don't want an impossible game, do we?
 
## Swipe shift
 
![alt text](swipe_graphic.png)
 
Well, our goalkeeper only moves on the horizontal axe. So, to make it intercept the ball, we just have to know on which point of its "imaginary movement line" the ball is going to pass.
 
All of this may sound too much complex, but actually we just have to calculate the horizontal distance of our swipe's starting point and ending point. Just like the image above shows.

## Exercise time!

 Alright! Here we have the variables `prevLocation` and `curLocation` that are representing our's swipe starting point and ending point, respectively.
 
 We also have a variable named `xDelta` on which we're going to assign the difference between our `curLocation` and `prevLocation`, which is in fact our horizontal distance.
 
 For last, we're going to call the `moveGoalkeeper(xDelta:,seconds:)` method passing `xDelta` value and the time in seconds that we want our goalkeeper to complete it's movement.*/
//: &nbsp;
//: - Note:
//: Remember that our goalkeeper now knows exactly where is the point on which the ball is going to pass. So, our little hack here is to pass a time value which will allow us to score a goal. Feel free to test these values and outcomes.
//:
//:
//: After that, click on `run code` and see what happens.
//:
//: Wow! So many things!! I hope you're enjoying our jorney until here.
//:
//: There's just one more thing that is missing. Go to the next page and let's finish this game.

