//#-hidden-code
import PlaygroundSupport
import SpriteKit

//#-end-hidden-code
/*:
 ## Fixing bugs

 Awesome! Our colliders are working, but we still have a few problems to be fixed, remember?
 
 The ball continues to rebound in our direction, but what we want is that it stops when it crosses the goal line.
 
 ## How are we going to do this?
 
 Well, our ideia can be split up into three things: **collisions detection, ignore all forces applied to our goal line collider (We do not want the ball to retreat back) and apply physics to the ball to make it stop**.
 
 ## Hands on!
 
 Alright, we already have the collision detection, so let's focus in the other two things.
 
 First assign false to the goalLine's isDynamic property. This will ensure that our goal line ignores all forces applied on it.
 
 Then, assign a null vector to the ball's physic body property. This will be applied when the ball crosses the goal line, making it to stop.
 
 For last, click in execute code to see what happens.*/
 
/*:
 Yeah, finally things are starting to come back to normal!
 
 Go to the next chapter to improve even more our game.
 */
//#-hidden-code
//#-end-hidden-code
