# Complete


--Name: Madison Tilden
--Date: December 05, 2014
--Purpose: program simulates a double elimination contest
-- After all players have been input, pairs of players are
-- repeatedly formed and the members of a pair play a match
-- against each other. As described below, the skill level
-- (and perhaps some other information) determines who wins the match.
-- Players are eliminated from the competition when they have two losses.

--The sequence of play is as follows:

-- Players with no losses play matches until only one remains with no losses.
-- Then, players with one loss continue to play matches 
-- until only one player remains with one loss.
-- Finally, the two players who have exactly zero and 
--one losses play one or two matches until one of them has exactly 
--two losses (and the other has zero or one loss).

--The output of your program should consist of the following information for each player, in columns with one line per player:

--Name
--Arrival number
--Skill level
--Number of wins
--Number of losses
