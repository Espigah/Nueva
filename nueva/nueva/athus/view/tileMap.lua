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

---Modulo para auxiliar a criacao de cenario utilizando tiles.
--Modulo nao testado devidamente devido a possiveis problemas com o ambiente de testes.
module ('nueva.athus.view.tileMap', package.seeall)

TileMap = {}
Class_Metatable = { __index = TileMap }
local gameObject = require 'nueva.athus.view.gameObject';

--- Funcao de heranca.
--@see athus.view.gameObject
function inherit(  )
    local new_class = {}
    local Class_Metatable = { __index = new_class }

--- Construtor do modulo TileMap.<br>
-- @param width largura da area de desenho dos tiles.
-- @param height altura da area de desenho dos tiles.
-- @param matrix matriz com os tiles.<br> Cada segmento da matriz e uma tabela contendo
-- o id do tile, e seu tipo. <br>O id de refere a posicao do tile no tileSet, e o tipo[
-- para auxiliar na logica do jogo, de forma que: o valor 1 indica um tile navegavel, 
--e valores maiores que 1 indicao tiles especiais, sendo retornado a colisao verdadeira com
-- este valor.
--ok.
-- @name TileMap:new 
	function new_class:new(width , height , matrix, set)
	    
	    local temp = {};
		setmetatable( temp, Class_Metatable );
	
		temp.matriz = matrix;
				
		temp.set = set;
		
		temp.img = canvas:new(path);
		
		temp.width, temp.height = temp.img:attrSize();
		
		temp.x0 = 3;
		temp.y0 = 3;
		
		temp.moveX = 0;
		temp.moveY = 0;
		
	    return temp;
	end
	    
	    
    if gameObject.GameObject then
        setmetatable( new_class, { __index = gameObject.GameObject } )
    end
    
    return new_class
    
end

TileMap = inherit()

---Funcao movimentar a area de desenho do mapa de tiles.
--@param x quantidade de ixels em x para movimentar. Negativo para ir para esquerda.
--@param y quantidade de ixels em y para movimentar. Negativo para subir.
--Not ok.
function TileMap:move(x, y)

end

--Funcao de desenho no canvas
--ok
function TileMap:draw()
	
	--Mediadas do tile
	local w = self.set:getTileSize()[1];
	local h = self.set:getTileSize()[2];

	--medidas da matriz de desenho
	local mc = math.floor( self.height/h ) + 2;
	if	mc + self.y0 > #self.matriz then
		mc = #self.matriz;
	end
	
	local yc = self.y0;
	local xc = self.x0; 
	
	if yc > 1 then
		yc = yc -1;
	end
	
	if xc > 1 then
		xc = xc -1;
	end
		
	for i = yc , mc do
		
		local ml = math.floor( self.width/w ) + 2;
		if	ml + self.x0 > #self.matriz[i] then
			ml = #self.matriz[i];
		end		
		
		for j = xc, ml do
			
			self.set:setTile(self.matriz[i][j][1]);
			self.img:compose( (j - xc -1) * w + self.moveX, (i - yc -1) * h + self.moveY, self.set:getImg());

		end
			
	end
		
end


---Funcao que extrai a imagem correspondente ao objeto.
--@return canvas correspondente ao objeto.
function TileMap:getImg()
	return self.img;
end

---Funcao para setar os tiles iniciais de desenho.
--@param line linah inicial.
--@param column coluna inicial.
function TileMap:setStartingTiles(line,column)
	self.x0 = line;
	self.y0 = column;
end


