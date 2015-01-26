-Name: Madison Tilden
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

WITH ada.text_IO; USE ada.Text_IO;
WITH Ada.Integer_Text_IO; USE Ada.Integer_Text_IO;
WITH dynamic_queue_pkg;
WITH dynamic_stack_pkg;
PROCEDURE compete IS
	  
	  TYPE Player IS RECORD
		  Name : String(1 .. 20);
		  Arrival_Num: Natural;
		  Skill: Integer;
		  Wins: Integer := 0;
		  Losses: Integer := 0;
	  END RECORD;
	  type Player_Ptr is access Player;
	  PACKAGE ContestQueue IS NEW dynamic_queue_pkg(Player_Ptr);
	  USE ContestQueue;
	  PACKAGE ContestStack IS NEW dynamic_stack_pkg(Player_Ptr);
	  USE ContestStack;
	  
	  PlayerInfo : Queue; 		-- holds all the players names and information
	  OneLoss: Queue;
	  TwoLosses: Stack;

	  Player_Counter: Natural := 0; 	-- arrival number counter
-----------------------------------------------------
-----------------------------------------------------	  
    PROCEDURE get_player_info(PlayerInfo: IN OUT Queue; Player_Counter: IN OUT Integer) IS
  		Plyr_Ptr : Player_ptr;			-- player one
  	BEGIN
  			Plyr_Ptr := new Player;
    		get(Plyr_Ptr.all.Name);
    		Player_Counter := Player_Counter + 1;
  			Plyr_Ptr.all.Arrival_Num := Player_Counter;
    		get(Plyr_Ptr.all.Skill);
    		enqueue(Plyr_Ptr, PlayerInfo);
   	END get_player_info;

-----------------------------------------------------
-----------------------------------------------------
	PROCEDURE round1(PlayerInfo: IN OUT Queue; OneLoss: IN OUT Queue;
		 										Player_Counter: IN Integer) IS
  	   Plyr1_Ptr : Player_ptr;			-- player one
  	   Plyr2_Ptr : Player_ptr;			-- player two
		BEGIN
			FOR Z IN 1 .. (Player_Counter - 1) LOOP
				Plyr1_Ptr := Front(PlayerInfo);
				Dequeue(PlayerInfo);
				Plyr2_Ptr := Front(PlayerInfo);
				Dequeue(PlayerInfo);
				-----------------------------------------------------
				IF Plyr1_Ptr.all.Skill > Plyr2_Ptr.all.Skill THEN-- player one has a higher skill level
					Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
					Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
					Enqueue(Plyr1_Ptr, PlayerInfo);
					Enqueue(Plyr2_Ptr, OneLoss);
				ELSIF Plyr1_Ptr.all.Skill < Plyr2_Ptr.all.Skill THEN-- player 2 has a higher skill
					Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1;
					Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
					Enqueue(Plyr2_Ptr, PlayerInfo);
					Enqueue(Plyr1_Ptr, OneLoss);
				ELSE						-- Players have the same skill level
				-----------------------------------------------------
				-- if player 1 and 2 skill levels are the same then 
				-- the winner is decided by who has more wins
				  IF Plyr1_Ptr.all.Wins > Plyr2_Ptr.all.Wins THEN
					  Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
					  Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
					  Enqueue(Plyr1_Ptr, PlayerInfo);
					  Enqueue(Plyr2_Ptr, OneLoss);
				  ELSIF Plyr1_Ptr.all.Wins < Plyr2_Ptr.all.Wins THEN
					  Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1;
					  Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
					  Enqueue(Plyr1_Ptr, PlayerInfo);
					  Enqueue(Plyr2_Ptr, OneLoss);
				  ELSE	
				  -----------------------------------------------------
	              -- if plyr1 and plyr2 number of wins are equal then 
				  -- the winner is decided by who has less losses
					 IF Plyr1_Ptr.all.Losses > Plyr2_Ptr.all.Losses THEN
   					     Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
   					     Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
   					     Enqueue(Plyr1_Ptr, PlayerInfo);
   					     Enqueue(Plyr2_Ptr, OneLoss); 
					 ELSIF Plyr1_Ptr.all.Losses < Plyr2_Ptr.all.Losses THEN
	   					 Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1;
	   					 Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
	   					 Enqueue(Plyr2_Ptr, PlayerInfo);
	   					 Enqueue(Plyr1_Ptr, OneLoss);
					 ELSE
					 -----------------------------------------------------
					 -- IF STILL A TIE THEN IT IS DECIDED BY WHO ARRIVED FIRST 
					   IF Plyr1_Ptr.all.Arrival_Num > Plyr2_Ptr.all.Arrival_Num THEN
     					   Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
     					   Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
     					   Enqueue(Plyr1_Ptr, PlayerInfo);
     					   Enqueue(Plyr2_Ptr, OneLoss);
					   ELSIF Plyr1_Ptr.all.Arrival_Num < Plyr2_Ptr.all.Arrival_Num THEN
 					       Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
 					       Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
 					       Enqueue(Plyr1_Ptr, PlayerInfo);
 					       Enqueue(Plyr2_Ptr, OneLoss); 
					   ELSE
						   put("Something is seriously wrong here Maddy .... round 1");
					   END IF;  -- END IF FOR ARRIVAL NUMBER
					END IF; -- END IF FOR NUMBER OF LOSSES CHECK
				  END IF;  -- END IF FOR NUMBER OF WINS CHECK
				END IF;-- END IF FOR SKILL LEVEL CHECK
			END LOOP; -- END MAIN FOR LOOP
	END round1;
-----------------------------------------------------
-----------------------------------------------------
	PROCEDURE round2(OneLoss: IN OUT Queue; TwoLosses: IN OUT STACK; Player_Counter: IN Natural) IS
   	   Plyr1_Ptr : Player_ptr;			-- player one
   	   Plyr2_Ptr : Player_ptr;			-- player two
	BEGIN
		FOR B IN 1 .. (Player_Counter - 2) LOOP
		  Plyr1_Ptr := Front(OneLoss);
		  Dequeue(OneLoss);
		  Plyr2_Ptr := Front(OneLoss);
		  Dequeue(OneLoss);
		  IF Plyr1_Ptr.all.Skill > Plyr2_Ptr.all.Skill THEN
			 Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
			 Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
			 Enqueue(Plyr1_Ptr, OneLoss);
			 Push(Plyr2_Ptr, TwoLosses);
		  ElSIF Plyr1_Ptr.all.Skill < Plyr2_Ptr.all.Skill THEN
 			 Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
 			 Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1;
 			 Enqueue(Plyr2_Ptr, OneLoss);
 			 Push(Plyr1_Ptr, TwoLosses);
		  
		  ELSE 	-- the skills are equal next check is by who has more wins
			IF Plyr1_Ptr.all.Wins > Plyr2_Ptr.all.Wins THEN
			   Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
			   Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
			   Enqueue(Plyr1_Ptr, OneLoss);
			   Push(Plyr2_Ptr, TwoLosses);
			ElSIF Plyr1_Ptr.all.Wins < Plyr2_Ptr.all.Wins THEN
	 		   Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
	 		   Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1;
	 		   Enqueue(Plyr2_Ptr, OneLoss);
	 		   Push(Plyr1_Ptr, TwoLosses);
			ELSE -- if player one and player two have the same wins, we then check losses
			  IF Plyr1_Ptr.all.Losses > Plyr2_Ptr.all.Losses THEN
			     Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
				 Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
				 Enqueue(Plyr1_Ptr, OneLoss);
				 Push(Plyr2_Ptr, TwoLosses);
			  ElSIF Plyr1_Ptr.all.Losses < Plyr2_Ptr.all.Losses THEN
		 	     Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
		 	     Plyr1_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
		 	     Enqueue(Plyr2_Ptr, OneLoss);
		 	     Push(Plyr1_Ptr, TwoLosses);
			  ELSE -- if the losses are the same too then determined by wh oarrived first
				  IF Plyr1_Ptr.all.Arrival_Num > Plyr2_Ptr.all.Arrival_Num THEN
		  			   Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
		  			   Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
		  			   Enqueue(Plyr1_Ptr, OneLoss);
		  			   Push(Plyr2_Ptr, TwoLosses);
		  			ElSIF Plyr1_Ptr.all.Arrival_Num < Plyr2_Ptr.all.Arrival_Num THEN
		  	 		   Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
		  	 		   Plyr1_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
		  	 		   Enqueue(Plyr2_Ptr, OneLoss);
		  	 		   Push(Plyr1_Ptr, TwoLosses);
		  			ELSE
			  		  	put("Once again maddy, you really messed up");
					END IF; -- END ARRIVAL Number check
			   END IF; -- END LESS LOSSES CHECK
			 END IF; -- END MORE WINS CHECK 
		  END IF;   -- END IF SKILL LEVEL CHECK
		END LOOP; -- END LOOP FOR SECOND ROUND 
	END round2;

	-----------------------------------------------------
	-----------------------------------------------------
	--THE FINAL ROUND IN COMPETITION ONLY WILL BE BETWEEN 2 players (the last two)
		PROCEDURE Final_Round(PlayerInfo, OneLoss: IN OUT Queue; TwoLosses: IN OUT Stack) IS 
		   Plyr1_Ptr : Player_Ptr;			-- player one
		   Plyr2_Ptr : Player_Ptr;			-- player two
			BEGIN
				Plyr1_Ptr := Front(PlayerInfo);
				Dequeue(PlayerInfo);
				Plyr2_Ptr := Front(OneLoss);
				Dequeue(OneLoss);
				-- final round between last 2 contestants 
				-- checks by skill level first
				
				IF Plyr1_Ptr.all.Skill > Plyr2_Ptr.all.Skill THEN	-- plyr1 skill wins
	 			   Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
	 			   Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
	 			   Push(Plyr2_Ptr, TwoLosses);
	 			   Push(Plyr1_Ptr, TwoLosses);
				ELSIF Plyr1_Ptr.all.Skill < Plyr2_Ptr.all.Skill THEN	-- player2 skill wins
	  			   Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
	  			   Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1;
				   Push(Plyr1_Ptr, TwoLosses);
				   Push(Plyr2_Ptr, TwoLosses);
				ELSE
					----------- SEARCH HERE FOR ERRORS
				    IF Plyr1_Ptr.all.Wins > Plyr2_Ptr.all.Wins THEN
					  Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
	 			      Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1; 
		              Push(Plyr2_Ptr, TwoLosses);
		              Push(Plyr1_Ptr, TwoLosses);
					ELSIF Plyr1_Ptr.all.Wins < Plyr2_Ptr.all.Wins THEN
					  Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
	 			      Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1; 
		              Push(Plyr1_Ptr, TwoLosses);
		              Push(Plyr2_Ptr, TwoLosses); 
					ELSE
						IF Plyr1_Ptr.all.Losses > Plyr2_Ptr.all.Losses THEN
		  				  Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
		   			      Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1; 
		  	              Push(Plyr2_Ptr, TwoLosses);
		  	              Push(Plyr1_Ptr, TwoLosses);
						ELSIF Plyr1_Ptr.all.Losses < Plyr2_Ptr.all.Losses THEN
						  Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
		 			      Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1; 
			              Push(Plyr1_Ptr, TwoLosses);
			              Push(Plyr2_Ptr, TwoLosses);
						ELSE
							IF Plyr1_Ptr.all.Arrival_Num > Plyr2_Ptr.all.Arrival_Num THEN
		                        Plyr1_Ptr.all.Wins := Plyr1_Ptr.all.Wins + 1;
		                        Plyr2_Ptr.all.Losses := Plyr2_Ptr.all.Losses + 1;
		                        Push(Plyr2_Ptr, TwoLosses);
		                        Push(Plyr1_Ptr, TwoLosses);
							ELSIF Plyr1_Ptr.all.Arrival_Num > Plyr2_Ptr.all.Arrival_Num THEN
		                        Plyr2_Ptr.all.Wins := Plyr2_Ptr.all.Wins + 1;
		                        Plyr1_Ptr.all.Losses := Plyr1_Ptr.all.Losses + 1;
		                        Push(Plyr1_Ptr, TwoLosses);
		                        Push(Plyr2_Ptr, TwoLosses);
							ELSE 
								put("For the last time, you should never get here!");
							END IF; -- end if to check winner by arrival number
					    END IF; -- end if for who has less wins
					 END IF; -- end if for more wins    
			    END IF; -- end if for skill check
		END Final_Round;

-----------------------------------------------------
-----------------------------------------------------
--Will print out the rankings of all the players in the contest
-- in reverse order
	PROCEDURE Rankings (TwoLosses : IN OUT Stack) IS 
		BEGIN
			set_col(1);
			Put("Name");
			set_col(18);
			Put("Number");
			set_col(25);
			put("Skill");
			set_col(31);
			put("Wins");
			set_col(36);
			put("Losses");
		  WHILE NOT is_Empty(TwoLosses) LOOP
			new_line;
			Put(Top(TwoLosses).all.Name);
			--set_col(20);
			Put(Top(TwoLosses).all.Arrival_Num'img);
			--set_col(25);
			Put(Top(TwoLosses).all.Skill'img);
			--set_col(31);
			Put(Top(TwoLosses).all.Wins'img);
			--set_col(36);
			Put(Top(TwoLosses).all.Losses'img);
			pop(TwoLosses);						-- takes the top node off stack
		  END LOOP;
	END Rankings;
-----------------------------------------------------
-----------------------------------------------------

	
	BEGIN
		
		WHILE NOT END_OF_FILE LOOP
	  	   get_player_info(PlayerInfo, Player_Counter);
		END LOOP;
		   round1(PlayerInfo, OneLoss, Player_Counter);
		   round2(OneLoss, TwoLosses, Player_Counter);
		   Final_Round(PlayerInfo, OneLoss, TwoLosses);
		   Rankings(TwoLosses);
END compete;
