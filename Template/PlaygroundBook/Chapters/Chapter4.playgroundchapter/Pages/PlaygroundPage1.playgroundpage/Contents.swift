//#-hidden-code
import PlaygroundSupport
import SpriteKit

//#-end-hidden-code
/*:
## Last step
 
Ok, it's finally time to finish our game. There is only one thing missing: _the wall_.
 
In soccer, during free-kicks we always have the wall to make it difficult to score a goal. In our game we're gonna have a wall of two to four players. And their position will be decided randomly.
 
## Adding the wall
 
 ![alt text](the_wall.png)

The random position generation of the wall is very easy to do. But we must take care with it.

The place where we put the wall is a key thing in our game. Depending on the number of players it might be impossible to score a goal.
 
So what we usually do is treat that random generation in a way that is always possible to score a goal.
 
Luckyly, we already have this done for us!
 
## Practice time!
 
Time to finish the game! Add the wall using `addWall()` and call right after that `setWallPosition()`. This should be enough to keep our wall working.
Once you've done this click on `run code` to see the results.

Awesome! we've just created a game together. I hope you've enjoyed our jorney!
*/


