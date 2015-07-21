functionTable={}


function addFunctionInBuffer(__function)	
	table.insert(functionTable,__function)
end

function addFunctionInBufferAt(__function, __index)		
	table.insert(functionTable,__index,__function)
end

function swapFunctionInBufferAt(__function, __index)
	local wasRemoved= removeFunctionInBuffer(__function);	
	if (wasRemoved) then		
		table.insert(functionTable,__index,__function);
	end
end

--remove the first element
function removeFunctionInBuffer(__function)		
	local index;
	local value;	
	for index,value in ipairs(bufferTable) do	
	 	if value == __function then
	 		removeFunctionInBufferAt (index);
	 		return true;
	 	end	 
	  end
	  return false;
end

function removeFunctionInBufferAt(__index)		
	table.remove(functionTable,__index)
end
