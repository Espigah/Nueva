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
local enemy1 = sprite:build();
local enemy2 = sprite:build();
local enemy3 = sprite:build();
local enemy4 = sprite:build();
local enemy5 = sprite:build();
--==================================================
enemy1.name = "enemy1";
enemy2.name = "enemy2";
enemy3.name = "enemy3";
enemy4.name = "enemy4";
enemy5.name = "enemy5";
--==================================================
core:addSpriteInBuffer(enemy1);
core:addSpriteInBuffer(enemy2);
core:addSpriteInBuffer(enemy3);
core:addSpriteInBuffer(enemy4);
core:addSpriteInBuffer(enemy5);
--==================================================

local speed_x = 1;
local speed_y = 1;

function update()		
	core:updatePosition(enemy1,{1,0});	
	core:updatePosition(enemy2,{0,1});	
	core:updatePosition(enemy5,{speed_x,speed_y});	
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


core.keyboardSignals.addPressGreen:add(core.setSpeedAnimation, -10);
core.keyboardSignals.addPressBlue:add(core.setSpeedAnimation, 10);
core.keyboardSignals.addPressYellow:add(core.speedAnimationReset);
--==================================================
print(">>The And")