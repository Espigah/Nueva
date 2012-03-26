module('main', package.seeall);
--==================================================
require ('nueva/utils/BuildClass');
require ('nueva/core/Core')
--==================================================
print(">>Start")
local canvasWidth, canvasHeight = canvas:attrSize() 
--==================================================
local core = BuildClass.new("Core");
local pathImg ="resources/images/";
local sprite = core:sprite();
--==================================================
sprite:setUrlimage(pathImg .. 'aguia.png')
sprite:setWidthT(218)
sprite:setHeightT(181)
sprite:setWidthF(110)
sprite:setHeightF(63)
--==================================================
local enemie1 = sprite:build();
local enemie2 = sprite:build();
local enemie3 = sprite:build();
local enemie4 = sprite:build();
local enemie5 = sprite:build();
--==================================================
enemie1.name = "enemie1";
enemie2.name = "enemie2";
enemie3.name = "enemie3";
enemie4.name = "enemie4";
enemie5.name = "enemie5";
--==================================================
core:addSpriteInBuffer(enemie1);
core:addSpriteInBuffer(enemie2);
core:addSpriteInBuffer(enemie3);
core:addSpriteInBuffer(enemie4);
core:addSpriteInBuffer(enemie5);
--================================================== get new moving
local move = core:newMoving();
move:setSprite(enemie4);
move:setSpeed("Right",{5,0})
move:setSpeed("Left",{-5,0})
move:setSpeed("Up",{0,-5})
move:setSpeed("Down",{0,5})
--==================================================

local speed_x = 1;
local speed_y = 1;

function update()		
	core:updatePosition(enemie1,{1,0});	
	core:updatePosition(enemie2,{0,1});	
	core:updatePosition(enemie5,{speed_x,speed_y});	
	core:updatePosition(enemie4); --=======================Atualiza no render
end

core:mainloop(update)


--==================================================

local function ChangeSpeed (__dir)
	print("ChangeSpeed")
	if (__dir == "x") then
		speed_x = speed_x +1;
	elseif (__dir == "y") then
		speed_y = speed_y +1;
	end

end

core.keyboardSignals.addPressLeft:add(ChangeSpeed,"x",5);

KeyboardSignals.addPressLeft:add(move.left, move);
KeyboardSignals.addPressRight:add(move.right, move);
KeyboardSignals.addPressUp:add(move.up, move);
KeyboardSignals.addPressDown:add(move.down, move);

core.keyboardSignals.addPressGreen:add(core.setSpeedAnimation, -10);
core.keyboardSignals.addPressBlue:add(core.setSpeedAnimation, 10);
core.keyboardSignals.addPressYellow:add(core.speedAnimationReset);
--==================================================
print(">>The And")