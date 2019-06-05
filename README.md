# TowerDefense -- Defending Konstantinople
The game is a classic Tower Defense game. Defend your city by putting down towers and survive as best as you can!
Here is a complete breakdown of all the features we have:
## Towers
Within the abstract class of Towers, we have BasiccTower, FollowTower, and  MortarTower. They have their own upgrade paths and special behavior.  
### BasiccTower
- Targets onto a monster and shoots a straight bullet at them. If the monster is fast enough, however, the bullet can miss
### FollowTower
- Targets onto a monster and follows it until that monster dies, or until the bullet hits the monster
- If the monster dies before the bullet hits it or it's penetration level is high enough, it will find the nearest monster within 200m     and target it
### MortarTower
- Targets a monster, calculates it's position assuming it goes straight, and aims for that spot in a parabolic manner, and explodes 
  hitting other monsters in the process
- The mortar can miss if the monster turns before the mortar shell lands because it assumes the monster goes straight
### Penetration
- Most of the upgrade features are obvious: increase in firerate, range, blast-radius, etc.
- However, the way Penetration works is intentional. If the bullet kills a monster instantly, depending on its level, the bullet will    continue down its path. But, if it doesn't kill the monster instantly, the bullet will just die and not penetrate

## Monsters
## Projectiles
Projectiles are the things that do the actual damage on monsters. They are created by Towers and store many fields such as X-Velocity, Y-Velocity, Size, etc. 
### Mortar Shell
- MortarTower's projectile "jumps" off the map parabolicolly and lands on it's destination and check for monsters in it's blast radius
### Straight Bullet
- It aims at a monster. Then it calculates X and Y velocities based on that monster's location. Then it moves, check if it monster is     there, and repeats
### Follow Bullet
- the FollowBullet changes it's direction towards its targeted monsters every 20 milliseconds
- It retargets to the nearest monster that is within 200 units away if it has a high enough penetration level or if the monster it aimed for dies
- We faced a lot of bugs related to retargeting when the monster would die before the follow-bullet landed
## Buttons
Two buttons that the game has are the cancel-selling buttons and pause buttons which are pretty self-explanatory.
Another two buttons the game has are:
### Buy-Tower Buttons
- The Side-Menu Buttons store their own Tower
- If it's been clicked, it loads it's tower onto the map. Behinds the scenes it just keeps its tower on the map at (-1,-1). And then that object changes its location to where the user wants it to be placed
### Tower-Specific Buttons
The way other buttons work can be a bit non-intuitive but they make sense Java-wise
- A tower owns a Set-of-Buttons object that creates three buttons: Left-Path, Right-Path, and Sell.
- Selling it will give half of its value back, including the money from upgrades
### Hover Graphics
- Bloops up a text bubble with descriptions of the button-action  
## Game Flow
- We have several game modes that dictate which conditional body is called, depending on whether it's paused, resumed, or waiting to start for example
- The game loads all the background graphics first, moves the moving objects based on their path, checks for user input, and then displays all the moving objects
## For Demoing and Testing Purposes, we've also added cheatcodes to advance the game faster 
- Press Q to move onto next level
- Press W to move on five levels ahead
- Press E to move onto level 99
- Press M to get 10,000 dollars
- Press O to add 25 health 
- Press P to subtract 25 health

# Development Logs

5/19
- Wrote code for background map and checking if the the area the mouse is hovering over is suitable for tower placement (Qiong)
- Created a path class with coordinates specific to the map (Qiong)

5/20
- Started Writing Towers. Realized that current class structure wasn't clear --> developed/re-structured Towers/Projectiles class and method structuring for better development flow (Jo)
- Wrote Monster class with basic move that follows the path that updates every frame (Qiong)
5/21
- Wrote the first Tower's attack(), the math equation for it. It's pretty cool and I used trig to calculate it's 2-D velocities. I also started writing Projectiles class but forgot to commit it (Jo)
- Created a Monster spawner and despawner. The spawn rate and number is based on level and monsters now deal damage to the map when they reaches the end. (Qiong)

5/22
- Implemented Firerate for Tower which uses Java's time system and almost finished working on Projectiles. Instead of the tower shooting monsters, it shoots the projectile and that delivers the damage when it touches the monster (Jo)
- Changed monsters to have their movement be based on Java system time. (Qiong)

5/23
- finished Projectiles and integrated it's basic mechanics into the game. Now instead of monsters invisibly dying, there's a graphic object that's shot(Jo)
- created a graphic circle around the mouse to show validity of tower placement and its range(Jo)
- created method for calculating movement to help towers predict monster movement (Qiong)
5/24
-caused a play and pause for the game and implemented a money system (Qiong)
-started writing follow bullet and click-buy feature for towers (Jo)

5/25-5/27
- Created a main menu for the game and tweaked money system(Qiong)
- wrote methods to compensate for time elapsed when the game is paused, since spawning is based on time elapsed (Qiong)
- Wrote Red Slimes class to spawn stronger slimes at higher levels, spawns weaker slimes at death (Qiong)
- Created button objects that store towers and when clicked, they load their respective tower into the game and onto the mouse and places when the mouse presses onto the map (Jo)
- Wrote followBullet projectile which locks onto a monster and follows it. Figuring out what to do when the monster it locked onto died, and when it died unexpectedly (for ex, another tower kills it first) in a clean and efficient way took some time but I got it eventually (Jo)

5/28
- followBullet now goes after the nearest bullet, and put a limit to it's following (Jo)
- Cleaned, reorganized Projectiles class/mechanics and updated money feature so it depends on the tower (Jo)
- Fixed bug with play button and changed to use mouseClicked method (Qiong)

5/29
- Cleaned, reorganized methods in the main game file (Jo)
- Wrote a mushroom class which is a weaker but faster version of the slime (Qiong)
- Made it so that when a redSlime dies, the slimes that it spawns don't spawn on top of each other, but are still on the path (Qiong)

5/30
- Used Collections.sort to sort the Monsters based on how far they are along the path. (Qiong)
- Wrote Tank Monster Class (Qiong)
- Began to work on and plan out Mortar Shell projectile (Qiong)
- Fixed retargeting monster bug by putting tags on them (Jo)
- Created an upgrading tower system and upgrade button graphics along with it so users can upgrade their towers (Jo)

5/31
- Created cancel building tower feature (Jo)
- Created show-tower's-range-when-clicked feature (Jo)

6/2
- fixed bug in tower canceling and adjusted it's graphics (Jo)

6/3
- Wrote conditional structural code for when hovering feature should happen: when buying a tower and upgrading (Jo)
- Finished writing the Mortar shell projectile and started to test it by replacing Tower 2's projectiles with it, spent alot of time debugging the mortar shell spawning (Qiong)
- Began to write Mortar Tower (Qiong)

6/4
- Finished hovering feature with adjustments on what text should pop up and where (Jo)
- Fixed bugs involved with multiple tower upgrading/buying (Jo)
- Created Sell Tower feature (Jo)
- Fixed a lot of bugs that came with extensive testing (Jo)
- Finished Mortar Tower and fixed issues with concurrent modification (Qiong)
- Tuned the Mortar Tower and the strengths of monsters, created a boss known as BossK (Qiong)
- Created game Over menu (Qiong)
