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

---Modulo para controle de desenho da imagens na tela.
--Implementa a tecnica de 
--Double Buffer, que consiste em desenhar todos os graficos necessarios em uma imagem
--guardada na memoria (o buffer) e depois que todos desenhos foram feitos na imagem,
--esta e desenhada na tela. 
module ('nueva.athus.core.engine', package.seeall)

Engine = {
		tempi = nil,
	}
Class_Metatable = { __index = Engine }

---Construtor do Modulo Engine.
function Engine:new ()

	local temp = {}

    setmetatable ( temp, Class_Metatable )

	return temp;
end

---Funcao que bufferiza o grafico a ser desenhado no buffer da aplicacao.
--@usage um objeto bufferizado primeiro, sera sobreposto pelos objetos bufferizados por ultimo.
--@param obj objeto que contem a imagem a ser desenhada na tela, sendo este objeto do tipo gameObjeto ou herdeiro deste.
--@see athus.view.gameObject
function Engine:buffer(obj)
	if obj:isAlive() == true then
		local temp = obj:getPosition();
		canvas:compose(temp[1],temp[2],obj:getImg());
	end
end

--Funcao que limpa toda a tela, para que a nova tela seja posteriormente desenhada.
function Engine:clean()
	canvas:clear();
end

--Funcao que atualiza a tela, desenhando na mesma tudo que esta retido no buffer.
function Engine:refresh()
	canvas:flush();
end
