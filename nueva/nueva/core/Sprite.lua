module ('Sprite', package.seeall)

require ('nueva/utils/BaseClass');
local spriteView = require'nueva.athus.view.sprite'

Sprite =
{		
	urlImg = "";
	bitmap = nil;
	sprite=nil,
	widthT=nil,
	heightT=nil,
	widthF=nil,
	heightF=nil
}

local concreteClass = BaseClass.create(Sprite);

function Sprite:new()
  return setmetatable({}, concreteClass)
end

function  Sprite:setUrlimage(__urlImg)
	self.urlImg = __urlImg;	
end
--================================================
function  Sprite:setWidthT(__urlImg)
	self.widthT = __urlImg;	
end
function  Sprite:setHeightT(__urlImg)
	self.heightT = __urlImg;	
end
--================================================
function  Sprite:setWidthF(__urlImg)
	self.widthF = __urlImg;	
end

function  Sprite:setHeightF(__urlImg)
	self.heightF = __urlImg;	
end

function  Sprite:build()
	self.sprite = spriteView.Sprite:new();	
	self.sprite:build (self.urlImg , self.widthT , self.heightT, self.widthF , self.heightF)	
	self.bitmap = self.sprite:getBitmap();
	return self.sprite;
end

-- @__usePath true or false
-- ainda nao esta funcionando
function  Sprite:newCopy(__usePath) 

		local newobj = self:copy(self)	
		local newSprite = require'nueva.athus.view.sprite';	 -- temporario	
		newobj.sprite = newSprite.Sprite:new() ; 		
		if not(__usePath) then
			--solução? copiar todos os pixels do userdate
			newobj.sprite:setBitmap (self.bitmap )
			newobj.sprite:setWidth (self.widthT)
			newobj.sprite:setHeigh (self.heightT)
			newobj.sprite:setFrame (self.widthF,self.heightF)	
			newobj.sprite:initialize();
		else
			newobj.sprite:build (self.urlImg , self.widthT , self.heightT, self.widthF , self.heightF)
		end
	
	return newobj	
end


