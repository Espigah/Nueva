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

---Modulo que representa o componente fundamental do framework, que e o objeto de jogo.
--Um objeto de jogo pode representar qualquer componente grafico que sera exibido e participa
--da logica do game.
module ('nueva.athus.view.gameObject', package.seeall)

GameObject = {
	alive  = true,
	centerX = 0,
	centerY = 0,		
	img = nil,
	positionX = 0,
	positionY = 0,
	rotation = 0,
	scale = 1,
	speedX = 0,
	speedY = 0,
	widthF = 0;
	heightF = 0;
}
Class_Metatable = { __index = GameObject }

---Construtor do gameObject.
function GameObject:new ()
	local temp = {};
	setmetatable ( temp, Class_Metatable );

    return temp;
end

---Funcao para consultar se o objeto deve ser desenhado ou nao durante o loop de animacao.
--@return booleano 'true' caso esteja vivo(desenhavel) ou 'false'(caso nao seja desenhavel).
function GameObject:isAlive()
	return self.alive;
end
---Funcao para configurar se o objeto deve ser desenhado ou nao durante o loop de animacao.
--@param booleano alive 'true' para configurar o objeto vivo(desenhavel) ou 'false' (caso nao seja desenhavel).
function GameObject:setAlive(alive)
	self.alive = alive;
end

---Funcao para consultar a posicao central do objeto.
--@return uma tabela com os valores x e y(eixos) do centro. {x,y}
function GameObject:getCenter()
	return {self.centerX,self.centerY};
end
---Funcao para atribuir a posicao central do objeto.
--@param center uma tabela com os valores x e y(eixos) do centro. {x,y}
function GameObject:setCenter(center)
	self.centerX = center[1];
	self.centerY = center[2];
end

---Funcao que extrai a imagem correspondente ao objeto.
--@return canvas correspondente ao objeto.
function GameObject:getImg()
	return self.img;
end

---Funcao para consultar a posicao de desenho do objeto.
--@param center uma tabela com os valores x e y(eixos) da posicao de desenho. {x,y}
function GameObject:getPosition()
	return {self.positionX,self.positionY};
end
---Funcao para atribuir uma nova posicao de desenho do objeto.
--@param position uma tabela com os valores x e y(eixos) da posicao de desenho. {x,y}
function GameObject:setPosition(position)
	self.positionX = position[1];
	self.positionY = position[2];
end

---Funcao que consulta o valor de angulo de rotacao realizado na imagem.
--@return numero positivo de 0 a 360, indicando o angulo derotacao.
function GameObject:getRotation()
	return self.rotation;
end

---Funcao que aplica uma rotacao ao objeto.
--@usage 2do.
--@param angle angulo da rotacao a ser realizada. 
--@param x posicao no eixo X onde a rotacao sera realizada.
--@param y posicao no eixo Y onde a rotacao sera realizada.
function GameObject:rotate(angle,x,y)
	self.rotation = angle;
	-- A ser implementado;
	-- Levara em conta posicao onde se deseja rotacionar o objeto;
end

---Funcao que consulta o valor de angulo de escala realizada na imagem.
--@return numero indicando a proporcao da mudanca feita em relacao ao tamanho da imagem inicial.
function GameObject:getScale()
	return self.escala
end

---Funcao que aplica um redimensionamento no objeto.
--@param valor da proporcao a ser utilizada, sendo 1 o valor para manter o tamanho real.
--@usage 2do. 
function GameObject:scale(proportion)
	self.scale = proportion;
	--algo assim
	self.widthF = self.widthF * proportion;
	self.heightF = self.heightF * proportion;		
	-- A ser implementado;
end

---Funcao que retorna as dimensoes da imagem a ser desenhada(largura e altura).
--@return uma tabela com a largura e altura da imagem. {width,height}
function GameObject:getSize()
	return {self.widthF, self.heightF};
end
---Funcao que atribui as dimensoes da imagem a ser desenhada(largura e altura).
--@param size uma tabela com a largura e altura da imagem. {width,height}
function GameObject:setSize(size)
	self.widthF = size[1];
	self.heightF = size[2];
end

---Funcao que retorna a velocidade do objeto.
--@return uma tabela com a velocidade x e y do objeto. {vx,vy}
function GameObject:getSpeed()
	return {self.speedX,self.speedY};
end
---Funcao que atribui a velocidade do objeto.
--@param speed uma tabela com a velocidade x e y do objeto. {vx,vy}
function GameObject:setSpeed(speed)
	self.speedX = speed[1];
	self.speedY = speed[2];
end
