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

---Modulo para auxiliar o uso de Tiles na aplicacao.
module ('nueva.athus.view.tileSet', package.seeall)

TileSet = {}
Class_Metatable = { __index = TileSet }

--- Construtor do modulo TileSet.
-- @param path caminho para a imagem que contém os tiles.
-- @param w largura total em pixels da imagem.
-- @param h altura total em pixels da imagem.
-- @param tw largura dos frames em pixels dos tiles.
-- @param th altura dos frames em pixels dos tiles.
-- @usage os tiles devem estar alinhados horizontal e verticalmente, preenchendo linhas e colunas. 
function TileSet:new(path , w , h , tw , th)
    local temp = {};
	setmetatable( temp, Class_Metatable );

	temp.img = canvas:new(path);
	temp.width = w;
	temp.height = h;
	temp.widthT = tw;
	temp.heightT = th;

	temp.columns = w/tw;
	temp.lines = h/th;

	temp.pc = 0;
	temp.pl = 0;
	
	temp.tile = 1;
	
	temp.img:attrCrop (
			temp.pc * temp.widthT ,
			temp.pl * temp.heightT,
			temp.widthT ,
			temp.heightT);

    return temp;
end

---Funcao para consultar o numero de tiles disponiveis.
--@return numero de tiles disponiveis no tileSet.
function TileSet:getTiles()
	return self.columns * self.lines;
end

---Funcao que extrai a imagem correspondente ao objeto.
--@return canvas correspondente ao objeto.
function TileSet:getImg()
	return self.img;
end

---Funcao de consulta do tamanho do tile.
--@return tabela com a largura e açtura dos tiles. {width, height}
function TileSet:getTileSize()
	return {self.widthT, self.heightT};
end

---Funcao para setar o tile de desenho desejado.
--@param tile valor da posicao do tile, aumentanod em uma unidade da esquerda para direita
-- e ao final da linha continuando na linha seguinte.
function TileSet:setTile(tile)
	print(tile)
	if self.tile == tile then
		return
	else 
		
		self.pl = math.floor(tile/self.columns);
		self.pc = (tile - self.pl*self.columns) - 1;
		
		self.img:attrCrop (
					self.pc * self.widthT ,
					self.pl * self.heightT,
					self.widthT ,
					self.heightT);
	end
end
