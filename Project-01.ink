/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

// VARIABLES
VAR HP = 3
VAR has_sword = false
VAR has_key = false
VAR has_potion = false

// START
-> intro

=== intro ===
The Ancient Tower of Evil is a place long forbidden and feared by all who know its name.  
Once raised by dark sorcery, the tower now lies in ruins, yet its power has never faded.  

Within these walls lies a prize greater than gold: the Dragon Bone Sword.  
Its blade carries immense strength—and a terrible burden.  

You are now standing in front of the **Dark Gate**.  

+ [Push open the Dark Gate and step inside] -> courtyard
+ [Turn away—the legends are too terrifying] -> coward

=== coward ===
Fear grips your heart, and you leave the cursed tower behind.  
You will never know the power—or the burden—of the Dragon Bone Sword.  
-> END

=== courtyard ===
You step into the hall.  

The **Dark Gate** slams shut immediately behind you.  

Ahead, you see **three paths**:  

The **Main stairs** lead to the Throne Room.  
The **Left stair** descends into the Dungeon.  
The **Right stair** winds upward toward the Roof.  

+ [Climb the main staircase to the Throne Room] -> approach_throne
+ [Take the left stair into the Dungeon] -> dungeon
+ [Take the right stair to the Roof] -> roof_initial

=== dungeon ===
You descend the narrow stair into the **Dungeon**.  
The air is damp and smells of mold. Broken chains hang from the walls.  

You notice a **rusty sword** lying on the ground.  

+ [Pick up the sword] -> dungeon_sword
+ [Leave it and return to the hall] -> dungeon_no_sword

=== dungeon_sword ===
You pick up the rusty sword.  
It’s not as powerful as the Dragon Bone Sword, but it will **help you survive** the skeleton fight.  

~ has_sword = true

+ [Return to the hall] -> courtyard

=== dungeon_no_sword ===
You decide to leave the sword behind.  

+ [Return to the hall] -> courtyard

=== roof_initial ===
You climb toward the **roof**. Loose stones make footing treacherous.  

You notice a **small chest wedged between two stones**.  

+ [Open the chest] -> roof_chest
+ [Return to the hall] -> courtyard

=== roof_chest ===
You open the chest and find a **potion of healing**.  

~ has_potion = true

+ [Return to the roof] -> roof_initial

=== approach_throne ===
You step closer to the throne, heart pounding.  

The skeleton of the king suddenly rises, bones creaking, eyes hollow.  
You hear it whisper: You should not have come here...

+ [Fight the skeleton] -> fight_skeleton

=== fight_skeleton ===
{ has_sword:
    ~ HP -= 1  // player loses 1 HP (from 3)
    The skeleton **crumbles into a heap of bones**.  
    A **key** falls from its hand.  
    ~ has_key = true
- else:
    The skeleton overpowers you. You have **no weapon** to defend yourself.  
    -> DEAD
}

With the skeleton defeated, the floor beneath your feet **cracks violently**, molten lava bubbling below.  
There is **no going back**.  

{ has_key:
    You notice a **small keyhole** in the wall behind the throne.  
    + [Use the key on the hidden door] -> secret_chamber
    + [Ignore the hidden door and proceed to the two doors] -> choose_two_doors
- else:
    + [Proceed to the two doors] -> choose_two_doors
}

=== secret_chamber ===
You insert the key into the keyhole. A section of the wall slides open, revealing a **hidden chamber**.  
Inside, you find **ancient scrolls and carvings** telling the true history of the tower and its king.  

You learn that the Dragon Bone Sword was created to **bind the king’s spirit**, and anyone who wields it risks being consumed by its dark magic.  

+ [Return to the throne room and choose a door] -> choose_two_doors

=== choose_two_doors ===
Ahead, you see **two doors**:  
- Left: glowing with a green spiral light  
- Right: dark and narrow, floor cracked  

Once you choose a door, **there is no turning back**.  

+ [Take the left door] -> left_path
+ [Take the right door] -> right_path

=== left_path ===
You push open the left door.  
The green light spirals around a pedestal holding the **Dragon Bone Sword**.  

+ [Approach the sword] -> sword_choice

=== right_path ===
You step into the dark passage.  
The floor **cracks beneath your feet**, and you stumble, falling slightly.  

~ HP -= 1  // lose 1 HP

There is **no turning back**.  
You carefully follow a narrow path, which eventually leads you to the **Dragon Bone Sword**.  

+ [Approach the sword] -> sword_choice

=== sword_choice ===
The Dragon Bone Sword pulses with energy.  

+ [Take the sword and claim its power] -> take_sword
+ [Leave the sword and step away] -> leave_sword

=== take_sword ===
You grasp the Dragon Bone Sword.  

~ HP -= 2  // sword drains 2 HP

{ HP < 1:
    The sword's magic is too powerful. You collapse.  
    -> DEAD
- else:
    You survive at **1 HP**.  
    The dark magic courses through you.  
    You feel **stronger than ever**, and a desire rises to **destroy what is left of the world** and **rule over everyone**.  

    You are the **Dark King**.  

    -> dark_king_ending
}

=== leave_sword ===
You step back, resisting the lure of the Dragon Bone Sword.  
Its power is too dangerous; you must **keep it safe from everyone**.  

-> safe_ending

=== DEAD ===
The tower consumes you. The dark magic overwhelms your body.  
-> END

=== dark_king_ending ===
The tower trembles under your newfound power.  
You are the **Dark King**, master of the Dragon Bone Sword.  
All who oppose you will fall; nothing can stop your domination.  

-> END

=== safe_ending ===
You leave the sword untouched.  
Its power is too dangerous; you must **keep it safe from everyone**.  

You survive the tower, but the cursed sword remains, waiting.  

-> END
