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
core.renderingByGroup = true;
--==================================================
--@1 nome do grupo
--@2 intervalo de renderiza��o
core.render:createGroup ("gupo1",2);
core.render:createGroup ("gupo2",2);
--==================================================
--@1 sprite
--@2 group name
core.render:addSpriteInGroup(enemy1,"gupo1");
core.render:addSpriteInGroup(enemy2,"gupo1");
core.render:addSpriteInGroup(enemy3,"gupo1");
core.render:addSpriteInGroup(enemy4,"gupo2");
core.render:addSpriteInGroup(enemy5,"gupo2");
--==================================================
function update()		
	core:updatePosition(enemy1,{1,0});	
	core:updatePosition(enemy2,{0,1});	
	core:updatePosition(enemy5,{1,1});	
end

core:mainloop(update)
print(">>The And")