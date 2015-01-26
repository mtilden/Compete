WITH Unchecked_Deallocation;
PACKAGE BODY dynamic_stack_pkg IS
----------------------------------------------------------
--Deletes a node and its object
    PROCEDURE Dispose IS
       NEW Unchecked_Deallocation (Object => StackNode,
           Name   => Stack);
--------------------------------------------------------
--------------------------------------------------------
	FUNCTION is_Empty(S: Stack) RETURN Boolean IS
		
		BEGIN
			IF S = NULL THEN
				RETURN True;
			ELSE
				RETURN false;
			END IF;
	END is_Empty;
--------------------------------------------------------
--------------------------------------------------------
	FUNCTION is_Full(S: Stack) RETURN Boolean IS
		temp: Stack;
		BEGIN
			temp := new StackNode;
			Dispose(temp);
			RETURN false;
		EXCEPTION
			WHEN STORAGE_ERROR => RETURN true;
	END is_Full;
--------------------------------------------------------
--------------------------------------------------------
	PROCEDURE push(Item: ItemType; S : IN OUT Stack) IS
		BEGIN
			IF is_Full(S) THEN
				RAISE Stack_Full;
			ELSE
				S := new StackNode'(Item, S);
			END IF;
	END PUSH;
--------------------------------------------------------
--------------------------------------------------------
	PROCEDURE pop(S : IN OUT Stack) IS
		temp : Stack;
		BEGIN
			IF is_Empty(S) THEN 
				RAISE Stack_Empty with "There is nothing in your stack.";
			ELSE
				temp := S.Next;
				Dispose(S);
				s := temp;
			END IF;
	END pop;
--------------------------------------------------------
--------------------------------------------------------
	FUNCTION top(S: Stack) RETURN ItemType IS
		BEGIN RETURN S.Item;
	END top;
--------------------------------------------------------
--------------------------------------------------------
END dynamic_stack_pkg;
