# TowerDefense -- Defending Konstantinople
The game is a classic Tower Defense game. Defend your city by putting down towers and survive as best as you can. There are three different types of towers. IntroCS students that shoot straight at the monsters, APCS students that shoot bullets that follow monsters, and SoftDev students that shoot bombs that explode. There are features like those of a classic TD. You can upgrade them to different paths, sell them, etc. Try it out and see if you can best the monsters!

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
- Should have committed more often for the buttons in the beginning.. but created button objects that store towers and when clicked, they load their respective tower into the game and onto the mouse and places when the mouse presses onto the map (Jo)
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
- Finished Mortar Tower and fixed issues with concurrent modification (Qiong)
- Tuned the Mortar Tower and the strengths of monsters, created a boss known as BossK (Qiong)
- Created game Over menu (Qiong)
