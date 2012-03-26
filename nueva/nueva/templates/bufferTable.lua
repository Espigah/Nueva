bufferTable={}


function addSpriteInBuffer(__sprite)	
	table.insert(bufferTable,__sprite)
end

function addSpriteInBufferAt(__sprite, __index)		
	table.insert(bufferTable,__index,__sprite)
end

function swapSpriteInBufferAt(__sprite, __index)
	local wasRemoved= removeSpriteInBuffer(__sprite);	
	if (wasRemoved) then		
		table.insert(bufferTable,__index,__sprite);
	end
end

--remove the first element
function removeSpriteInBuffer(__sprite)		
	local index;
	local value;	
	for index,value in ipairs(bufferTable) do	
	 	if value == __sprite then
	 		removeSpriteInBufferAt (index);
	 		return true;
	 	end	 
	  end
	  return false;
end

function removeSpriteInBufferAt(__index)		
	table.remove(bufferTable,__index)
end

