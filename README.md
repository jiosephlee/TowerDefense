# TowerDefense
The Best Processing Tower Defense Game of all time. jk but it's pretty good

# Development Logs

5/19
- Wrote code for background map and checking if the the area the mouse is hovering over is suitable for tower placement (Qiong)
- Created a path class with coordinates specific to the map (Qiong)

5/20
- Started Writing Towers and developed/re-structured Towers/Projectiles class and method structuring for better development flow (Jo)
- Wrote Monster class with basic move that follows the path that updates every frame (Qiong)
5/21
- Wrote Tower's attack(), the math equation for it, and started Projectiles but forgot to commit it (Jo)
- Created a Monster spawner and despawner. The spawn rate and number is based on level and monsters now deal damage to the map when they reaches the end. (Qiong)

5/22
- Implemented Firerate for Tower and almost finished working on Projectiles (Jo)
- Changed monsters to have their movement be based on Java system time. (Qiong)

5/23
- finished Projectiles and integrated it's basic mechanics into the game (Jo)
- created a graphic circle around the mouse to show validity of tower placement (Jo)
- created method for calculating movement to help towers predict monster movement (Qiong)
5/24
-caused a play and pause for the game and implemented a money system (Qiong)

5/25-5/27
- Created a main menu for the game and tweaked money system(Qiong)
- wrote methods to compensate for time elapsed when the game is paused, since spawning is based on time elapsed (Qiong)
- Wrote Red Slimes class to spawn stronger slimes at higher levels, spawns weaker slimes at death (Qiong)
