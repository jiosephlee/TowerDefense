# TowerDefense
The Best Processing Tower Defense Game of all time. jk but it's pretty good

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
- Should have committed more often for the buttons in the beginning.. but created button objects that store towers and when clicked, they load their respective tower into the game and onto the mouse and places when the mouse presses onto the map. (Jo)
- Wrote followBullet projectile which locks onto a monster and follows it. Figuring out what to do when the monster it locked onto died, and when it died unexpectedly (for ex, another tower kills it first) in a clean and efficient way took some time but I got it eventually.(Jo)
