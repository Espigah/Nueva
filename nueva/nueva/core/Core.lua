module ('Core', package.seeall)
require ('nueva/utils/BaseClass');

------------------------------------------------------------------- Templates -- Trocar dofile por?
dofile ("nueva/templates/bufferTable.lua")
dofile ("nueva/templates/functionTable.lua")
-------------------------------------------------------------------Classes
require ("nueva/collisions/Collisions");
require ("nueva/core/Sprite");
require ("nueva/core/Moving");
require ("nueva/core/Render");

local collisionsClass =  BuildClass.new("Collisions");
local spriteClass =   BuildClass.new("Sprite");
local movingClass =   BuildClass.new("Moving"); 
local render  =   BuildClass.new("Render"); 
-------------------------------------------------------------------
require ("nueva/events/KeyboardSignals");
------------------------------------------------------------------- athus file
local animationClass = require'nueva.athus.core.animation';
local engineClass = require'nueva.athus.core.engine';
local padInteraction = require'nueva.athus.interaction.pad';
local tween = require 'nueva/utils/tween';

local animation = animationClass.Animation:new();
-------------------------------------------------------------------
local speedAnimation = 100;
-------------------------------------------------------------------
render.functionTable = functionTable;
render.bufferTable = bufferTable;
-------------------------------------------------------------------
Core = 
{
	renderingByGroup = false;
	render = render; -- pra facilitar
	keyboardSignals = KeyboardSignals; -- pra facilitar
}
local concreteClass = BaseClass.create(Core);
function Core:new()	
	  return setmetatable({}, concreteClass)
end

-------------------------------------------------------------------
function Core:updatePosition(__sprite, __speed)	
	if (__speed)
	then
		self:updatePositionBySpeed(__sprite, __speed);
	else		
		self:updatePositionOnly(__sprite);
	end	
end

function Core:updatePositionOnly(__sprite)
	local speedTemp = __sprite:getSpeed();
	local positionTemp = __sprite:getPosition();		
	__sprite:setPosition({positionTemp[1] + speedTemp[1] , positionTemp[2] + speedTemp[2]});
end

function Core:updatePositionBySpeed(__sprite, __speed)
	__sprite:setSpeed(__speed);
	Core:updatePosition(__sprite)
	__sprite:setSpeed({0,0});
end


function Core:setSpeedAnimation(__speed)		
	speedAnimation =  __speed;
	animation:setPeriod(speedAnimation);	
end

function Core:getSpeedAnimation()		
	return speedAnimation;
end
function  Core:speedAnimationReset ()			
	speedAnimation = 100;
	animation:setPeriod(speedAnimation);
end


--====================================================mainloop
function Core:mainloop(__update)		
	animation:setTween(tween,speedAnimation);
	animation:setPeriod(speedAnimation);		
	if self.renderingByGroup then	
		animation:start(__update, render.updateByGroup);
	else		
		animation:start(__update, render.updateDraw); 
	end			
end
--====================================================delegate
function Core:addSpriteInBuffer(__sprite)	
	addSpriteInBuffer(__sprite)			
end

function Core:addSpriteInBufferAt(__sprite, __index)		
	addSpriteInBufferAt(__sprite, __index)		
end

function Core:swapSpriteInBufferAt(__sprite, __index)	
	swapSpriteInBufferAt(__sprite, __index)		
end

function Core:removeSpriteInBuffer(__sprite)		
	removeSpriteInBuffer(__sprite)		
end

function Core:removeSpriteInBufferAt(__index)		
	removeSpriteInBufferAt(__index)			
end

--
function Core:addFunctionInBuffer(__function)		
	addFunctionInBuffer(__function)		
end

function Core:addFunctionInBufferAt(__function, __index)			
	addFunctionInBufferAt(__function, __index)		
end

function Core:swapFunctionInBufferAt(__function, __index)	
	swapFunctionInBufferAt(__function, __index)	
end

function Core:removeFunctionInBuffer(__function)		
	removeFunctionInBuffer(__function)			
end

function Core:removeFunctionInBufferAt(__index)	
	removeFunctionInBufferAt(__index)		
end

--==================================================== get class
function Core:collisions()	
	return	collisionsClass;
end
function Core:sprite()		
	return	spriteClass;
end
function Core:newMoving()	
	return	movingClass --.__index:new();
end
function Core:getKeyboardSignals()	
	return	KeyboardSignals;
end

function Core:getTween()	
	return	tween;
end