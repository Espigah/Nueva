module ('Moving', package.seeall)


require ('nueva/utils/BaseClass');

local currentspeed;
Moving = 
{
	spirte = nill;
	speed = {0,0};
	isMoving = false;
	speedRight = {};
	speedLeft = {};
	speedUp = {};
	speedDown = {};
}
local concreteClass = BaseClass.create(Moving)

function Moving:new()
  return setmetatable({}, concreteClass)
end

function Moving:setSprite (__sprite)
	self.spirte = __sprite;	
end

function Moving:setSpeed (__dir, __speedTable)
	self["speed"..__dir] = __speedTable;
end

function Moving:right ()	
	self.spirte:setSpeed(self.speedRight);
end
function Moving:left ()	
	self.spirte:setSpeed(self.speedLeft);
end

function Moving:up ()
	self.spirte:setSpeed(self.speedUp);
end

function Moving:down ()
	self.spirte:setSpeed(self.speedDown);
end

function Moving:move ()
	self.isMoving = true; -- servindo pra nada
end

function Moving:stop ()		
	self.spirte:setSpeed({0,0});
	self.isMoving = false;
end

function Moving:pause ()	
	currentspeed = self.spirte:getSpeed();	
	self.spirte:setSpeed({0,0});
	self.isMoving = false;
end

function Moving:play ()		
	self.spirte:setSpeed(currentspeed);
	self.isMoving = true;
end