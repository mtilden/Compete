WITH Unchecked_Deallocation;
PACKAGE BODY dynamic_queue_pkg IS
----------------------------------------------------------
-- Purpose: Performs multiplication by repeated addition
PROCEDURE dispose IS NEW Unchecked_Deallocation (
	Object => QueueNode, Name => QueueNodePointer);
--------------------------------------------------------
--------------------------------------------------------
	FUNCTION  is_Empty(Q: Queue) RETURN Boolean IS
		BEGIN
			IF q.Front = null THEN
				RETURN true;
			ELSE
				RETURN false;
			END IF;
	END is_Empty;
--------------------------------------------------------
--------------------------------------------------------
	FUNCTION  is_Full(Q: Queue) RETURN Boolean IS
		  temp : Queue;
		BEGIN
			temp.Front := new QueueNode;
			Dispose(temp.Front);
			RETURN false;
		EXCEPTION
		    WHEN STORAGE_ERROR => RETURN true;
	END is_Full;
--------------------------------------------------------
--------------------------------------------------------
    FUNCTION  front(Q: Queue) RETURN ItemType IS
		BEGIN RETURN Q.Front.Data;
	END front;
--------------------------------------------------------
--------------------------------------------------------
    PROCEDURE enqueue (Item: ItemType; Q: IN OUT Queue) IS
		BEGIN
			IF is_Full(Q) THEN							-- CHECKS IF QUEUE IS FULL OR NOT
				RAISE Queue_Full;						-- RAISE FULL QUEUE IF TRUE
			ELSIF Q.Front = NULL THEN					-- ELSE IF THE FRONT NODE DOESNT POINT TO ANYTHING/ NULL
				Q.Front := NEW QueueNode'(Item, NULL);	-- CREATE A NEW NODE AND SET THE BACK = TO THE FRONT
				Q.Back := Q.Front;
			ELSE
				Q.Back.Next := NEW QueueNode'(Item, NULL);	
				Q.Back := Q.Back.Next;					-- ELSE SET THE BACK EQUAL TO BACK.NEXT
			END IF;
	END enqueue;
--------------------------------------------------------
--------------------------------------------------------

    PROCEDURE dequeue (Q: IN OUT Queue) IS
		tmp : Queue;
		BEGIN 
		IF is_Empty(Q) THEN
			RAISE Queue_Empty;
		ELSE
			tmp.Front := Q.Front.Next;
			Dispose(Q.Front);
			Q.Front := tmp.Front;
		END IF;
	END dequeue;	
--------------------------------------------------------
--------------------------------------------------------
	
END dynamic_queue_pkg;
