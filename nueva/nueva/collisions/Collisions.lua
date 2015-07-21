module ('Collisions', package.seeall)
require ('nueva/utils/BaseClass');
--dofile ("myGame/templates/bufferTable.lua");
Collisions = 
{
}
local concreteClass = BaseClass.create(Collisions);
function Collisions:new()	
  return setmetatable({}, concreteClass)
end
----------------------------------------------------------------------------------

