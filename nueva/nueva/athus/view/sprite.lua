--[[	
	Athus, a framework for Ginga based applications.
Copyright (C) 2011, Ricardo Mendes Costa Segundo

	This file is part of Athus.

	Athus is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or any later version.

	Athus is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
along with Athus.  If not, see <http://www.gnu.org/licenses/>.
]]--

---Modulo que representa um tipo especifico de objeto de jogo, o tipo Sprite. 
-- Sprites são os conjuntos de dados, ou no nosso caso imagens, 
-- que definem determinado objeto ou personagem num jogo.
module ('nueva.athus.view.sprite', package.seeall)
local gameObject = require 'nueva.athus.view.gameObject';

--- Funcao de heranca.
--@see athus.view.gameObject
function inherit(  )
    local new_class = {}
    local class_mt = { __index = new_class }

	--- Construtor do modulo Sprite.
	-- @param path caminho para a imagem que constitui a sequencia de imagens que forma o Sprite.
	-- @param tw largura total em pixels da imagem.
	-- @param th altura total em pixels da imagem.
	-- @param fw largura dos frames em pixels do Sprite.
	-- @param fh altura dos frames em pixels do Sprite.
	-- @usage os frames devem ser alinhados vertical e horizontalmente. Cada coluna de frames correspnde a um estado de animacao, por exemplo, caminhar para esquerda ou caminhar para direita. e cada linha corresponde a um frame de tal animacao, sendo assim o retangulo de frames deve estar completamente preenchido.
	-- @name Sprite:new 
    function new_class:new(path , tw , th , fw , fh)

        local temp = {};
		setmetatable( temp, class_mt );

		temp.img = nil--canvas:new(path);
		temp.widthT = nil--tw;
		temp.heightT =nil-- th;
		temp.widthF = nil--fw;
		temp.heightF = nil--fh;
	
		temp.states = nil--tw/fw;
		temp.frames = nil--th/fh;
	
		temp.state = 0;
		temp.frame = 1;
		temp.first = true;	
        return temp
    end

    if gameObject.GameObject then
        setmetatable( new_class, { __index = gameObject.GameObject } )
    end

    return new_class
end

Sprite = inherit()


---Funcao que extrai a imagem correspondente ao objeto.
--@return canvas correspondente ao objeto.
function Sprite:getImg()
	if self.first then
		self:nextFrame();
		self.first = false;
	end
	return self.img;
end

--- Funcao que diz qual a sequencia de animacao deve ser utilizada executada, ou seja, qual coluna de frames deve ser utilizada.
--@param newState numero que identifica qual coluna de frames deve ser utilizada. 
function Sprite:setState(newState)
	if newState > self.states -1 then
		self.state = self.states -1;
	else
		self.state = newState;
	end
	
	self:nextFrame();
end

---Funcao que retorna em qual sequencia a animacao se encontra.
--@return numero com a coluna correspondente.
function Sprite:getState()
	return self.state;
end

---Funcao que desloca a animcao para o proximo frame, ou seja, proxima linha.
function Sprite:nextFrame()
	if self.frame < self.frames-1 then
		self.frame = self.frame + 1;
	else
		self.frame = 0;
	end
	self.img:attrCrop (
				self.state * self.widthF ,
				self.frame * self.heightF,
				self.widthF ,
				self.heightF);
end

---------------------------------------------------------------------------

function Sprite:build(path , tw , th , fw , fh)

		self.img = canvas:new(path);	
		self.widthT = tw;
		self.heightT = th;
		self.widthF = fw;
		self.heightF = fh;
	
		self.states = tw/fw;
		self.frames = th/fh;
	
		self.state = 0;
		self.frame = -1;
		self.first = true;	
	--return self;
end

function Sprite:setFrame( fw , fh)	
	self.widthF = fw;
	self.heightF = fh;		
end
function Sprite:setWidth( value)	
	self.widthT = value;	
end
function Sprite:setHeigh( value)	
	self.heightT = value;	
end
function Sprite:setBitmap(value)
	self.img = value;
end
function Sprite:getBitmap()
	return self.img ;
end

function Sprite:initialize() -- fazer de uma forma melhor
		self.states = self.widthT/self.widthF;
		self.frames = self.heightT/self.heightF;
	
		self.state = 0;
		self.frame = -1;
		self.first = true;	
end
