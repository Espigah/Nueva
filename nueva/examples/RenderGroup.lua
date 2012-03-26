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
core.renderingByGroup = true;
--==================================================
--@1 nome do grupo
--@2 intervalo de renderização
core.render:createGroup ("gupo1",2);
core.render:createGroup ("gupo2",2);
--==================================================
--@1 sprite
--@2 group name
core.render:addSpriteInGroup(enemie1,"gupo1");
core.render:addSpriteInGroup(enemie2,"gupo1");
core.render:addSpriteInGroup(enemie3,"gupo1");
core.render:addSpriteInGroup(enemie4,"gupo2");
core.render:addSpriteInGroup(enemie5,"gupo2");
--==================================================
function update()		
	core:updatePosition(enemie1,{1,0});	
	core:updatePosition(enemie2,{0,1});	
	core:updatePosition(enemie5,{1,1});	
end

core:mainloop(update)
print(">>The And")
