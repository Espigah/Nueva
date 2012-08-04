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

local myTween = core:getTween();
myTween(10000, enemy5, { positionX=400  , positionY=400 }, 'outBounce')

function update()	
	core:updatePosition(enemy1,{1,0});	
	core:updatePosition(enemy2,{0,1});	
end

core:mainloop(update)
print(">>The And")
